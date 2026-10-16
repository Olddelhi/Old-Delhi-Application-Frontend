import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/ui/add_card/add_card_controller.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';

import '../../components/app_text_form_field.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class AddCardScreen extends GetView<AddCardController> {
  AddCardScreen({super.key});

  @override
  AddCardController controller = Get.put(AddCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(),
              _cardHolderTextFormField()
                  .paddingSymmetric(vertical: AppSize.height15),
              _cardNumberTextFormField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _expiryTextFormField(),
                  _cvvTextFormField(),
                ],
              ).paddingSymmetric(vertical: AppSize.height15),
              _addCardAndPay(),
            ],
          ).paddingSymmetric(horizontal: AppSize.width20),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppAssets.crossIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: CustomText(
            text: AppStrings.addCard,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    );
  }

  AppTextFormField _cardHolderTextFormField() {
    return AppTextFormField(
      focusNode: controller.holderNameFocusNode,
      isLabel: true,
      controller: controller.holderNameTextController,
      labelText: AppStrings.cardHolderName.toUpperCase(),
    );
  }

  AppTextFormField _cardNumberTextFormField() {
    return AppTextFormField(
      focusNode: controller.cardNumberFocusNode,
      isLabel: true,
      controller: controller.cardNumberTextController,
      labelText: AppStrings.cardNumber.toUpperCase(),
    );
  }

  _expiryTextFormField() {
    return SizedBox(
      width: AppSize.width170,
      child: AppTextFormField(
        focusNode: controller.expiryDateFocusNode,
        isLabel: true,
        controller: controller.expiryDateTextController,
        labelText: AppStrings.expiryDate.toUpperCase(),
      ),
    );
  }

  _cvvTextFormField() {
    return SizedBox(
      width: AppSize.width100,
      child: AppTextFormField(
        focusNode: controller.cvvFocusNode,
        isLabel: true,
        hintText: "CVV",
        controller: controller.cvvTextController,
        labelText: AppStrings.cvv.toUpperCase(),
      ),
    );
  }

  Widget _addCardAndPay() {
    return AppButton(
      onTap: () {
        Get.toNamed(AppPages.paymentSuccessfulScreen);
      },
      text: AppStrings.addAndPay,
      color: AppColors.secondary,
    ).paddingOnly(top: AppSize.height220);
  }
}
