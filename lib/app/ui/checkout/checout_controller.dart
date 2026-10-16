import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/responses/get_address_response.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../responses/add_address_response.dart' as add;
import '../../responses/pincode_response.dart';
import '../../utils/app_pages.dart';

const String razorpayKeyId = String.fromEnvironment(
  'RAZORPAY_KEY_ID',
  defaultValue: 'rzp_live_r0bBg4D6UTil03',
);

class CheckoutController extends GetxController {
  // Variables to hold subtotal and total
  int subTotal = 0;
  int totalPrice = 0;
  int deliveryFee = 0;
  RxBool otherAddress = false.obs;
  RxBool termsAccepted = false.obs;
  List selectedList = [];
  List<AddressList> addressList = [];
  String selectedAddress = '';
  String addressId = '';
  RxBool isPlaceOrderDisabled = false.obs; // RxBool to track button click
  RxBool isDeliveryCharge = false.obs;
  RxBool orderPlaced = false.obs;
  RxInt selectedValue = 2.obs;
  RxString newAddressId = ''.obs;
  String orderId = '';
  final _razorpay = Razorpay();

  final RxString startTimeError =
      RxString(''); // Initialize with empty string or appropriate value
  final RxString endTimeError =
      RxString(''); // Initialize with empty string or appropriate value

  final id = ''.obs;
  final message = ''.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final streetAddressController = TextEditingController();
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final orderNotesController = TextEditingController();
  final startTimeController =
      TextEditingController(); // New controller for start time
  final endTimeController = TextEditingController();

  String startTimeApi = '';
  String endTimeApi = '';

  @override
  void onInit() {
    super.onInit();
    selectedList = Get.arguments['selectedList'];
    // ApiResponse().removeUserCart();

    final Map<String, dynamic> args = Get.arguments;
    subTotal = args['subTotal'];
    deliveryFee = args['deliveryFee'];
    totalPrice = args['totalPrice'];
    addressId = args['selectedAddress'];
    final rawAddressList = args['addressList'];
    addressList = rawAddressList is List
        ? rawAddressList.whereType<AddressList>().toList()
        : <AddressList>[];
    dateController.text = args['deliveryDate'];
    startTimeController.text = args['startTime'];
    endTimeController.text = args['endTime'];

    if (addressList.isNotEmpty) {
      setControllerValues(addressList[0]);
    }
    print("address list count: ${addressList.length}");
    print("addressid$addressId");
    print("addresslist$addressList");
    print("starttime${startTimeController.text}");
    print("deliverydate${dateController.text}");
    print("endtime${endTimeController.text}");
  }

  @override
  void onClose() {
    // Dispose all controllers when the controller is closed
    firstNameController.dispose();
    lastNameController.dispose();
    companyNameController.dispose();
    streetAddressController.dispose();
    apartmentController.dispose();
    cityController.dispose();
    stateController.dispose();
    pincodeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dateController.dispose();
    timeController.dispose();
    orderNotesController.dispose();
    startTimeController.dispose(); // Dispose start time controller
    endTimeController.dispose(); // Dispose
    super.onClose();
  }

  void setControllerValues(AddressList addressList) {
    final address = addressList.address;
    firstNameController.text = address?.name ?? '';
    lastNameController.text = '';
    companyNameController.text = '';
    streetAddressController.text = address?.address ?? '';
    apartmentController.text = address?.address ?? '';
    cityController.text = address?.city ?? '';
    stateController.text = address?.state ?? '';
    pincodeController.text = address?.pincode?.pincode ?? '';
    phoneController.text = address?.alternatePhone ?? address?.mobile ?? '';
    emailController.text = '';
    // Set values for other controllers as needed
  }

