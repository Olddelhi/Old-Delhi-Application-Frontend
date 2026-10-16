import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/components/app_text_form_field.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/Home/home_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';

import '../../components/text_styles.dart';
import '../../responses/get_address_response.dart';
import '../../utils/app_pages.dart';
import 'cart_controller.dart';

class CartScreen extends StatefulWidget {
  final bool isNav;
  const CartScreen({super.key, this.isNav = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = Get.put(CartController());
  final homeController = Get.find<HomeController>();
  final RxList<AddressList> selectedAddresses = <AddressList>[].obs;
  List<String> timeSlots = [
    'Select a delivery time slot',
    '9 AM - 11 AM',
    '11 AM - 1 PM',
    '1 PM - 3 PM',
    '3 PM - 5 PM',
    '5 PM - 7 PM',
  ];

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // print('Calling getAddress...');
      await controller.getAddress();
      print('Address List: ${controller.addressList}');

      if (controller.addressList.isNotEmpty) {
        final defaultAddress = controller.addressList.firstWhere(
          (address) => address.isDefault ?? false,
          orElse: () => controller.addressList.first,
        );

        final pincode = defaultAddress.address?.pincode?.pincode;
        print('Default Pincode: $pincode');

        if (pincode != null && pincode.isNotEmpty) {
          print('Calling getZoneByPincode...');
          await controller.getZoneByPincode(pincode);
        } else {
          print('❌ Pincode is null or empty');
        }
      } else {
        print('❌ Address list is empty after getAddress');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(),
              _itemSelectedList(),
              //_couponCodeTextField(),
              /*_applyCouponButton(),*/
              _updateCartButton(),

              _cartDatail(context),
            ],
          ).paddingSymmetric(horizontal: AppSize.width10),
        ),
      ),
    );
  }

  Widget _appBar() {
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       CustomText(
    //         text: AppStrings.cart,
    //         textStyle: TextStyles.semiBoldText,
    //         fontSize: AppSize.font25,
    //         color: AppColors.cartHeadingColor,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           InkWell(
    //             onTap: (){
    //               // Get.back();
    //             },
    //             child: Image.asset(
    //               AppAssets.cartBackIcon,
    //               height: AppSize.height15,
    //               width: AppSize.width10,
    //             ),
    //           ),
    //           CustomText(
    //             text: AppStrings.continueShopping,
    //             textStyle: TextStyles.mediumText,
    //             fontSize: AppSize.font16,
    //             color: Colors.black,
    //           ),
    //         ],
    //       ).paddingSymmetric(vertical: AppSize.height15)
    //     ],
    //   ),
    // );
    return Column(
      children: [
        Row(
          children: [
            widget.isNav
                ? Container()
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      AppAssets.backIcon,
                      height: AppSize.height50,
                      width: AppSize.width50,
                    )),
            Image.asset(
              AppAssets.logoIcon,
              height: AppSize.height50,
              width: AppSize.width50,
            ),
          ],
        ),
        CustomText(
          text: "My Cart",
          color: Colors.black,
          fontSize: AppSize.font18,
          textStyle: TextStyles.boldText,
        )
      ],
    );
  }

  Widget _itemSelectedList() {
    return Obx(
      () => controller.cartLoading.value
          ? const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.cardItemList.length,
              itemBuilder: (context, index) {
                var data = controller.cardItemList[index].productItem;
                controller.total.value =
                    controller.total.value + (data?.price)!;
                return InkWell(
                  child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 5), // changes the position of the shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppSize.radius20)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Get.back();
                                  Get.toNamed(AppPages.foodDetailScreen,
                                      arguments: {"itemId": data.product?.id});
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AppSize.radius12)),
                                      child: Image.network(
                                        (data!.images?[0].url)!,
                                        height: AppSize.height60,
                                        width: AppSize.width80,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: AppSize.width200,
                                          child: CustomText(
                                            text: data.product!.name.toString(),
                                            textStyle: TextStyles.boldText,
                                            fontSize: AppSize.font16,
                                          ),
                                        ),
                                        // SizedBox(height: 10,),
                                        // SizedBox(
                                        //   width: AppSize.width200,
                                        //   child: CustomText(
                                        //     text: data.weight.toString()+'g',
                                        //     textStyle: TextStyles.boldText,
                                        //     fontSize: AppSize.font12,
                                        //   ),
                                        // ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text:
                                                  "\u{20B9}${data.price.toString()}",
                                              textStyle: TextStyles.boldText,
                                              fontSize: AppSize.font18,
                                            ).paddingOnly(
                                                top: AppSize.height10),
                                            InkWell(
                                              onTap: () {
                                                if ((controller
                                                        .cardItemList[index]
                                                        .count) >
                                                    1) {
                                                  // controller.cardItemList[index].count=(controller.cardItemList[index].count)! -1;
                                                  controller
                                                      .decrementQuantity(index);
                                                  print(controller
                                                      .cardItemList[index]
                                                      .count);
                                                } else {
                                                  controller.removeItem(
                                                      controller
                                                          .cardItemList[index]
                                                          .id);
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .orderIncreaseColor,
                                                    //shape: BoxShape.circle,
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            AppSize.radius30))),
                                                child: CustomText(
                                                  text: "-",
                                                  fontSize: AppSize.font20,
                                                ).paddingSymmetric(
                                                    horizontal: AppSize.width8),
                                              ).paddingOnly(
                                                  top: AppSize.height8,
                                                  left: AppSize.width10,
                                                  right: AppSize.width10),
                                            ),

                                            // CustomText(text: "${controller.cardItemList[index].count}", textStyle: TextStyles.boldText,
                                            //   fontSize: AppSize.font18,
                                            // ).paddingOnly(top: AppSize.height10),

                                            Obx(
                                              () => CustomText(
                                                text:
                                                    "${controller.cardItemList[index].count.value}",
                                                // Access value property
                                                textStyle: TextStyles.boldText,
                                                fontSize: AppSize.font18,
                                              ).paddingOnly(
                                                  top: AppSize.height10),
                                            ),

                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .incrementQuantity(index);
                                                print(controller
                                                    .cardItemList[index].count);
                                                // controller.cardItemList[index].count=(controller.cardItemList[index].count)! +1;
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .orderIncreaseColor,
                                                    //shape: BoxShape.circle,
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            AppSize.radius22))),
                                                child: CustomText(
                                                  text: "+",
                                                  fontSize: AppSize.font20,
                                                ).paddingSymmetric(
                                                    horizontal: AppSize.width5),
                                              ).paddingOnly(
                                                  top: AppSize.height8,
                                                  left: AppSize.width10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).paddingSymmetric(
                                        horizontal: AppSize.width10),
                                  ],
                                ),
                              ),
                              Obx(
                                () => controller.itemsBeingDeleted.contains(
                                        controller.cardItemList[index].id)
                                    ? const Expanded(
                                        child: Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.red),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          controller.deleteItem.value = true;
                                          controller.removeItem(controller
                                              .cardItemList[index].id);
                                        },
                                        child: const SizedBox(
                                          width: 15,
                                          height: 15,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ).paddingOnly(right: AppSize.width4),
                                      ),
                              ),
                            ],
                          ).paddingSymmetric(
                              horizontal: AppSize.width10,
                              vertical: AppSize.height10))
                      .paddingSymmetric(vertical: AppSize.height10),
                );
              },
            ),
    );
  }

  Widget _couponCodeTextField() {
    return const AppTextFormField(
      hintText: AppStrings.couponCode,
    );
  }

  Widget _applyCouponButton() {
    return AppButton(
      onTap: () {},
      text: AppStrings.applyCoupon.toUpperCase(),
      color: Colors.black,
    ).paddingOnly(top: AppSize.height10);
  }

  Widget _updateCartButton() {
    return AppButton(
      onTap: () {},
      text: AppStrings.updateCart.toUpperCase(),
      color: AppColors.secondary,
    ).paddingSymmetric(vertical: AppSize.height10, horizontal: AppSize.width80);
  }

  Widget _cartDatail(context) {
    return Obx(() {
      // Define a function to handle changing the address
      //controller.getAddress();
      // ✅ Fetch zone by pincode on screen load

      int subTotal = 0; // Initialize subtotal variable
      int totalPrice = 0; // Initialize subtotal variable
      // Calculate subtotal by looping through each item in the cart
      for (int index = 0; index < controller.cardItemList.length; index++) {
        var item = controller.cardItemList[index];
        int itemPrice = item.productItem?.price ?? 0; // Get item price
        int quantity = item.count.value; // Get item quantity

        subTotal += (itemPrice * quantity); // Calculate subtotal for this item
      }
      totalPrice = subTotal + 150;
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: AppStrings.cartTotal,
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font18,
                color: Colors.black,
              ),
            ),
            const Divider(thickness: 1)
                .paddingSymmetric(vertical: AppSize.height10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppStrings.subTotal.toUpperCase(),
                  textStyle: TextStyles.regularText,
                  fontSize: AppSize.font16,
                  color: Colors.black87,
                ),
                CustomText(
                  text: "\u{20B9}$subTotal",
                  textStyle: TextStyles.regularText,
                  fontSize: AppSize.font16,
                  color: Colors.black87,
                ),
              ],
            ),
            const Divider(thickness: 1)
                .paddingSymmetric(vertical: AppSize.height10),
            CustomText(
              text: AppStrings.shipping.toUpperCase(),
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font16,
              color: Colors.black87,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  if (controller.isZoneLoading.value) {
                    // Show loader only while zone API is loading
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  } else if (controller.zoneName.value == 'All India') {
                    // Show delivery delay text only for non-Delhi & All India zones
                    return CustomText(
                      text: "(Delivery within 4–5 days)",
                      textStyle: TextStyles.regularText,
                      fontSize: AppSize.font16,
                      color: Colors.black87,
                    ).paddingSymmetric(vertical: AppSize.height10);
                  } else {
                    // Nothing to show
                    return const SizedBox.shrink();
                  }
                }).paddingSymmetric(vertical: AppSize.height10),

                // CustomText(text: "\u{20B9}550.00",
                //   textStyle: TextStyles.regularText,
                //   fontSize: AppSize.font16,
                //   color: Colors.black87,),
              ],
            ).paddingOnly(top: AppSize.height5),
            Obx(() {
              if (controller.addressList.isEmpty) {
                return Container();
              } else {
                if (selectedAddresses.isNotEmpty) {
                  return CustomText(
                    text:
                        "Shipping to ${selectedAddresses[selectedAddresses.length - 1].address?.name}, ${selectedAddresses[selectedAddresses.length - 1].address?.city}, ${selectedAddresses[selectedAddresses.length - 1].address?.pincode?.pincode}, ${selectedAddresses[selectedAddresses.length - 1].address?.state}",
                    textStyle: TextStyles.regularText,
                    fontSize: AppSize.font16,
                    color: Colors.black87,
                  ).paddingSymmetric(
                    vertical: AppSize.height10,
                  );
                } else {
                  AddressList? defaultAddress =
                      controller.addressList.firstWhere(
                    (address) => address.isDefault ?? false,
                    orElse: () => controller.addressList.first,
                  );
                  return CustomText(
                    text:
                        ("Shipping to ${defaultAddress.address?.address}, ${defaultAddress.address?.landmark}, ${defaultAddress.address?.city}, ${defaultAddress.address?.pincode?.pincode}, ${defaultAddress.address?.state}"),
                    textStyle: TextStyles.regularText,
                    fontSize: AppSize.font16,
                    color: Colors.black87,
                  ).paddingSymmetric(vertical: AppSize.height10);
                }
              }
            }),
            GestureDetector(
              onTap: () {
                showAddressListDialog(context);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.black87,
                  ),
                  CustomText(
                    text: ("Change address"),
                    textStyle: TextStyles.regularText,
                    fontSize: AppSize.font16,
                    color: Colors.red,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.red,
                  )
                ],
              ).paddingSymmetric(vertical: AppSize.height10),
            ),
            subTotal != 0
                ? InkWell(
                    onTap: () {
                      _selectDate(context); // Method to show date picker
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        readOnly: true,
                        style: const TextStyle(color: Colors.black87),
                        controller: controller.dateController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Delivery Date*',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ).paddingSymmetric(vertical: AppSize.height8),
                    ),
                  )
                : Container(),
            subTotal != 0
                ? Column(children: [
                    Obx(() => Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: controller.selectedTimeSlot.value,
                                onChanged: controller.onTimeSlotChanged,
                                items: timeSlots.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: CustomText(
                                      text: value,
                                      textStyle: TextStyles.regularText,
                                      fontSize: AppSize.font16,
                                      color: Colors.red,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ))
                  ]).paddingSymmetric(horizontal: AppSize.height6)
                : Container(),
            const Divider(thickness: 1)
                .paddingSymmetric(vertical: AppSize.height10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppStrings.total,
                  textStyle: TextStyles.regularText,
                  fontSize: AppSize.font16,
                  color: Colors.black87,
                ),
                CustomText(
                  text: "\u{20B9} $subTotal",
                  textStyle: TextStyles.boldText,
                  fontSize: AppSize.font16,
                  color: Colors.black87,
                ),
              ],
            ).paddingOnly(top: AppSize.height5),
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )
                  : AppButton(
                      onTap: () {
                        // controller.makePayment();
                        // print(homeController.addressList[0].id);
                        // print(selectedAddresses[selectedAddresses.length - 1].id);
                        if (subTotal != 0) {
                          if (controller.dateController.text.isEmpty ||
                              controller.selectedTimeSlot.value.isEmpty ||
                              controller.selectedTimeSlot.value ==
                                  'Select a delivery time slot') {
                            Get.snackbar(
                              "Alert",
                              "Please select delivery date and time",
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          } else {
                            if (!controller.checkoutEnable.value) {
                              Get.snackbar(
                                "Alert",
                                "Some items are not available on selected delivery time slot",
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                              );
                            } else {
                              final deliveryDate = controller.deliveryDate;
                              if (deliveryDate == null) {
                                Get.snackbar(
                                  "Alert",
                                  "Please select a delivery date",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                                return;
                              }

                              final selectedAddress =
                                  selectedAddresses.isNotEmpty
                                      ? selectedAddresses.last
                                      : (controller.addressList.isNotEmpty
                                          ? controller.addressList.firstWhere(
                                              (address) =>
                                                  address.isDefault ?? false,
                                              orElse: () =>
                                                  controller.addressList.first,
                                            )
                                          : null);

                              final addressId = selectedAddress?.address?.id;
                              if (selectedAddress == null ||
                                  addressId == null) {
                                Get.snackbar(
                                  "Alert",
                                  "Please add a shipping address before checkout",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red,
                                );
                                return;
                              }
                              final validAddress = selectedAddress;

                              int year = deliveryDate.year;
                              int month = deliveryDate.month;
                              int day = deliveryDate.day;

                              DateTime datestartTime = DateTime(
                                  year, month, day, controller.startTime.value);
                              DateTime dateendTime = DateTime(
                                  year, month, day, controller.endTime.value);

                              print(
                                  "datetimem ${datestartTime.toIso8601String()}");
                              print(
                                  "datetendimem ${dateendTime.toIso8601String()}");
                              print(
                                  "datetendimem ${controller.dateForApi.toString()}");
                              controller.checkoutDetail(
                                  addressId,
                                  subTotal,
                                  controller.cardItemList,
                                  <AddressList>[validAddress],
                                  controller.dateForApi.toString(),
                                  datestartTime.toIso8601String().toString(),
                                  dateendTime.toIso8601String().toString(),
                                  context);
                            }
                          }
                          // Get.toNamed( AppPages.checkoutScreen,
                          //   arguments: {
                          //     'subTotal': subTotal,
                          //     'totalPrice': totalPrice,
                          //     'selectedList': controller.cardItemList,
                          //     'selectedAddress': selectedAddresses[selectedAddresses.length - 1].id,  // Pass the selected list here
                          //     'addressList':homeController.addressList,
                          //   },
                          // );
                        } else {
                          Get.snackbar(
                            "Alert",
                            "Please add item in cart first",
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      text: AppStrings.proceedToCheckOut,
                      color: AppColors.redColor,
                    ).paddingSymmetric(vertical: AppSize.height20),
            )
          ],
        ).paddingSymmetric(
            horizontal: AppSize.width10, vertical: AppSize.height10),
      );
    });
  }

