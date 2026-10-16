import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/shared_preferns.dart';
import '../../responses/get_address_response.dart';
import '../../responses/get_cart_response.dart';
import '../../utils/app_pages.dart';
import 'package:http/http.dart' as http;

const bool checkoutTestMode = bool.fromEnvironment(
  'CHECKOUT_TEST_MODE',
  defaultValue: false,
);

class CartController extends GetxController {
  RxList<CardItems> cardItemList = <CardItems>[].obs;
  RxInt quantity = 1.obs;
  RxList<AddressList> addressList = <AddressList>[].obs;
  final _razorpay = Razorpay();
  RxInt total = 0.obs;
  RxBool isLoading = false.obs;
  RxBool cartLoading = false.obs;
  RxBool deleteItem = false.obs;
  final selectedTimeSlot = RxString('Select a delivery time slot');
  final dateController = TextEditingController();
  RxList<String> itemsBeingDeleted = <String>[].obs;
  String dateForApi = '';
  DateTime? deliveryDate;
  RxBool checkoutEnable = true.obs;
  RxInt startTime = 0.obs;
  RxInt endTime = 0.obs;
  String startTimeApi = '';
  String endTimeApi = '';
  void onTimeSlotChanged(String? value) {
    selectedTimeSlot.value = value ?? '';
    if (selectedTimeSlot.value == 'Select a delivery time slot') {
    } else {
      validateTimeSlotForCartItems(selectedTimeSlot.value);
    }
  }

  RxString zoneName = ''.obs;

