import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/shared_preferns.dart';

class LoginController extends GetxController{
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  var formKey = GlobalKey<FormState>().obs;
  FocusNode mobileFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  RxBool show=false.obs;
  FocusNode passwordFocusNode = FocusNode();
  RxBool remember= false.obs;
  RxBool isLoading = false.obs; // New variable to track loading state

 bool showIcon() {
   return show.value = !show.value;
 }

  Future<void> login(String email,String mobileText, String password) async {
    if(formKey.value.currentState!.validate()) {
      try {
        // Start loading
        isLoading.value = true;
        var response = await ApiResponse().login(email,mobileText, password);
        if(response != null) {
          Get.snackbar("Alert", "LogIn Successfully",colorText: Colors.white,
            backgroundColor: Colors.red,);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(SharedPrefs.keys.authToken, response.token!);
          prefs.setString(SharedPrefs.keys.userData!, json.encode(response.data!));
          Get.offAll(() => DashboardScreen());
          isLoading.value = false;
        }else{
          Get.snackbar("Alert", "Wrong Credentials",  colorText: Colors.white,
            backgroundColor: Colors.red,
          );
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