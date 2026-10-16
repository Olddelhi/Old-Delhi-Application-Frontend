import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/ui/payment_method/payment_method_controller.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';

import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class PaymentMethodScreen extends GetView<PaymentMethodController> {
  PaymentMethodScreen({super.key});

  @override
  PaymentMethodController controller = Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _paymentMethod(),
            _cardWidget(),
            _addCardButton(),
            _totalAmount(),
            _payButton(),
          ],
        ).paddingSymmetric(horizontal: AppSize.width10),
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
              AppAssets.backIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: CustomText(
            text: AppStrings.payment,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    );
  }

  _paymentMethod() {
    return SizedBox(
      height: AppSize.height100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.methodIems.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(controller.methodIems[index],
                height: AppSize.height100, width: AppSize.width100);
          }),
    );
  }

  _cardWidget() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.radius12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Master card",
            textStyle: TextStyles.boldText,
            color: Colors.black,
            fontSize: AppSize.font15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppAssets.visaIcon,
                height: AppSize.height35,
                width: AppSize.width30,
              ),
              Expanded(
                child: CustomText(
                  text: "  *******************2345",
                  color: Colors.black,
                  fontSize: AppSize.font12,
                  textStyle: TextStyles.mediumText,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_sharp,
              )
            ],
          )
        ],
      ).paddingSymmetric(
          horizontal: AppSize.width10, vertical: AppSize.height10),
    );
  }

  Widget _addCardButton() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.radius15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: AppColors.secondary,
            size: AppSize.height25,
          ),
          CustomText(
            text: AppStrings.addNew,
            color: AppColors.secondary,
            textStyle: TextStyles.boldText,
            fontSize: AppSize.font15,
          )
        ],
      ).paddingSymmetric(vertical: AppSize.height8),
    ).paddingSymmetric(vertical: AppSize.height15);
  }

  Widget _totalAmount() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText(
            text: AppStrings.total.toUpperCase() + ":".toUpperCase(),
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font16,
            color: Colors.black45,
          ),
          CustomText(
            text: "\u{20B9}2850.00",
            textStyle: TextStyles.boldText,
            fontSize: AppSize.font16,
            color: Colors.black87,
          ),
        ],
      ).paddingOnly(top: AppSize.height5),
    );
  }

  _payButton() {
    return AppButton(
      onTap: () {
        Get.toNamed(AppPages.addCardScreen);
      },
      text: AppStrings.payAndConfirm,
      color: AppColors.secondary,
    ).paddingSymmetric(vertical: AppSize.height25);
  }
}
