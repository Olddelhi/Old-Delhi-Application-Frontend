import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/app_buttons.dart';
import '../../components/app_text_form_field.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_pages.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';
import 'new_password_controller.dart';

class NewPasswordScreen extends GetView<NewPasswordController> {
  NewPasswordScreen({super.key});

  @override
  NewPasswordController controller = NewPasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: AppSize.height15,
                            color: Colors.black,
                          )))
                  .paddingOnly(left: AppSize.width20, bottom: AppSize.height20),
              CustomText(
                text: AppStrings.newPassword,
                textStyle: TextStyles.boldText,
                color: Colors.black,
                fontSize: AppSize.font30,
              ),
              Image.asset(
                AppAssets.loginBackground,
                width: Get.width,
                height: AppSize.height40,
                fit: BoxFit.cover,
              ).paddingSymmetric(vertical: AppSize.height30),
              _passwordTextFormField().paddingOnly(
                  right: AppSize.width20,
                  left: AppSize.width20,
                  bottom: AppSize.height15),
              _confirmPasswordTextFormField()
                  .paddingSymmetric(horizontal: AppSize.width20),
              _verifyButton(),
            ],
          ).paddingSymmetric(vertical: AppSize.height60),
        ),
      ),
    );
  }

  AppTextFormField _passwordTextFormField() {
    return AppTextFormField(
      focusNode: controller.newPasswordFocusNode,
      isLabel: true,
      isPassword: true,
      obscureText: true,
      showIcon: controller.show.value,
      show: controller.showIcon,
      controller: controller.newPasswordTextController,
      labelText: AppStrings.password,
    );
  }

  AppTextFormField _confirmPasswordTextFormField() {
    return AppTextFormField(
      focusNode: controller.reTypePasswordFocusNode,
      isLabel: true,
      isPassword: true,
      controller: controller.reTypePasswordTextController,
      labelText: AppStrings.reTypePassword.toUpperCase(),
    );
  }

  Widget _verifyButton() {
    return AppButton(
            onTap: () {
              Get.toNamed(AppPages.locationAccessScreen);
            },
            text: AppStrings.verify.toUpperCase())
        .paddingSymmetric(
            horizontal: AppSize.width50, vertical: AppSize.height25);
  }
}
