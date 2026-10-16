import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/shared_preferns.dart';
import '../../responses/pincode_response.dart';

class ManuallyDetailController extends GetxController {
  Rx<TextEditingController> pinCodeTextController = TextEditingController().obs;
  Rx<TextEditingController> stateTextController = TextEditingController().obs;
  Rx<TextEditingController> cityTextController = TextEditingController().obs;
  Rx<TextEditingController> houseNoTextController = TextEditingController().obs;
  Rx<TextEditingController> roadNameTextController =
      TextEditingController().obs;
  Rx<TextEditingController> nearByTextController = TextEditingController().obs;
  RxBool isLoading = false.obs; // New variable to track loading state

  var formKey = GlobalKey<FormState>().obs;

  final id = ''.obs;
  final message = ''.obs;

  // Future<void> fetchPincodeData(String pincode) async {
  //   var response = await ApiResponse().verifyPincode(pincode);
  //   if (response != null) {
  //     if(response.message=='Pincode details fetched successfully') {
  //       id.value = response.data.id;
  //       addAddress(id.value, stateTextController.value.text.trim(),cityTextController.value.text.trim(),
  //           houseNoTextController.value.text.trim(), roadNameTextController.value.text.trim(), nearByTextController.value.text.trim()
  //       );
  //     }else if(response.message=='Invalid Pincode'){
  //       Get.snackbar("Alert", "Enter valid pincode");
  //     }
  //   } else {
  //     // Handle error or display a message
  //   }
  // }
  Future<void> fetchPincodeData(String pincode) async {
    var response = await ApiResponse().verifyPincode(pincode);
    print("response from pincode $response");
    if (response != null) {
      if (response is PincodeResponse) {
        // if (response.message == 'Pincode details fetched successfully') {
        id.value = response.data.id;
        addAddress(
          id.value,
          stateTextController.value.text.trim(),
          cityTextController.value.text.trim(),
          houseNoTextController.value.text.trim(),
          roadNameTextController.value.text.trim(),
          nearByTextController.value.text.trim(),
        );
        isLoading.value = false;
        // }
      }
    } else {
      Get.snackbar(
        "Alert",
        "Enter valid address",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      isLoading.value = false;
    }
  }

  validateForm() {
    if (formKey.value.currentState!.validate()) {
      isLoading.value = true;
      fetchPincodeData(pinCodeTextController.value.text.trim());
      // addAddress(pinCodeTextController.value.text.trim(), stateTextController.value.text.trim(),cityTextController.value.text.trim(),
      // houseNoTextController.value.text.trim(), roadNameTextController.value.text.trim(), nearByTextController.value.text.trim()
      // );
    }
  }

  addAddress(String pinCode, String state, String city, String houseNo,
      String roadName, String nearBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString(SharedPrefs.keys.userData!);
    // Parse the userData string to extract the name
    Map<String, dynamic> userDataMap = json.decode(userData!);
    String name = userDataMap["user"]["name"];
    String number = userDataMap["user"]["phoneNumber"];

    var data = {
      "name": name,
      "mobile": number,
      "pincode": pinCode,
      "locality": " ",
      "address": houseNo,
      "city": city,
      "landmark": nearBy,
      "state": state,
      "alternatePhone": number
    };

    await ApiResponse().addAddress(data).then((value) {
      if (value != null) {
        Get.offAll(DashboardScreen());
      }
    });
  }
}