  Future<void> addAddressAndPlaceOrder(
      add.AddressData address, String paymentMethod) async {
    var response = await ApiResponse().verifyPincode(address.pincode?.pincode);
    if (response != null) {
      if (response is PincodeResponse) {
        if (response.status == 'success') {
          id.value = response.data.id;
          Map<String, String> addressData = {
            'name': address.name ?? '',
            // 'mobile': address.mobile ?? '',
            'pincode': id.value ?? '',
            'locality': address.locality ?? '',
            'address': address.address ?? '',
            'city': address.city ?? '',
            'state': address.state ?? '',
            'landmark': address.landmark ?? '',
            // Add other fields as needed
          };
          // Add address
          // final add.AddAddressResponse? addressResponse = await ApiResponse().addAddress(addressData);
          // if (addressResponse != null && addressResponse.status == true) {
          //   final String addressId = addressResponse.data?.id ?? '';
          // Place order using the obtained address ID
          await ApiResponse()
              .placeOrder(
                  addressId,
                  paymentMethod,
                  addressData,
                  dateController.text,
                  startTimeController.text,
                  endTimeController.text)
              .then((value) async {
            // await ApiResponse().removeUserCart();
            isPlaceOrderDisabled.value = false;
            Get.offAndToNamed(AppPages.paymentSuccessfulScreen);
            Get.snackbar(
              "Alert",
              "Order Placed Successfully",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }).catchError((error) {
            isPlaceOrderDisabled.value = false; // Set loader to false
            Get.snackbar(
              "Alert",
              "Failed to place order: $error",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          });
          // } else {
          //   isPlaceOrderDisabled.value = false;
          //   Get.snackbar("Alert", "Failed to add address");
          // }
        }
      }
    } else {
      Get.snackbar(
        "Alert",
        "Enter valid billing address",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      isPlaceOrderDisabled.value = false;
    }
  }

  Future<void> addAddressAndPlaceOrderByRazorpay(
      add.AddressData address, String paymentMethod, amount) async {
    // Add address
    var response = await ApiResponse().verifyPincode(address.pincode?.pincode);
    if (response != null) {
      if (response is PincodeResponse) {
        if (response.status == 'success') {
          id.value = response.data.id;
          Map<String, String> addressData = {
            'name': address.name ?? '',
            'mobile': address.mobile ?? '',
            'pincode': id.value ?? '',
            'locality': address.locality ?? '',
            'address': address.address ?? '',
            'city': address.city ?? '',
            'state': address.state ?? '',
            'landmark': address.landmark ?? '',
            // Add other fields as needed
          };
          // final add.AddAddressResponse? addressResponse = await ApiResponse().addAddress(addressData);
          // if (addressResponse != null && addressResponse.status == true) {
          // final String addressId = addressResponse.data?.id ?? '';
          // Place order using the obtained address ID
          final orderResponse = await ApiResponse()
              .placeOrder(
                  addressId,
                  paymentMethod,
                  addressData,
                  dateController.text,
                  startTimeController.text,
                  endTimeController.text)
              .then((value) {})
              .catchError((error) {
            isPlaceOrderDisabled.value = false; // Set loader to false
            Get.snackbar(
              "Alert",
              "Failed to place order: $error",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          });
          print("orderresponse $orderResponse");
          // Make payment using Razorpay
          // makePayment(amount, orderResponse);
          isPlaceOrderDisabled.value = false;

          // } else {
          //   isPlaceOrderDisabled.value = false;
          //   Get.snackbar("Alert", "Failed to add address");
          // }
        }
      }
    } else {
      Get.snackbar(
        "Alert",
        "Enter valid billing address",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      isPlaceOrderDisabled.value = false;
    }
  }

  void makePayment(amount, razorpayOrder) async {
    print("razorpayOrder------->$razorpayOrder");
    // Safely parse the amount
    double amountInRupees;
    if (razorpayOrder['amount'] is String) {
      amountInRupees = double.tryParse(razorpayOrder['amount']) ?? 0.0;
    } else if (razorpayOrder['amount'] is int ||
        razorpayOrder['amount'] is double) {
      amountInRupees = razorpayOrder['amount'].toDouble();
    } else {
      amountInRupees = 0.0;
    }

    int amountInPaise = (amountInRupees * 100).toInt();
    print("Final amount in paise: $amountInPaise");
    Map<String, dynamic> options = {
      'key': razorpayKeyId,
      'amount': amountInPaise,
      'currency': 'INR',
      'name': 'Old Delhi Food',
      'description': razorpayOrder['entity'],
      'order_id': razorpayOrder['id'], // The order ID from Razorpay order
      // You can directly pass the other data from razorpayOrder here
      'receipt': razorpayOrder['receipt'],
      // Add other fields as needed
      'prefill': {
        'contact': razorpayOrder[
            'receipt'], // Assuming this is the user's phone number
        'email': razorpayOrder['notes']
            ['userId'], // Assuming this is the user's email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      orderPlaced.value = true;
      _razorpay.open(options);
    } catch (e) {
      orderPlaced.value = false;
      Get.snackbar(
        "Alert",
        "Something is wrong",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  void initializeRazorpay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Handle successful payment
    print("Payment Successful: ${response.data}");
    await ApiResponse().successRazorpayTransaction(
        orderId, response.orderId, response.paymentId, response.signature);
    Get.offAndToNamed(AppPages.paymentSuccessfulScreen);
    Get.snackbar(
      "Alert",
      "Order Placed Successfully",
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
    await ApiResponse().removeUserCart();
    orderPlaced.value = false;
    // Navigate to success screen or perform necessary actions
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    // Handle payment failure
    print("Payment Error: ${response.code} - ${response.message}");
    Get.offAndToNamed(AppPages.paymentUnSuccessfulScreen);
    Get.snackbar(
      "Alert",
      "Payment Failed",
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
    Get.snackbar(
      "Alert",
      "Order Placed Successfully",
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
    await ApiResponse().removeUserCart();
    orderPlaced.value = false;
    // Show error message to the user or perform necessary actions
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Get the current date
      DateTime now = DateTime.now();

      // Combine current date with picked time
      DateTime selectedDateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      String formattedTime = _formatDateTimeForDisplay(selectedDateTime);

      // Convert to ISO 8601 format
      String isoFormattedTime = selectedDateTime.toIso8601String();

      // Print or use the ISO formatted time
      print(isoFormattedTime);

      // If you need to update a controller, you can do it here
      startTimeController.text = formattedTime;
      startTimeApi = isoFormattedTime;
      startTimeError.value = '';

      // Ensure start time is less than end time
      if (endTimeController.text.isNotEmpty) {
        DateTime endTime = DateTime.parse(endTimeController.text);
        if (selectedDateTime.isAfter(endTime)) {
          // Adjust end time if start time is after end time
          endTimeController.text = formattedTime;
          endTimeApi = isoFormattedTime;

          startTimeError.value = 'Start time cannot be after end time';
        } else {
          startTimeError.value = '';
        }
      }
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Get the current date
      DateTime now = DateTime.now();

      // Combine current date with picked time
      DateTime selectedDateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      String formattedTime = _formatDateTimeForDisplay(selectedDateTime);

      // Convert to ISO 8601 format
      String isoFormattedTime = selectedDateTime.toIso8601String();

      // Print or use the ISO formatted time
      print(isoFormattedTime);

      // If you need to update a controller, you can do it here
      endTimeController.text = isoFormattedTime;
      endTimeApi = isoFormattedTime;

      endTimeError.value = '';

      // Ensure end time is greater than start time
      if (startTimeController.text.isNotEmpty) {
        DateTime startTime = DateTime.parse(startTimeController.text);
        if (selectedDateTime.isBefore(startTime)) {
          // Adjust start time if end time is before start time
          startTimeController.text = formattedTime;
          startTimeApi = isoFormattedTime;
          endTimeError.value = 'End time cannot be before start time';
        }
      }
    }
  }

  String _formatDateTimeForDisplay(DateTime dateTime) {
    return dateTime.toString().replaceFirst('T', ' ');
  }

// Future<void> selectStartTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     // Get the current date
  //     DateTime now = DateTime.now();
  //
  //     // Combine current date with picked time
  //     DateTime selectedDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
  //
  //     // Convert to ISO 8601 format
  //     String isoFormattedTime = selectedDateTime.toIso8601String();
  //
  //     // Print or use the ISO formatted time
  //     print(isoFormattedTime);
  //
  //     // If you need to update a controller, you can do it here
  //     startTimeController.text = isoFormattedTime;
  //   }
  // }
  //
  // Future<void> selectEndTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     // Get the current date
  //     DateTime now = DateTime.now();
  //
  //     // Combine current date with picked time
  //     DateTime selectedDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
  //
  //     // Convert to ISO 8601 format
  //     String isoFormattedTime = selectedDateTime.toIso8601String();
  //
  //     // Print or use the ISO formatted time
  //     print(isoFormattedTime);
  //
  //     // If you need to update a controller, you can do it here
  //     endTimeController.text = isoFormattedTime;
  //
  //     // Ensure start time is less than end time
  //     if (startTimeController.text.isNotEmpty) {
  //       DateTime startTime = DateTime.parse(startTimeController.text);
  //       if (selectedDateTime.isBefore(startTime)) {
  //         // Adjust start time if end time is before start time
  //         startTimeController.text = isoFormattedTime;
  //       }
  //     }
  //   }
  // }

// Future<void> selectEndTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     // Get the current date
  //     DateTime now = DateTime.now();
  //
  //     // Combine current date with picked time
  //     DateTime selectedDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
  //
  //     // Convert to ISO 8601 format
  //     String isoFormattedTime = selectedDateTime.toIso8601String();
  //
  //     // Print or use the ISO formatted time
  //     print(isoFormattedTime);
  //
  //     // If you need to update a controller, you can do it here
  //     endTimeController.text = isoFormattedTime;
  //   }
  // }

// checkoutDetail(){
  //   // verify pincode
  //   // add address
  // //get shipping charges
  // }

  // Future<void> checkoutDetail(add.AddressData newAddress) async {
  //     var response = await ApiResponse().verifyPincode(newAddress.pincode?.pincode);
  //     if (response != null) {
  //       if (response is PincodeResponse) {
  //         if (response.message == 'Pincode details fetched successfully') {
  //           id.value = response.data.id;
  //           Map<String, String> addressData = {
  //             'name': newAddress.name ?? '',
  //             'mobile': newAddress.mobile ?? '',
  //             'pincode': id.value ?? '',
  //             'locality': newAddress.locality ?? '',
  //             'address': newAddress.address ?? '',
  //             'city': newAddress.city ?? '',
  //             'state': newAddress.state ?? '',
  //             'landmark': newAddress.landmark ?? '',
  //             // Add other fields as needed
  //           };
  //           final add.AddAddressResponse? addressResponse = await ApiResponse().addAddress(addressData);
  //           if (addressResponse != null && addressResponse.status == true) {
  //             final String addressId = addressResponse.data?.id ?? '';
  //             newAddressId.value = addressResponse.data?.id ?? '';
  //             // Place order using the obtained address ID
  //           } else {
  //             Get.snackbar("Alert", "Failed to add address");
  //           }
  //         }
  //       }
  //     } else {
  //       Get.snackbar("Alert", "Enter valid address");
  //       isPlaceOrderDisabled.value = false;
  //
  //     }
  //
  //
  //     // Assuming you have values for these variables
  //     var addressId = 'your_address_id';
  //     var currentDate = 'your_current_date';
  //     var startTime = 'your_start_time';
  //     var endTime = 'your_end_time';
  //     var addressName = 'your_address_name';
  //     var pinCodeId = 'your_pincode';
  //     var locality = 'your_locality';
  //     var address = 'your_address';
  //     var city = 'your_city';
  //     var landmark = 'your_landmark';
  //     var state = 'your_state';
  //
  //     var res = await ApiResponse().getCheckOutDetails(
  //       addressId,
  //       currentDate,
  //       startTime,
  //       endTime,
  //       addressName,
  //       pinCodeId,
  //       locality,
  //       address,
  //       city,
  //       landmark,
  //       state,
  //     );
  //
  //     // Handle the response if needed
  //
  // }
}
