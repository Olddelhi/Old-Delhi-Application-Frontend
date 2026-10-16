import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/location_access/location_access_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/shared_preferns.dart';
import '../../services/api_response.dart';

class SignUpController extends GetxController {
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  FocusNode mobileFocusNode = FocusNode();
  RxBool show = false.obs;
  RxBool showOtpFilled = false.obs;
  RxBool showConfirmPassword = false.obs;
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  RxBool remember = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  RxBool isLoading = false.obs; // New variable to track loading state

  bool showIcon() {
    return show.value = !show.value;
  }

  bool showConfirmPass() {
    return showConfirmPassword.value = !showConfirmPassword.value;
  }

  final RxInt timeInSeconds = 50.obs; // Using RxInt for reactive updates

  Timer? timer; // Timer variable

  void startTimer() {
    print("working");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeInSeconds.value > 0) {
        timeInSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void validateForm(String name, String email, String mobile, String password) {
    if (formKey.value.currentState!.validate()) {
      signup(name, email, mobile, password);
    }
  }

  Future<void> signup(
      String name, String email, String mobile, String password) async {
    if (formKey.value.currentState!.validate()) {
      isLoading.value = true;

      var response = await ApiResponse()
          .signup(name, email, mobile, password)
          .then((value) async {
        if (value != null) {
          startTimer();

          value == true
              ? showOtpFilled.value = true
              : showOtpFilled.value = false;
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString(SharedPrefs.keys.authToken, value.token!);
          // Get.offAll(() => DashboardScreen());
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      });
    }
  }

  Future<void> verifyOtp(String email, String mobile, String otp) async {
    isLoading.value = true;

    var res =
        await ApiResponse().verifyOtp(email, mobile, otp).then((value) async {
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(SharedPrefs.keys.authToken, value.token!);
        prefs.setString(SharedPrefs.keys.userData!, json.encode(value.data!));
        Get.offAll(() => LocationAccesScreen());
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }
}