// Show a dialog with the list of addresses
  void showAddressListDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select Address",
            style: TextStyles.regularText,
          ),
          content: SingleChildScrollView(
            child: ListBody(
                children: List.generate(
              controller.addressList.length,
              (index) => Column(
                children: [
                  const Divider(
                    color: Colors.red,
                  ),
                  ListTile(
                    title: CustomText(
                      text:
                          " ${controller.addressList[index].address?.name}, ${controller.addressList[index].address?.pincode?.pincode}, ${controller.addressList[index].address?.state}",
                      textStyle: TextStyles.regularText,
                      fontSize: AppSize.font16,
                      color: Colors.black87,
                    ),
                    onTap: () {
                      selectedAddresses.clear();
                      selectedAddresses.add(controller.addressList[index]);

                      final pincode = controller
                          .addressList[index].address?.pincode?.pincode;
                      if (pincode != null) {
                        controller.getZoneByPincode(pincode);
                      }

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    bool decideWhichDayToEnable(DateTime day) {
      final DateTime today = DateTime.now();

      if (day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
          !isSameDay(day, today)) {
        return true;
      }
      return false;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      selectableDayPredicate: decideWhichDayToEnable,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      // Handle the selected date, such as updating a controller or state variable
      controller.dateController.text = formattedDate.toString();
      controller.deliveryDate = pickedDate;
      controller.dateForApi = pickedDate.toIso8601String().toString();
      print(controller.dateController.text); // Update your controller
    }
  }
}
