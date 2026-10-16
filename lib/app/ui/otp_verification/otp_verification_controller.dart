import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/api_response.dart';
import '../../utils/app_pages.dart';

class OtpVerificationController extends GetxController{
  TextEditingController otpTextController = TextEditingController();
  TextEditingController newPasswordTextController= TextEditingController();
  TextEditingController reTypePasswordTextController= TextEditingController();
  FocusNode newPasswordFocusNode= FocusNode();
  FocusNode reTypePasswordFocusNode= FocusNode();
  RxBool isLoading = false.obs;
  RxBool show=false.obs;
  var formKey = GlobalKey<FormState>().obs;

  bool showIcon() {
    return show.value = !show.value;
  }

  void validateForm(String email, String otp, String password){
    if(formKey.value.currentState!.validate()){
      resetPassword(email,otp, password);
    }
  }

  void resetPassword(String email,String otp,String password)async {
    if(formKey.value.currentState!.validate())
    { try {
        // Start loading
        isLoading.value = true;
        var response = await ApiResponse().resetPassword(email,otp,password);
        if (response) {
          Get.snackbar(
            "Alert", "Password changes successfully", colorText: Colors.white,
            backgroundColor: Colors.red,);
          Get.offAllNamed(AppPages.loginScreen);
          isLoading.value = false;
        } else {
          Get.snackbar("Alert", "Unable to change password",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;

        // Handle errors here
      } finally {
        // Stop loading
        isLoading.value = false;
      }

  }}

}