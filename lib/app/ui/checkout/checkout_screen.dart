import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/ui/cart_screen/cart_controller.dart';
import 'package:old_delhi_food/app/ui/checkout/checout_controller.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../responses/add_address_response.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  CheckoutScreen({super.key});

  @override
  CheckoutController controller = Get.put(CheckoutController());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Obx(
                    () => Visibility(
                        visible: controller.orderPlaced.value,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        )),
                  ),
                ),
              ),
              Column(
                children: [
                  _appBar(),
                  _billingDetails(context),
                ],
              ).paddingSymmetric(horizontal: AppSize.width15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Center(
      child: Column(
        children: [
          CustomText(
            text: AppStrings.checkout,
            textStyle: TextStyles.semiBoldText,
            fontSize: AppSize.font25,
            color: Colors.black,
          ),
          Container(
            color: AppColors.containerColor,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.black45,
                      ),
                      Flexible(
                        child: CustomText(
                          text: AppStrings.haveCouponCode,
                          textStyle: TextStyles.semiBoldText,
                          fontSize: AppSize.font10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          text: AppStrings.clickHereCode,
                          textStyle: TextStyles.semiBoldText,
                          fontSize: AppSize.font10,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black45,
                        size: AppSize.height15,
                      ),
                    ],
                  ),
                ],
              ).paddingOnly(left: AppSize.width25),
            ),
          ).paddingSymmetric(
              horizontal: AppSize.width60, vertical: AppSize.height15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.cartBackIcon,
                  height: AppSize.height15,
                  color: Colors.black87,
                  width: AppSize.width10,
                ),
              ),
              CustomText(
                text: AppStrings.backToCart,
                textStyle: TextStyles.mediumText,
                fontSize: AppSize.font12,
                color: Colors.black87,
              ).paddingOnly(left: AppSize.width15),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: AppStrings.billingDetails,
              textStyle: TextStyles.boldText,
              fontSize: AppSize.font18,
              color: Colors.black,
            ).paddingSymmetric(vertical: AppSize.height10),
          ),
        ],
      ),
    );
  }

  Widget _billingDetails(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.firstNameController,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(
          labelText: 'First Name *',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height5),

      /*      TextFormField(
          style: TextStyle(color: Colors.black87),controller:controller.lastNameController,keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Last Name *',
            border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black87)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ).paddingSymmetric(vertical: AppSize.height5),*/

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.companyNameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Company Name (Optional',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          text: "India",
          textStyle: TextStyles.boldText,
          fontSize: AppSize.font16,
          color: Colors.black87,
        ).paddingSymmetric(vertical: AppSize.height8),
      ),

      // TextFormField(
      //   style: TextStyle(color: Colors.black87),controller:controller.streetAddressController,keyboardType: TextInputType.text,
      //   decoration: InputDecoration(
      //     labelText: 'Street address *',
      //     border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black87)),
      //   ),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter some text';
      //     }
      //     return null;
      //   },
      // ).paddingSymmetric(vertical: AppSize.height8),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.apartmentController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Apartment,suite,unit,etc',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.cityController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Town/City *',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.stateController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'State *',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.pincodeController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Pincode *',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Phone *',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email address *',
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      // InkWell(
      //   onTap: () {
      //     _selectDate(context); // Method to show date picker
      //   },
      //   child: AbsorbPointer(
      //     child: TextFormField(
      //       readOnly: true,
      //       style: TextStyle(color: Colors.black87),controller:controller.dateController,keyboardType: TextInputType.text,
      //       decoration: InputDecoration(
      //         hintText: 'Date *',
      //         border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black87)),
      //       ),
      //       validator: (value) {
      //         if (value == null || value.isEmpty) {
      //           return 'Please enter some text';
      //         }
      //         return null;
      //       },
      //     ).paddingSymmetric(vertical: AppSize.height8),
      //   ),
      // ),

      // TextFormField(
      //   style: TextStyle(color: Colors.black87),
      //   controller:controller.timeController,keyboardType: TextInputType.text,
      //   decoration: InputDecoration(
      //     labelText: 'Time Slot *',
      //     hintText: "09:00 AM to 11:00 AM",
      //     border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black87)),
      //   ),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter some text';
      //     }
      //     return null;
      //   },
      // ).paddingSymmetric(vertical: AppSize.height8),

      // InkWell(
      //   onTap: () {
      //     controller.selectStartTime(context); // Method to show time picker for start time
      //   },
      //   child: AbsorbPointer(
      //     child: TextFormField(
      //       readOnly: true,
      //       style: TextStyle(color: Colors.black87),
      //       controller: controller.startTimeController,
      //       keyboardType: TextInputType.text,
      //       decoration: InputDecoration(
      //         labelText: 'Start Time *',
      //         border: OutlineInputBorder(
      //           borderSide: BorderSide(color: Colors.black87),
      //         ),
      //       ),
      //
      //       validator: (value) {
      //         if (value == null || value.isEmpty) {
      //           return 'Please enter some text';
      //         }
      //         return null;
      //       },
      //     ).paddingSymmetric(vertical: AppSize.height8),
      //   ),
      // ),
      //
      // InkWell(
      //   onTap: () {
      //     controller.selectEndTime(context); // Method to show time picker for end time
      //   },
      //   child: AbsorbPointer(
      //     child: TextFormField(
      //       readOnly: true,
      //       style: TextStyle(color: Colors.black87),
      //       controller: controller.endTimeController,
      //       keyboardType: TextInputType.text,
      //       decoration: InputDecoration(
      //         labelText: 'End Time *',
      //         border: OutlineInputBorder(
      //           borderSide: BorderSide(color: Colors.black87),
      //         ),
      //       ),
      //       validator: (value) {
      //         if (value == null || value.isEmpty) {
      //           return 'Please enter some text';
      //         }
      //         return null;
      //       },
      //     ).paddingSymmetric(vertical: AppSize.height8),
      //   ),
      // ),

      Obx(
        () => Row(children: [
          Checkbox(
            value: controller.otherAddress.value,
            onChanged: (value) {
              controller.otherAddress.value = value!;
            },
          ),
          Expanded(
            child: CustomText(
              text: AppStrings.shipToDifferentAddress,
              textStyle: TextStyles.regularText,
              color: Colors.black87,
              fontSize: AppSize.font16,
            ),
          ),
          Icon(
            Icons.location_on_outlined,
            size: AppSize.height15,
          ),
        ]),
      ),

      TextFormField(
        style: const TextStyle(color: Colors.black87),
        maxLines: 4,
        decoration: const InputDecoration(
          hintText: "Order notes (Optional)",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ).paddingSymmetric(vertical: AppSize.height8),

      //  Obx(()=>
      // !controller.isDeliveryCharge.value? AppButton(
      //      onTap:
      //          (){
      //        if(controller.dateController.text.isNotEmpty&&controller.startTimeController.text.isNotEmpty&& controller.endTimeController.text.isNotEmpty){
      //    controller.isDeliveryCharge.value=true;
      //    AddressData address = AddressData(
      //      name: controller.firstNameController.text,
      //      mobile:controller.phoneController.text,
      //      pincode: Pincode(pincode:controller.pincodeController.text ),
      //      locality:controller.streetAddressController.text,address: controller.apartmentController.text,
      //      city:controller.cityController.text,state: controller.stateController.text,
      //      landmark:controller.streetAddressController.text,
      //      // Initialize other fields
      //    );}else{
      //          Get.snackbar("Alert", "Please fill delivery date and time",colorText: Colors.white,
      //            backgroundColor: Colors.red,);
      //        }
      //    // controller.checkoutDetail(address);
      //      }, color:
      //    AppColors.redColor, text: AppStrings.proceed,).paddingSymmetric(vertical: AppSize.height15):Container(),
      //  ),

      // Obx(()=>
      //     controller.isDeliveryCharge.value?

      Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: AppStrings.yourOrder,
              textStyle: TextStyles.boldText,
              fontSize: AppSize.font18,
              color: Colors.black,
            ).paddingSymmetric(vertical: AppSize.height10),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.selectedList.length,
            itemBuilder: (context, index) {
              var data = controller.selectedList[index].productItem;
              debugPrint("dataat ${controller.selectedList[index]}");
              // controller.total.value=controller.total.value+ (data?.price)!;
              return Container(
                      decoration: BoxDecoration(
                          // color: AppColors.containerColor,
                          boxShadow: const [
                            // BoxShadow(
                            //   color: Colors.grey.withOpacity(0.5),
                            //   spreadRadius: 1,
                            //   blurRadius: 4,
                            //   offset: Offset(0, 5), // changes the position of the shadow
                            // ),
                          ],
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.radius20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppSize.radius12)),
                            child: Image.network(
                              (data!.images?[0].url)!,
                              height: AppSize.height60,
                              width: AppSize.width70,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: data.product!.name.toString(),
                                  color: Colors.black87,
                                  fontSize: AppSize.font12,
                                ),
                                // Container(
                                //   decoration: BoxDecoration(
                                //       color:Colors.grey,
                                //       //shape: BoxShape.circle,
                                //       borderRadius: BorderRadius.all(Radius.circular(AppSize.radius30))
                                //   ),
                                //   child: CustomText(text: "*${controller.selectedList[index].count.value.toString()}",fontSize: AppSize.font12,).paddingSymmetric(horizontal: AppSize.width8),
                                // ).paddingOnly(left: AppSize.width10,right: AppSize.width10),
                              ],
                            ).paddingSymmetric(horizontal: AppSize.width10),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text:
                                    "x${controller.selectedList[index].count.value.toString()}",
                                textStyle: TextStyles.boldText,
                                fontSize: AppSize.font12,
                              ),
                              const SizedBox(width: 6),
                              /*  CustomText(text: "${controller.selectedList[index].productItem.weight}g", textStyle: TextStyles.boldText,
                             fontSize: AppSize.font12,
                           ).paddingOnly(top: AppSize.height2),*/
                              const SizedBox(width: 6),
                              SizedBox(
                                width: 45,
                                child: CustomText(
                                  text:
                                      "\u{20B9}${data.price * controller.selectedList[index].count.value}",
                                  textStyle: TextStyles.boldText,
                                  fontSize: AppSize.font14,
                                ).paddingOnly(top: AppSize.height5),
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(
                          horizontal: AppSize.width10,
                          vertical: AppSize.height10))
                  .paddingSymmetric(vertical: AppSize.height4);
            },
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
                text: "\u{20B9}${controller.subTotal}",
                textStyle: TextStyles.boldText,
                fontSize: AppSize.font16,
              ).paddingOnly(top: AppSize.height10),
            ],
          ),
          const Divider(thickness: 1)
              .paddingSymmetric(vertical: AppSize.height10),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: AppStrings.shipping.toUpperCase(),
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font16,
              color: Colors.black87,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                if (cartController.isZoneLoading.value) {
                  // Show loader only while zone API is loading
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else if (cartController.zoneName.value == 'All India') {
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
              CustomText(
                text: "\u{20B9}${controller.deliveryFee}",
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font16,
                color: Colors.black87,
              ),
            ],
          ).paddingOnly(top: AppSize.height5),
          const Divider(thickness: 1)
              .paddingSymmetric(vertical: AppSize.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.total.toUpperCase(),
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font16,
                color: Colors.black87,
              ),
              CustomText(
                text: "\u{20B9}${controller.totalPrice}",
                textStyle: TextStyles.boldText,
                fontSize: AppSize.font16,
              ).paddingOnly(top: AppSize.height10),
            ],
          ).paddingOnly(top: AppSize.height5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => Radio(
                  value: 1,
                  activeColor: Colors.black87,
                  groupValue: controller.selectedValue.value,
                  onChanged: (value) {
                    controller.selectedValue.value = value as int;
                  },
                ),
              ),
              Image.asset(
                AppAssets.razorpayIcon,
                height: AppSize.height25,
                width: AppSize.width100,
                fit: BoxFit.fill,
              )
            ],
          ),
          CustomText(
            text:
                "Make your payment so much faster and safest with the help of Razorpay.",
            color: Colors.black87,
            fontSize: AppSize.font12,
          ).paddingOnly(left: 50, right: 50),
          const Divider(thickness: 1)
              .paddingSymmetric(vertical: AppSize.height10),
          Row(
            children: [
              Obx(
                () => Radio(
                  value: 2,
                  activeColor: Colors.black87,
                  groupValue: controller.selectedValue.value,
                  onChanged: (value) {
                    controller.selectedValue.value = value as int;
                  },
                ),
              ),
              CustomText(
                text: AppStrings.cashOnDelivery,
                color: Colors.black87,
                fontSize: AppSize.font15,
              ),
            ],
          ),
          const Divider(thickness: 1)
              .paddingSymmetric(vertical: AppSize.height5),
          CustomText(
            text: "Your personal data will be use to process your order, "
                "support your experience throughout this website and for other purposes described in privacy policy.",
            color: Colors.black87,
            fontSize: AppSize.font12,
          ),
          const Divider(thickness: 1)
              .paddingSymmetric(vertical: AppSize.height5),
          Obx(
            () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Checkbox(
                    value: controller.termsAccepted.value,
                    onChanged: (value) {
                      controller.termsAccepted.value = value ?? false;
                    },
                  ),
                  Flexible(
                    child: CustomText(
                      text: AppStrings.agreeToTerms,
                      textStyle: TextStyles.regularText,
                      color: Colors.black87,
                      fontSize: AppSize.font14,
                    ),
                  ),
                ]),
          ),
          Obx(
            () => controller.isPlaceOrderDisabled.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    )),
                  )
                : AppButton(
                    onTap: () {
                      if (!controller.termsAccepted.value) {
                        Get.snackbar(
                          "Alert",
                          "Please agree to the terms and conditions",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                        return;
                      }
                      if (controller.emailController.text.isEmpty) {
                        Get.snackbar(
                          "Alert",
                          "Please fill email address",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      } else {
                        controller.isPlaceOrderDisabled.value = true;
                        AddressData address = AddressData(
                          name: controller.firstNameController.text,
                          mobile: controller.phoneController.text,
                          pincode: Pincode(
                              pincode: controller.pincodeController.text),
                          locality: controller.apartmentController.text,
                          address: controller.apartmentController.text,
                          city: controller.cityController.text,
                          state: controller.stateController.text,
                          landmark: controller.apartmentController.text,
                        );
                        if (controller.selectedValue.value == 1) {
                          controller.initializeRazorpay();
                          controller.addAddressAndPlaceOrderByRazorpay(
                              address, 'RAZORPAY', controller.totalPrice);
                        } else if (controller.selectedValue.value == 2) {
                          controller.addAddressAndPlaceOrder(
                              address, 'CASH_ON_DELIVERY');
                        }
                      }
                    },
                    text: AppStrings.placeOrder,
                    color: AppColors.redColor,
                  ).paddingSymmetric(vertical: AppSize.height15),
          ),
        ],
      )
      // :Container(),
      // ),
    ]);
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   bool isSameDay(DateTime date1, DateTime date2) {
  //     return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  //   }
  //
  //   bool _decideWhichDayToEnable(DateTime day) {
  //     final DateTime today = DateTime.now();
  //
  //     if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))&& !isSameDay(day, today)) {
  //       return true;
  //     }
  //     return false;
  //   }
  //
  //
  //
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now().add(Duration(days: 1)),
  //     firstDate: DateTime(2022),
  //     lastDate: DateTime(2025),
  //     selectableDayPredicate: _decideWhichDayToEnable,
  //   );
  //
  //   if (pickedDate != null) {
  //     // Handle the selected date, such as updating a controller or state variable
  //     controller.dateController.text = pickedDate.toIso8601String().toString();
  //     print(controller.dateController.text);// Update your controller
  //   }
  // }
}