  RxInt minOrderValue = 0.obs;
  RxBool isZoneLoading = true.obs;
  Future<void> getZoneByPincode(String pincode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(SharedPrefs.keys.authToken);

    isZoneLoading.value = true; // ✅ Move this to top before try

    try {
      final response = await http.get(
        Uri.parse('https://api.mountainroots.co.in/zones/pincode/$pincode'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      print('Zone API Response Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        zoneName.value = data['data']['name'] ?? '';
        minOrderValue.value = data['data']['minOrderValue'] ?? 0;
        print('Zone name: ${zoneName.value}');
      } else {
        zoneName.value = '';
        print("Zone API failed: ${response.statusCode}");
      }
    } catch (e) {
      zoneName.value = '';
      print("Zone API error: $e");
    } finally {
      isZoneLoading.value = false; // ✅ Always stop loading even on error
    }
  }

// void checkCartItemsAvailability(selectedTimeSlot) {
//   String selectedTimeSlotValue = selectedTimeSlot; // Directly assign the string value
//   List<String> unavailableItems = [];
//
//   for (var item in cardItemList) {
//     String itemStartTime = item.productItem!.product!.timeSlot!.startTime;
//     String itemEndTime = item.productItem!.product!.timeSlot!.endTime;
//
//     // Convert selected time slot to start and end time
//     List<String> selectedTimeParts = selectedTimeSlotValue.split(' - ');
//     String selectedStartTime = convertTo24HourFormat(selectedTimeParts[0]); // Convert to 24-hour format
//     String selectedEndTime = convertTo24HourFormat(selectedTimeParts[1]);   // Convert to 24-hour format
//
//     // Compare selected time with item's time slot
//     if (compareTime(selectedStartTime, itemStartTime) < 0 || compareTime(selectedEndTime, itemEndTime) > 0) {
//       unavailableItems.add(item.productItem!.product!.name!);
//     }
//   }
//
//   if (unavailableItems.isNotEmpty) {
//     // Display error message with unavailable items
//     String errorMessage = "The following items are not available during the selected time slot:\n";
//     errorMessage += unavailableItems.join("\n");
//     // Show error message to the user
//     // You can use Get.snackbar or any other method to display the error message
//     Get.snackbar('Error', errorMessage);
//     print(errorMessage);
//   }
// }
//
// String convertTo24HourFormat(String time) {
//   final DateFormat inputFormat = DateFormat('hh:mm a');
//   final DateFormat outputFormat = DateFormat('HH:mm');
//   final DateTime dateTime = inputFormat.parse(time);
//   return outputFormat.format(dateTime);
// }
//
//
//   // Function to display error message if no items are available in selected time slot
// void showErrorMessage(List<CardItems> itemsNotAvailable) {
//   final itemNames = itemsNotAvailable.map((item) => item.productItem!.product!.name).join(', ');
//   Get.dialog(
//     AlertDialog(
//       title: CustomText(text:'Error',textStyle: TextStyles.regularText,
//         fontSize: AppSize.font16,color: Colors.black,),
//       content: CustomText(text:'The following items are not available in the selected time slot: $itemNames',textStyle: TextStyles.regularText,
//         fontSize: AppSize.font16,color: Colors.black,),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: Text('OK',style: TextStyle(color: Colors.red),),
//         ),
//       ],
//     ),
//   );
// }

// // Function to validate selected time slot for all items in the cart
//   // Function to check if the selected time slot is within the available time range of an item
//   bool isTimeSlotAvailableForItem(String selectedTimeSlot, String itemTimeSlot) {
//     // Split the item's time slot into start and end time
//     List<String> slotParts = itemTimeSlot.split(' - ');
//     String itemStartTime = slotParts[0];
//     String itemEndTime = slotParts[1];
//
//     // Split the selected time slot into start and end time
//     List<String> selectedSlotParts = selectedTimeSlot.split(' - ');
//     String selectedStartTime = selectedSlotParts[0];
//     String selectedEndTime = selectedSlotParts[1];
//
//     // Check if selected time slot falls within the available time range
//     return selectedStartTime.compareTo(itemStartTime) >= 0 && selectedEndTime.compareTo(itemEndTime) < 0;
//   }

  // Function to convert time to 24-hour format

  int convertTo24HourFormat(String time) {
    // Check if the time contains 'AM' or 'PM'
    if (time.contains('AM') || time.contains('PM')) {
      // Split the time string into hours, minutes, and AM/PM indicator
      List<String> parts = time.split(' ');
      int hour = int.parse(parts[0]);
      String ampm = parts[1]; // Extract AM/PM

      // Adjust the hour for PM
      if (ampm.toUpperCase() == 'PM' && hour < 12) {
        hour += 12;
      }
      print("$hour");
      // Return the time in 24-hour format
      return hour.toInt(); // Assuming minutes and seconds are 00
    } else {
      // Time is already in 24-hour format, return as is
      return 0;
    }
  }

// Function to validate selected time slot for an item
  bool isTimeSlotAvailableForItem(
      String selectedTimeSlot, String itemStartTime, String itemEndTime) {
    // Convert selected time slot to 24-hour format
    List<String> selectedParts = selectedTimeSlot.split(' - ');
    print("selectedpartone${selectedParts[0]}");
    print("selectedparttwo${selectedParts[1]}");
    int selectedStartTime = convertTo24HourFormat(selectedParts[0]);
    int selectedEndTime = convertTo24HourFormat(selectedParts[1]);

//     int year = deliveryDate!.year;
//     int month = deliveryDate!.month;
//     int day = deliveryDate!.day;
//
//     DateTime dateTime = DateTime(year,month,day, selectedStartTime);
//
// print("datetimem ${dateTime.toIso8601String()}");

    startTime.value = selectedStartTime;
    endTime.value = selectedEndTime;

    int itemStartHour = int.parse(itemStartTime.split(':')[0].trim());
    int itemEndHour = int.parse(itemEndTime.split(':')[0].trim());

    print(
        "selected strt time is $selectedStartTime selected end time $selectedEndTime");
    print("item strt time is $itemStartHour item end time $itemEndHour");
    // Compare selected start and end times with item start and end times
    bool isAvailable =
        selectedStartTime >= itemStartHour && selectedEndTime <= itemEndHour;
    print("condition is $isAvailable");
    return isAvailable;
  }

// Function to validate selected time slot for all items in the cart
  void validateTimeSlotForCartItems(String selectedTimeSlot) {
    List<String> unavailableItems = [];

    // Iterate through each item in the cart
    for (var item in cardItemList) {
      // Get the item's start and end times from the API response
      String itemStartTime = item.productItem!.product!.timeSlot!.startTime;
      String itemEndTime = item.productItem!.product!.timeSlot!.endTime;

      // Check if the item's time slot intersects with the selected time slot
      if (!isTimeSlotAvailableForItem(
          selectedTimeSlot, itemStartTime, itemEndTime)) {
        // Add the item to the list of unavailable items
        unavailableItems.add(item.productItem!.product!.name!);
      }
    }

    // If there are unavailable items, show an error message
    if (unavailableItems.isNotEmpty) {
      checkoutEnable.value = false;
      // Show error message with names of unavailable items
      String errorMessage =
          'The following items are not available for the selected time slot: ${unavailableItems.join(", ")}';
      // Show error message
      print(errorMessage);
      Get.snackbar("Alert", errorMessage,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3));
      // Handle error message display in your UI
    } else {
      checkoutEnable.value = true;
      // No unavailable items, proceed with the selected time slot
      print('All items are available for the selected time slot');
      // Proceed with the selected time slot
    }
  }

  @override
  void onInit() {
    print("cartcontroller called");
    getCartItems();
    getAddress();
    super.onInit();
  }

  @override
  void onReady() {
    getCartItems();
    getAddress();
    super.onReady();
  }

  @override
  void onClose() {
    dateController.clear();
    super.onClose();
  }

// Function to compare time strings in HH:MM format
  int compareTime(String time1, String time2) {
    List<String> time1Parts = time1.split(':');
    List<String> time2Parts = time2.split(':');

    int hour1 = int.parse(time1Parts[0]);
    int minute1 = int.parse(time1Parts[1]);
    int hour2 = int.parse(time2Parts[0]);
    int minute2 = int.parse(time2Parts[1]);

    if (hour1 == hour2) {
      return minute1.compareTo(minute2);
    } else {
      return hour1.compareTo(hour2);
    }
  }

  getCartItems() {
    cardItemList.clear();
    cartLoading.value = true;
    var res = ApiResponse().getCartItems().then((value) {
      debugPrint("valuee $value");
      if (value != null) {
        value.data != null ? cardItemList.value = value.data!.cardItems! : [];
        Get.find<DashboardController>().cardItemList.value =
            value.data != null ? value.data!.cardItems! : [];
        cartLoading.value = false;
      } else {
        cartLoading.value = false;
      }
    });
    debugPrint("valueressse $res");
  }

  Future<void> getAddress() async {
    print("Fetching address list...");
    final value = await ApiResponse().getAddress();

    if (value != null) {
      addressList.value = value.addressList!;
      print("Address list fetched: ${addressList.length}");
    } else {
      print("Failed to fetch address list");
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < cardItemList.length) {
      cardItemList[index].count.value++; // Update RxInt value directly
      addToCart(index, cardItemList[index].count.value);
      update();
    }
  }

  void decrementQuantity(int index) {
    print(
        "minimum quantity is ${cardItemList[index].productItem?.product?.minOrderQuantity}");
    if (cardItemList[index].productItem?.product?.minOrderQuantity != null &&
        int.tryParse(
                cardItemList[index].productItem!.product!.minOrderQuantity!) !=
            null &&
        cardItemList[index].count.value >
            int.parse(
                cardItemList[index].productItem!.product!.minOrderQuantity!)) {
      if (index >= 0 && index < cardItemList.length) {
        if (cardItemList[index].count.value > 1) {
          // Ensure count doesn't go below 1
          cardItemList[index].count.value--; // Update RxInt value directly
          addToCart(index, cardItemList[index].count.value);
        }
        update();
      }
    } else {
      Get.snackbar(
        "Error",
        "Minimum order quantity is ${cardItemList[index].productItem?.product?.minOrderQuantity}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void removeItem(id) async {
    itemsBeingDeleted.add(id);
    await ApiResponse().removeCartItem(id);
    getCartItems();
    update();
  }

  void addToCart(int index, int quantity) async {
    var item = cardItemList[index];
    var data = {
      "productItemId": item.productItem!.id.toString(),
      "quantity": quantity,
    };
    var res = await ApiResponse().addToCart(data);
    if (res == true) {
      // Item added successfully, update the cart
      // getCartItems();
    }
  }

  void makePayment() async {
    var options = {
      // 'key': 'rzp_test_1DP5mmOlF5G5ag',
      'key': 'rzp_test_20ehf0UXoP2fhm',
      'amount': 2300,
      'name': 'Old Delhi Food',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9876543210', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Get.snackbar(
        "Alert",
        "Something is wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

// Function to show a dialog
  Future<void> showDeliveryDurationDialog(BuildContext context) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Some items in your cart will take 2-3 days to deliver.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> checkoutDetail(
      String addressId,
      int subTotal,
      List cardItemList,
      List<AddressList> addressList,
      String date,
      String startTime,
      String endTime,
      BuildContext context) async {
    try {
      void showCheckoutError(String message) {
        final visibleMessage = message.trim().isEmpty
            ? 'No item is deliverable for the selected address and time.'
            : message.trim();

        showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text(
              'Checkout unavailable',
              style: TextStyle(color: Colors.black),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Text(
                visibleMessage,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      isLoading.value = true;
      if (checkoutTestMode) {
        Get.toNamed(
          AppPages.checkoutScreen,
          arguments: {
            'subTotal': subTotal,
            'deliveryFee': 0,
            'totalPrice': subTotal,
            'selectedList': cardItemList,
            'selectedAddress': addressId,
            'addressList': addressList,
            'deliveryDate': date,
            'startTime': startTime,
            'endTime': endTime,
          },
        );
        isLoading.value = false;
        return;
      }

      var res = await ApiResponse().getCheckOutDetails(addressId);
      final responseData = res["data"];
      if (res["status"] == true && responseData is Map) {
        // Handle status true (200)
        final deliveryCharge = responseData["deliveryCharge"];
        if (deliveryCharge is! num) {
          isLoading.value = false;
          showCheckoutError(
              "Checkout response did not include a delivery charge.");
          return;
        }
        if (res["isAllIndia"] == true) {
          //show dialog
          showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Alert',
                  style: TextStyle(color: Colors.black),
                ),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        'Some items in your cart will take 2-3 days to deliver.',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: InkWell(
                      child: Container(
                          height: 30,
                          width: Get.size.width * 0.5,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: const Center(
                              child: Text(
                            'OK',
                            style: TextStyle(color: Colors.white),
                          ))),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.toNamed(
                          AppPages.checkoutScreen,
                          arguments: {
                            'subTotal': subTotal,
                            'deliveryFee': deliveryCharge,
                            'totalPrice': subTotal + deliveryCharge,
                            'selectedList': cardItemList,
                            'selectedAddress':
                                addressId, // Pass the selected list here
                            'addressList': addressList,
                            'deliveryDate': date,
                            'startTime': startTime,
                            'endTime': endTime,
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          Get.toNamed(
            AppPages.checkoutScreen,
            arguments: {
              'subTotal': subTotal,
              'deliveryFee': deliveryCharge,
              'totalPrice': subTotal + deliveryCharge,
              'selectedList': cardItemList,
              'selectedAddress': addressId, // Pass the selected list here
              'addressList': addressList,
              'deliveryDate': date,
              'startTime': startTime,
              'endTime': endTime,
            },
          );
        }
        print("Delivery Charge: $deliveryCharge");
        isLoading.value = false;
        // Get.toNamed( AppPages.checkoutScreen,
        //   arguments: {
        //     'subTotal': subTotal,
        //     'deliveryFee':deliveryCharge,
        //     'totalPrice': subTotal+deliveryCharge,
        //     'selectedList': cardItemList,
        //     'selectedAddress': addressId,  // Pass the selected list here
        //     'addressList':addressList,
        //     'deliveryDate':date,
        //     'startTime':startTime,
        //     'endTime':endTime,
        //   },
        // );
      } else {
        isLoading.value = false;
        final responseMessage = res["message"]?.toString().trim() ?? '';
        final responseData = res["data"];
        String? productName;
        if (responseData is List && responseData.isNotEmpty) {
          final firstItem = responseData.first;
          if (firstItem is Map && firstItem["productItem"] is Map) {
            final product = firstItem["productItem"]["product"];
            if (product is Map) {
              productName = product["name"]?.toString();
            }
          }
        }

        final message = responseMessage.isNotEmpty
            ? responseMessage
            : productName != null && productName.isNotEmpty
                ? "$productName is not deliverable for the selected address and time."
                : "No item is deliverable for the selected address and time.";
        showCheckoutError(message);
      }
      // } else if (res["message"] != null) {
      //   // Handle status false (400)
      //   String message = res["message"];
      //   if (res.containsKey("data") && res["data"].isNotEmpty) {
      //     String productName = res["data"][0]["productItem"]["product"]["name"];
      //     print("Message: $message");
      //     print("Product Name: $productName");
      //     isLoading.value=false;
      //
      //   } else {
      //     print("Message: $message");
      //     isLoading.value=false;
      //   }
      //   isLoading.value=false;
      //
      // }
    } catch (e) {
      isLoading.value = false;

      print(e.toString());
      // Handle exceptions
      // You can show a snackbar or toast message here
    }
  }
}
