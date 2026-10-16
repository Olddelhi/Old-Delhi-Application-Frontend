import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/app_buttons.dart';
import '../../components/app_text_form_field.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../components/validator.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  ForgetPasswordScreen({super.key});
  @override
  ForgetPasswordController controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              text: AppStrings.forgetPassword,
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
            Obx(
              () => _mobileTextFormField()
                  .paddingSymmetric(horizontal: AppSize.width20),
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    )
                  : _sendCodeButton(),
            ),
          ],
        ).paddingSymmetric(vertical: AppSize.height60),
      ),
    );
  }

  Form _mobileTextFormField() {
    return Form(
        key: controller.formKey.value,
        child: AppTextFormField(
          focusNode: controller.emailFocuseNode,
          isLabel: true,
          validator: (v) => FieldValidator.validateEmail(v!),
          showIcon: true,
          isPrefixIcon: false,
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailTextController,
          labelText: AppStrings.email,
        ));
  }

  Widget _sendCodeButton() {
    return AppButton(
            onTap: () {
              controller.forgotPassword(
                  controller.emailTextController.text.toString());
            },
            text: AppStrings.sendCode.toUpperCase())
        .paddingSymmetric(
            horizontal: AppSize.width50, vertical: AppSize.height40);
  }
}
