import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/ui/my_addresses/my_addresses_controller.dart';

import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';
import 'add_new_address_form.dart';

class MyAddressesScreen extends GetView<MyAddressesController> {
  MyAddressesScreen({super.key});

  @override
  MyAddressesController controller = Get.put(MyAddressesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ));
              } else {
                return Expanded(
                  child: _addressContainer()
                      .paddingSymmetric(vertical: AppSize.height15),
                );
              }
            }),
            _addAddressButton().paddingSymmetric(vertical: AppSize.height15),
          ],
        ).paddingSymmetric(horizontal: AppSize.width10),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Image.asset(
              AppAssets.backIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: CustomText(
            text: AppStrings.myAddress,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    );
  }

  Widget _addressContainer() {
    return ListView.builder(
      itemCount: controller.addressList.length,
      itemBuilder: (context, index) {
        var address = controller.addressList[index].address!;
        return Container(
          margin: EdgeInsets.only(bottom: AppSize.height15),
          decoration: BoxDecoration(
            color: AppColors.containerColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20)),
          ),
          child: _profileInfoRow(AppAssets.homeAddressIcon, address.name!,
                  address.address!, index)
              .paddingSymmetric(
                  horizontal: AppSize.width10, vertical: AppSize.height10),
        );
      },
    );
  }

  Widget _profileInfoRow(String icon, String text, String value, index) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Align items at the start and end of the row
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                height: AppSize.height30,
                width: AppSize.width35,
                fit: BoxFit.fill,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.size.width * 0.5,
                    child: CustomText(
                      text: text.toUpperCase(),
                      textStyle: TextStyles.mediumText,
                      fontSize: AppSize.font13,
                    ).paddingSymmetric(
                        horizontal: AppSize.width15, vertical: AppSize.height5),
                  ),
                  SizedBox(
                    width: Get.size.width * 0.5,
                    child: CustomText(
                      text: value,
                      textStyle: TextStyles.regularText,
                      color: Colors.black45,
                      fontSize: AppSize.font15,
                    ).paddingSymmetric(
                        horizontal: AppSize.width15, vertical: AppSize.height5),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              // Obx(() {
              //   final isLoading = controller.loadingMap[controller.addressList[index].id];
              //   return isLoading ?? false? const CircularProgressIndicator(
              //     valueColor: AlwaysStoppedAnimation<Color>(
              //         Colors.red),
              //   ) :
              //   controller.addressList[index].isDefault != null &&
              //       controller.addressList[index].isDefault! ? Container(
              //     width: 60, height: 30,
              //     decoration: BoxDecoration(
              //       // color: Colors.red,
              //         borderRadius: BorderRadius.all(Radius.circular(24)),
              //         border: Border.all(color: Colors.grey)),
              //     child: Center(
              //       child: Text('Default', style: TextStyle(
              //           fontSize: 10, color: Colors.grey),
              //         textAlign: TextAlign.center,
              //       ).paddingOnly(right: AppSize.width5),
              //     ),
              //   ) : InkWell(
              //     onTap: () {
              //       controller.makeAddressDefault(
              //           controller.addressList[index].id!);
              //     },
              //     child: Container(width: 60, height: 30,
              //       decoration: BoxDecoration(
              //         // color: Colors.red,
              //           borderRadius: BorderRadius.all(Radius.circular(24)),
              //           border: Border.all(color: Colors.black)),
              //       child: Center(
              //         child: Text('Make default',
              //           style: TextStyle(fontSize: 10, color: Colors.black),
              //           textAlign: TextAlign.center,
              //         ).paddingOnly(right: AppSize.width5),
              //       ),
              //     ),
              //   );
              //
              // }     ),

              /*      InkWell(
                 onTap: (){
                   controller.isLoading.value=false;

                   Get.to(EditAddressForm(address: controller.addressList[index].address!,addressId: controller.addressList[index].id!,));},
                 child: Image.asset(AppAssets.editAddressIcon,
                   height: AppSize.height30,
                   width: AppSize.width35,
                 ).paddingOnly(right: AppSize.width5),
               ),*/
              InkWell(
                onTap: () {
                  controller.deleteAddress(controller.addressList[index].id!);
                },
                child: Image.asset(
                  AppAssets.deleteIcon,
                  height: AppSize.height30,
                  width: AppSize.width35,
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(10),
    );
  }

  Widget _addAddressButton() {
    return AppButton(
      onTap: () {
        controller.isLoading.value = false;
        Get.to(NewAddressForm());
      },
      text: AppStrings.addNewAddress.toUpperCase(),
      color: AppColors.secondary,
    );
  }
}
