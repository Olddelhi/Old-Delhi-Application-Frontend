import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/validator.dart';
import 'package:old_delhi_food/app/ui/signup_screen/signup_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../components/app_buttons.dart';
import '../../components/app_text_form_field.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  @override
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Widget signUpButton() {
      return Obx(
        () => controller.isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              )
            : AppButton(
                    onTap: () {
                      if (controller.showOtpFilled.value == true) {
                        controller.verifyOtp(
                          controller.emailTextController.text.trim(),
                          controller.mobileTextController.text.trim(),
                          controller.otpTextController.text.trim(),
                        ); // Start the timer when the verify button is clicked
                      } else {
                        controller.validateForm(
                          controller.nameTextController.text.trim(),
                          controller.emailTextController.text.trim(),
                          controller.mobileTextController.text.trim(),
                          controller.passwordTextController.text.trim(),
                        );
                      }
                    },
                    text: controller.showOtpFilled.value == true
                        ? AppStrings.otpVerify.toUpperCase()
                        : AppStrings.signUp.toUpperCase())
                .paddingSymmetric(
                    horizontal: AppSize.width50, vertical: AppSize.height25),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Obx(
        () => Form(
          key: controller.formKey.value,
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
                text: AppStrings.signUp,
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
              _nameTextFormField()
                  .paddingSymmetric(horizontal: AppSize.width20),
              _emailTextFormField().paddingOnly(
                  right: AppSize.width20,
                  left: AppSize.width20,
                  bottom: AppSize.height5,
                  top: AppSize.height15),
              _mobileTextFormField().paddingOnly(
                  right: AppSize.width20,
                  left: AppSize.width20,
                  bottom: AppSize.height5,
                  top: AppSize.height15),
              Visibility(
                  visible: controller.showOtpFilled.value,
                  child: _resendText(context, controller.timeInSeconds)
                      .paddingOnly(right: AppSize.width20)),
              _passwordTextFormField().paddingOnly(
                  right: AppSize.width20,
                  left: AppSize.width20,
                  top: AppSize.height15,
                  bottom: AppSize.height15),
              _confirmPasswordTextFormField()
                  .paddingSymmetric(horizontal: AppSize.width20),
              signUpButton(),
            ],
          ).paddingSymmetric(vertical: AppSize.height60),
        ),
      ),
    ));
  }

  AppTextFormField _nameTextFormField() {
    return AppTextFormField(
      focusNode: controller.nameFocusNode,
      isLabel: true,
      obscureText: false,
      keyboardType: TextInputType.name,
      showIcon: true,
      controller: controller.nameTextController,
      labelText: AppStrings.name,
    );
  }

  AppTextFormField _emailTextFormField() {
    return AppTextFormField(
      focusNode: controller.emailFocusNode,
      isLabel: true,
      obscureText: false,
      isVerifyText: false,
      keyboardType: TextInputType.emailAddress,
      showIcon: true,
      controller: controller.emailTextController,
      labelText: AppStrings.email,
    );
  }

  AppTextFormField _mobileTextFormField() {
    return AppTextFormField(
      focusNode: controller.mobileFocusNode,
      isLabel: true,
      obscureText: false,
      // validator: (value) => FieldValidator.validateMobile(value),
      isVerifyText: false,
      showIcon: true,
      keyboardType: TextInputType.number,
      controller: controller.mobileTextController,
      labelText: AppStrings.mobileNo,
    );
  }

  Widget _resendText(BuildContext context, RxInt timeInSeconds) {
    return Obx(
      () => Align(
          alignment: Alignment.centerRight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (timeInSeconds.value.toString() == '0') {
                      controller.validateForm(
                        controller.nameTextController.text.trim(),
                        controller.emailTextController.text.trim(),
                        controller.mobileTextController.text.trim(),
                        controller.passwordTextController.text.trim(),
                      );
                    }
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.resend,
                          style: TextStyle(
                            fontFamily: "Sen",
                            fontWeight: FontWeight.w600,
                            fontSize: AppSize.font12,
                            decoration: TextDecoration.underline,
                            color: Colors.black, // Change the color as needed
                          ),
                        ),
                        TextSpan(
                          text: ' in ${timeInSeconds.value.toString()} sec',
                          style: TextStyle(
                            fontFamily: 'Sen',
                            fontSize: AppSize.font12,
                            color: Colors.black, // Change the color as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "Error";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.grey,
                    activeColor: Colors.grey,
                    selectedColor: Colors.grey,
                    selectedFillColor: Colors.grey,
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: Colors.grey,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  //  errorAnimationController: errorController,
                  controller: controller.otpTextController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ).paddingOnly(left: AppSize.width30, top: AppSize.height10),
                CustomText(
                  text:
                      "Please check your ${controller.emailTextController.text.trim().toString()} email for OTP",
                  textStyle: const TextStyle(color: Colors.red),
                )
              ])),
    );
  }

  Widget _rememberForgetPasswordRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Checkbox(
          value: controller.remember.value,
          onChanged: (value) {
            controller.remember.value = value!;
          },
        ),
        CustomText(
          text: AppStrings.rememberMe,
          textStyle: TextStyles.mediumText,
          color: Colors.black45,
          fontSize: AppSize.font12,
        ),
      ]),
      CustomText(
        text: AppStrings.forgetPassword,
        textStyle: TextStyles.mediumText,
        color: AppColors.orangeColor,
        fontSize: AppSize.font14,
      ).paddingOnly(right: AppSize.font10),
    ]);
  }

  AppTextFormField _passwordTextFormField() {
    return AppTextFormField(
      focusNode: controller.passwordFocusNode,
      isLabel: true,
      isPassword: true,
      obscureText: true,
      validator: (value) => FieldValidator.validatePassword(value!),
      showIcon: controller.show.value,
      show: controller.showIcon,
      controller: controller.passwordTextController,
      labelText: AppStrings.password,
    );
  }

  AppTextFormField _confirmPasswordTextFormField() {
    return AppTextFormField(
      focusNode: controller.confirmPasswordFocusNode,
      isLabel: true,
      validator: (value) => FieldValidator.validateConfirmPassword(
          value!, controller.passwordTextController.text.trim()),
      isPassword: true,
      obscureText: true,
      showIcon: controller.showConfirmPassword.value,
      show: controller.showConfirmPass,
      controller: controller.confirmPasswordTextController,
      labelText: AppStrings.reTypePassword.toUpperCase(),
    );
  }
}
