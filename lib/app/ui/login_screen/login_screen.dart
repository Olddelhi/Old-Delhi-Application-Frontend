import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/components/common_widget.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/login_screen/login_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';
import '../../components/app_text_form_field.dart';
import '../../components/text_styles.dart';
import '../../components/validator.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  @override
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Obx(
          () => Form(
            key: controller.formKey.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: AppStrings.login,
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

                _emailTextFormField()
                    .paddingSymmetric(horizontal: AppSize.width20),
                _passwordTextFormField().paddingSymmetric(
                    horizontal: AppSize.width20, vertical: AppSize.height15),

                _rememberForgetPasswordRow()
                    .paddingSymmetric(horizontal: AppSize.width10),
                _loginButton(),
                _dontHaveAccount(),
                // _orText(),
                // _socialIconRow(),
              ],
            ).paddingSymmetric(vertical: AppSize.height80),
          ),
        ),
      ),
    ));
  }

  AppTextFormField _mobileTextFormField() {
    return AppTextFormField(
      focusNode: controller.mobileFocusNode,
      isLabel: true,
      validator: (v) => FieldValidator.validateMobile(v!),
      showIcon: true,
      isPrefixIcon: false,
      keyboardType: TextInputType.number,
      controller: controller.mobileTextController,
      labelText: AppStrings.mobileNo,
    );
  }

  AppTextFormField _emailTextFormField() {
    return AppTextFormField(
      focusNode: controller.emailFocusNode,
      isLabel: true,
      validator: (v) => FieldValidator.validateEmail(v!),
      showIcon: true,
      isPrefixIcon: false,
      keyboardType: TextInputType.emailAddress,
      controller: controller.emailTextController,
      labelText: AppStrings.email,
    );
  }

  AppTextFormField _passwordTextFormField() {
    return AppTextFormField(
      focusNode: controller.passwordFocusNode,
      isLabel: true,
      isPassword: true,
      validator: (v) => FieldValidator.validatePassword(v!),
      obscureText: true,
      showIcon: controller.show.value,
      show: controller.showIcon,
      controller: controller.passwordTextController,
      labelText: AppStrings.password,
    );
  }

  Widget _rememberForgetPasswordRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: controller.remember.value,
                onChanged: (value) {
                  controller.remember.value = value!;
                },
              ),
              Expanded(
                child: CustomText(
                  text: AppStrings.rememberMe,
                  textStyle: TextStyles.mediumText,
                  color: Colors.black45,
                  fontSize: AppSize.font12,
                  maxLine: 1,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppPages.forgetPasswordScreen);
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              text: AppStrings.forgetPassword,
              textStyle: TextStyles.mediumText,
              color: AppColors.orangeColor,
              fontSize: AppSize.font14,
              maxLine: 1,
            ).paddingOnly(right: AppSize.font10),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return Obx(() {
      return controller.isLoading.value
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            )
          : AppButton(
                  onTap: () {
                    controller.login(
                        controller.emailTextController.text,
                        controller.mobileTextController.text,
                        controller.passwordTextController.text);
                  },
                  text: AppStrings.login.toUpperCase())
              .paddingSymmetric(
                  horizontal: AppSize.width50, vertical: AppSize.height25);
    });
  }

  Widget _dontHaveAccount() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CustomText(
        text: AppStrings.dontHaveAccount,
        textStyle: TextStyles.mediumText,
        color: Colors.black45,
        fontSize: AppSize.font14,
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(AppPages.signUpScreen);
        },
        child: CustomText(
          text: AppStrings.signUp.toUpperCase(),
          textStyle: TextStyles.boldText,
          color: AppColors.orangeColor,
          fontSize: AppSize.font14,
        ).paddingOnly(right: AppSize.font10),
      ),
    ]);
  }

  Widget _orText() {
    return CustomText(
      text: AppStrings.or,
      textStyle: TextStyles.mediumText,
      color: Colors.black45,
      fontSize: AppSize.font14,
    ).paddingSymmetric(vertical: AppSize.height15);
  }

  Widget _socialIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidgets().iconWidget(
            AppAssets.faceBookIcon, AppSize.height80, AppSize.width100),
        CommonWidgets().iconWidget(
            AppAssets.googleIcon, AppSize.height50, AppSize.width50),
      ],
    );
  }
}
