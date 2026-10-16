import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/payment_successfull/payment_successfull_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';

import '../dashboard/dashboard_screen.dart';

class PaymentSuccessfullScreen extends GetView<PaymentSuccessfullController> {
  @override
  PaymentSuccessfullController controller = PaymentSuccessfullController();

  PaymentSuccessfullScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            AppAssets.paymentSuccessfulImage,
            height: Get.height * 0.4,
            width: Get.width * 0.5,
          )),
          CustomText(
            text: "You successfully made a payment, enjoy our services",
            fontSize: AppSize.font14,
            color: Colors.black45,
          ).paddingSymmetric(horizontal: AppSize.width40),
          AppButton(
            onTap: () {
              // Get.toNamed(AppPages.trackOrderScreen);
              Get.offAll(() => DashboardScreen());
            },
            // text: AppStrings.trackOrder,
            text: "Home",
            color: AppColors.secondary,
          ).paddingOnly(top: AppSize.height120)
        ],
      ).paddingSymmetric(horizontal: AppSize.width20),
    );
  }
}

class PaymentUnSuccessfullScreen
    extends GetView<PaymentUnSuccessfullController> {
  @override
  PaymentUnSuccessfullController controller = PaymentUnSuccessfullController();

  PaymentUnSuccessfullScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: Get.height * 0.2,
              width: Get.height * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withValues(alpha: 0.1),
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: Get.height * 0.1,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomText(
            text:
                "Payment failed but order placed successfully, enjoy our services",
            fontSize: AppSize.font14,
            color: Colors.black45,
          ).paddingSymmetric(horizontal: AppSize.width40),
          AppButton(
            onTap: () {
              // Get.toNamed(AppPages.trackOrderScreen);
              Get.offAll(() => DashboardScreen());
            },
            // text: AppStrings.trackOrder,
            text: "Home",
            color: AppColors.secondary,
          ).paddingOnly(top: AppSize.height120)
        ],
      ).paddingSymmetric(horizontal: AppSize.width20),
    );
  }
}
