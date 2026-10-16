import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../responses/get_address_response.dart';
import '../../responses/pincode_response.dart';
import '../../services/api_response.dart';

class MyAddressesController extends GetxController {
  RxList<AddressList> addressList = <AddressList>[].obs;
  var isLoading = true.obs;
  var isEditLoading = false.obs;
  var isAddLoading = false.obs;
  var defaultButton = false.obs;
  RxMap<String, bool> loadingMap = <String, bool>{}.obs;

  var defaultAddress = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  final id = ''.obs;
  final message = ''.obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> pincodeController = TextEditingController().obs;
  Rx<TextEditingController> localityController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> landmarkController = TextEditingController().obs;
  Rx<TextEditingController> stateController = TextEditingController().obs;
  Rx<TextEditingController> alternatePhoneController =
      TextEditingController().obs;

  @override
  void onInit() {
    getAddress();
    super.onInit();
  }

  getAddress() {
    isLoading.value = true;

    var res = ApiResponse().getAddress().then((value) {
      if (value != null) {
        addressList.value = value.addressList!;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    });
  }

  Future<bool> editAddress(
      String addressid,
      String name,
      String phone,
      String pincodeId,
      String locality,
      String address,
      String city,
      String landmark,
      String state,
      String alternatePhone,
      context) async {
    bool isSuccess = false;
    isEditLoading.value = true;
    var response = await ApiResponse().verifyPincode(pincodeId);
    if (response != null) {
      if (response is PincodeResponse) {
        if (response.message == 'Pincode details fetched successfully') {
          id.value = response.data.id;
          isSuccess = await ApiResponse().editAddress(
              addressid,
              name,
              phone,
              id.value,
              locality,
              address,
              city,
              landmark,
              state,
              alternatePhone);

          if (isSuccess) {
            // Handle success, maybe fetch updated address list again
            getAddress();
            Get.snackbar(
              'Success',
              'Address updated successfully',
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
            isEditLoading.value = false;
            Navigator.of(context).pop();
          } else {
            Get.snackbar(
              'Error',
              'Failed to update address',
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
            isEditLoading.value = false;
          }

          return isSuccess;
        }
      }
    } else {
      Get.snackbar("Alert", "Enter valid address");
      isEditLoading.value = false;
    }

    return isSuccess;
  }

  deleteAddress(String addressId) async {
    isLoading.value = true;

    var isSuccess = await ApiResponse().deleteAddress(addressId);

    if (isSuccess) {
      // Handle success, maybe fetch updated address list again
      getAddress();
    } else {
      // Handle error
      isLoading.value = false;
    }
  }

  Future<void> fetchPincodeData() async {
    var response =
        await ApiResponse().verifyPincode(pincodeController.value.text.trim());
    if (response != null) {
      debugPrint("dhdddjresposne $response");
      if (response is PincodeResponse) {
        if (response.status == 'success') {
          id.value = response.data.id;
          addAddress(
            nameController.value.text.trim(),
            phoneController.value.text.trim(),
            id.value,
            localityController.value.text.trim(),
            stateController.value.text.trim(),
            cityController.value.text.trim(),
            addressController.value.text.trim(),
            landmarkController.value.text.trim(),
            alternatePhoneController.value.text.trim(),
          );
          isAddLoading.value = false;
        } else {
          isAddLoading.value = false;
        }
      }
    } else {
      Get.snackbar(
        "Alert",
        "Enter valid address",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      isAddLoading.value = false;
    }
  }

  addAddress(
      String name,
      String number,
      String pinCode,
      String locality,
      String state,
      String city,
      String houseNo,
      String nearBy,
      String alternateNumber) async {
    isAddLoading.value = true;
    var data = {
      "name": name,
      "mobile": number,
      "pincode": pinCode,
      "locality": locality,
      "address": houseNo,
      "city": city,
      "landmark": nearBy,
      "state": state,
      "alternatePhone": alternateNumber
    };

    await ApiResponse().addAddress(data).then((value) {
      if (value != null) {
        getAddress();

        isAddLoading.value = false;
        Get.back();
      } else {
        isAddLoading.value = false;
      }
    });
  }

  makeAddressDefault(id) async {
    try {
      loadingMap[id] = true;
      // defaultButton.value = true; // Set loading state for the button with ID 'id'
      var res = await ApiResponse().setDefaultAddress(id);
      if (res) {
        loadingMap[id] = false;
        getAddress();
        Get.snackbar(
          "Alert",
          "Default Address Set Successfully",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      } else {
        loadingMap[id] = false;
        Get.snackbar(
          "Alert",
          "Unable to set default address ",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      loadingMap[id] = false;
      Get.snackbar(
        "Alert",
        "Unable to set default address ",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );

      print(e.toString());
    }
  }
}
