import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/forget_password/forget_password_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../components/app_buttons.dart';
import '../../components/app_text_form_field.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';
import 'otp_verification_controller.dart';

class OtpVerificationScreen extends GetView<OtpVerificationController> {
  OtpVerificationScreen({super.key});

  @override
  OtpVerificationController controller = Get.put(OtpVerificationController());
  ForgetPasswordController forgotController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey.value,
          child: Column(
            children: [
              Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: AppSize.height15,
                        color: Colors.black,
                      ))
                  .paddingOnly(left: AppSize.width20, bottom: AppSize.height20),
              CustomText(
                text: AppStrings.verification,
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

              CustomText(
                text: AppStrings.sendCodeTo,
                textStyle: TextStyles.mediumText,
                color: Colors.black,
                fontSize: AppSize.font14,
              ),

              CustomText(
                text: forgotController.emailTextController.text.toString(),
                textStyle: TextStyles.boldText,
                color: Colors.black,
                fontSize: AppSize.font14,
              ),
              // _codeResendTextRow(),
              const SizedBox(
                height: 20,
              ),
              _pinTextField(context),
              _passwordTextFormField().paddingOnly(
                  right: AppSize.width20,
                  left: AppSize.width20,
                  bottom: AppSize.height15),
              _confirmPasswordTextFormField()
                  .paddingSymmetric(horizontal: AppSize.width20),
              Obx(
                () => controller.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      )
                    : _verifyButton(),
              )
            ],
          ).paddingSymmetric(vertical: AppSize.height60),
        ),
      ),
    );
  }

  // _codeResendTextRow(){
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       CustomText(text: AppStrings.code, textStyle: TextStyles.regularText,color: Colors.black,
  //           fontSize: AppSize.font15,),
  //       Text.rich(
  //         TextSpan(
  //           children: [
  //             TextSpan(
  //               text: AppStrings.resend,
  //               style: TextStyle(
  //                 fontFamily: "Sen",
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: AppSize.font12,
  //                 decoration: TextDecoration.underline,
  //                 color: Colors.black, // Change the color as needed
  //               ),
  //             ),
  //             TextSpan(
  //               text: ' in.50 sec',
  //               style: TextStyle(
  //                 fontFamily: 'Sen',
  //                 fontSize: AppSize.font12,
  //                 color: Colors.black, // Change the color as needed
  //
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ).paddingOnly(top: AppSize.height25, right: AppSize.width20, left: AppSize.width20, bottom: AppSize.height10);
  // }

  _pinTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PinCodeTextField(
        autoDismissKeyboard: true,
        autoDisposeControllers: false,
        cursorHeight: AppSize.height20,
        cursorColor: Colors.black,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textStyle: TextStyle(
            fontSize: AppSize.font15,
            color: Colors.black,
            fontWeight: FontWeight.w700),
        obscureText: false,
        appContext: context,
        keyboardType: TextInputType.number,
        length: 6,
        controller: controller.otpTextController,
        enableActiveFill: true,
        pinTheme: PinTheme(
          selectedColor: Colors.transparent,
          shape: PinCodeFieldShape.underline,
          inactiveColor: Colors.transparent, fieldHeight: AppSize.height50,
          fieldWidth: AppSize.width50,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          // borderWidth: 5,
          activeFillColor: AppColors.textFormColor,
          inactiveFillColor: AppColors.textFormColor,
          activeColor: Colors.transparent,
          selectedFillColor: AppColors.textFormColor,
        ),
        onChanged: (v) {},
        onCompleted: (value) {},
      ).paddingSymmetric(horizontal: AppSize.width5),
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
      obscureText: true,
      showIcon: controller.show.value,
      show: controller.showIcon,
      controller: controller.reTypePasswordTextController,
      labelText: AppStrings.reTypePassword.toUpperCase(),
    );
  }

  Widget _verifyButton() {
    return AppButton(
            onTap: () {
              controller.validateForm(
                forgotController.emailTextController.text.trim(),
                controller.otpTextController.text.trim(),
                controller.newPasswordTextController.text.trim(),
              );

              // Get.toNamed(AppPages.newPasswordScreen);
            },
            text: AppStrings.verify.toUpperCase())
        .paddingSymmetric(
            horizontal: AppSize.width50, vertical: AppSize.height25);
  }
}
