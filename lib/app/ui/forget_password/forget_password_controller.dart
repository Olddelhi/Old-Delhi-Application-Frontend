import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/api_response.dart';
import '../../utils/app_pages.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  FocusNode emailFocuseNode = FocusNode();
  RxBool isLoading = false.obs;
  var formKey = GlobalKey<FormState>().obs;

  void forgotPassword(String email) async {
    if (formKey.value.currentState!.validate()) {
      try {
        // Start loading
        isLoading.value = true;
        var response = await ApiResponse().forgotPassword(email);
        if (response) {
          Get.snackbar(
            "Alert",
            "OTP Sent Successfully to $email",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
          Get.toNamed(AppPages.otpVerificationScreen);
          isLoading.value = false;
        } else {
          Get.snackbar(
            "Alert",
            "Unable to send code\nPlease try again later!",
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
    }
  }
}
