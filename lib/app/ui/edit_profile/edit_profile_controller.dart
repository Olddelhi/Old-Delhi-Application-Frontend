import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:old_delhi_food/app/services/end_points.dart'; // Add this import for HTTP requests

class EditProfileController extends GetxController {
  final ApiResponse _apiResponse = ApiResponse();

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController bioTextController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  RxBool saveLoading = false.obs;
  var profileImage = Rx<File?>(null);
  var profileImageUrl = Rx<String>('');
  final ImagePicker _picker = ImagePicker();
  var image = Rx<File?>(null);
  String existingImageId = '';
  Rx<String?> avatarPath = null.obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;
    fullNameTextController.text = args['name'] ?? '';
    emailTextController.text = args['email'] ?? '';
    phoneTextController.text = args['phoneNumber'] ?? '';
    bioTextController.text = args['bio'] ?? '';
    profileImageUrl.value = args['picUrl'] ?? '';
    existingImageId = Get.arguments['imageId'] ?? '';
  }

  void setImage(File image) {
    profileImage.value = image;
    profileImageUrl.value = ''; // Clear previous profile image URL
    update(); // This is important to update the UI with the selected image
  }

  Future<File?> selectPictureFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setImage(File(pickedFile.path));
        image.value = File(pickedFile.path);
        avatarPath.value = pickedFile.path;
        update(); // Update _image variable
        print('Selected Image Path: $image');
      }
    } catch (e) {
      print('Error selecting picture from gallery: $e');
    }
    update();
    return image.value;
  }

  Future<File?> selectPictureFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setImage(File(pickedFile.path));
        image.value = File(pickedFile.path); // Update _image variable
        print('Selected Image Path: $image');
      }
      update();
    } catch (e) {
      print('Error selecting picture from camera: $e');
    }
    return image.value;
  }

  void updateProfile() async {
    try {
      saveLoading.value = true;
      String? imagePath = profileImage.value?.path;
      if (imagePath != null) {
        String imageId = await _uploadImage(imagePath);
        await _updateProfileWithImage(imageId);
      } else {
        existingImageId = Get.arguments['imageId'];
        await _updateProfileWithoutImage(existingImageId);
      }
      // Get.snackbar("Success", "Profile updated successfully");
    } catch (e) {
      saveLoading.value = false;
      profileImage.value?.path != null
          ? Get.snackbar(
              "Error",
              "Failed to update profile",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            )
          : Get.snackbar(
              "Error",
              "Select profile image to update profile",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
      print('Error updating profile: $e');
    }
  }

  Future<String> _uploadImage(String imagePath) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('${EndPoints.baseUrl}${EndPoints.uploadImage}'));
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
          json.decode(await response.stream.bytesToString());
      return responseData['data']['id'];
    } else {
      throw Exception('Error uploading image: ${response.reasonPhrase}');
    }
  }

  Future<void> _updateProfileWithImage(String imageId) async {
    await _apiResponse.updateProfile(
      fullName: fullNameTextController.text,
      bio: bioTextController.text,
      image: imageId,
      email: emailTextController.text,
    );
    Get.back();
    saveLoading.value = false;
  }

  Future<void> _updateProfileWithoutImage(String imageId) async {
    await _apiResponse.updateProfile(
      fullName: fullNameTextController.text,
      bio: bioTextController.text,
      email: emailTextController.text,
      image: imageId,
    );
    Get.back();
    saveLoading.value = false;
  }

  // void updateProfile() async {
  //   String? imagePath = profileImage.value?.path;
  //   try {
  //     if (imagePath != null ) {
  //       // Upload image
  //       http.MultipartRequest request =
  //       http.MultipartRequest('POST', Uri.parse('${EndPoints.baseUrl}${EndPoints.uploadImage}'));
  //       request.files.add(await http.MultipartFile.fromPath('image', imagePath));
  //       http.StreamedResponse response = await request.send();
  //       if (response.statusCode == 200) {
  //         // Parse the response body
  //         Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());
  //         String imageId = responseData['data']['id'];
  //
  //         // Update profile with image ID
  //         await _apiResponse.updateProfile(
  //           fullName: fullNameTextController.text,
  //           bio: bioTextController.text,
  //           image: imageId, // Use the returned image ID
  //           email: emailTextController.text,
  //         );
  //
  //         // Profile updated successfully, you can show a success message
  //       } else {
  //         print('Error uploading image: ${response.reasonPhrase}');
  //       }
  //     } else {
  //       Get.snackbar("Alert", "Add profile picture");
  //
  //       print('Error: Image file path is null');
  //     }
  //   } catch (e) {
  //     // Handle error
  //     print('Error updating profile: $e');
  //   }
  // }

  // void updateProfile() async {
  //   String? imagePath = profileImage.value?.path;
  //   try {
  //      // Get the file path from the File object
  //     if (imagePath != null) {
  //       // Update profile
  //       await _apiResponse.updateProfile(
  //         fullName: fullNameTextController.text,
  //         bio: bioTextController.text,
  //         image: "d1e0f9cf-615f-4a6c-9783-e0fc94c81960",
  //       );
  //       // Profile updated successfully, you can show a success message
  //     } else {
  //       print('Error: Image file path is null');
  //       // Handle the case when the image file path is null
  //     }
  //   } catch (e) {
  //     // Handle error
  //     print('Error updating profile: $e');
  //
  //     // Check if the error is due to profile not found (status code 404)
  //     // if (e.toString().contains('Exception: Failed to update profile')) {
  //       // Parse the error response to extract the message
  //       // String? errorMessage = parseErrorMessageFromResponse(e.toString());
  //       // if (errorMessage != null && errorMessage.contains('Profile not found')) {
  //         // Profile not found, create it
  //         // await _apiResponse.createProfile(
  //         //   fullName: fullNameTextController.text,
  //         //   bio: bioTextController.text,
  //         //   image: "d1e0f9cf-615f-4a6c-9783-e0fc94c81960"??'d1e0f9cf-615f-4a6c-9783-e0fc94c81960', // Make sure to provide the image path here
  //         // );
  //       // } else {
  //       //   // Handle other 404 errors
  //       //   print('Error 404: $errorMessage');
  //       // }
  //     // } else {
  //       // Handle other errors
  //     //   print('Error updating profile: $e');
  //     // }
  //   }
  // }

  String? parseErrorMessageFromResponse(String response) {
    // Parse the response body to extract the error message
    try {
      Map<String, dynamic> json = jsonDecode(response);
      if (json.containsKey('message')) {
        return json['message'];
      }
    } catch (e) {
      print('Error parsing response: $e');
    }
    return null;
  }
}
