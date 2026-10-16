// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:old_delhi_food/app/components/app_buttons.dart';
// import 'package:old_delhi_food/app/ui/edit_profile/edit_profile_controller.dart';
// import 'package:old_delhi_food/app/utils/app_colors.dart';
//
// import '../../components/app_text_form_field.dart';
// import '../../components/cutom_text.dart';
// import '../../components/text_styles.dart';
// import '../../utils/app_assets.dart';
// import '../../utils/app_size.dart';
// import '../../utils/app_strings.dart';
//
// class EditProfileScreen extends GetView<EditProfileController>{
//
//    EditProfileController controller= EditProfileController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//                  _appBar(),
//               _profileImage(),
//               _fullNameTextFormField().paddingOnly(top: AppSize.height15),
//               _phoneTextFormField().paddingOnly(top: AppSize.height15),
//               _emailTextFormField().paddingOnly(top: AppSize.height15),
//               _bioTextFormField().paddingOnly(top: AppSize.height15),
//               AppButton(onTap: (){}, text: AppStrings.save, color: AppColors.secondary,).paddingOnly(top: AppSize.height50)
//             ],
//           ),
//         ),
//       ).paddingSymmetric(horizontal: AppSize.width20),
//     );
//   }
//
//
//
//    Widget _appBar(){
//      return Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: [
//          GestureDetector(
//              onTap: (){
//                Get.back();
//              },
//              child: Image.asset(AppAssets.backIcon,
//                height: AppSize.height35,
//                width: AppSize.width40,
//                fit: BoxFit.fill,)),
//
//          Expanded(
//            child: CustomText(text: AppStrings.editProfile, textStyle: TextStyles.regularText,
//              fontSize: AppSize.font18,
//            ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height5),
//          ),
//
//
//        ],
//      );
//    }
//
//   Widget _profileImage(){
//     return    Stack(
//       children: [
//         Container(
//           height: AppSize.height100,
//           width: AppSize.width100,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.orangeAccent,
//           ),
//         ),
//         Positioned(
//           bottom: 6,
//           right: 0,
//           child: Image.asset(AppAssets.editIcon),
//         ),
//       ],
//     );
//
//   }
//
//
//    AppTextFormField _fullNameTextFormField() {
//      return AppTextFormField(
//        focusNode: controller.fullNameFocusNode,
//        isLabel: true,
//        controller: controller.fullNameTextController,
//        labelText: AppStrings.fullName,
//      );
//    }
//
//    AppTextFormField _phoneTextFormField() {
//      return AppTextFormField(
//        focusNode: controller.phoneFocusNode,
//        isLabel: true,
//        controller: controller.phoneTextController,
//        labelText: AppStrings.phoneNumber,
//      );
//    }
//
//    AppTextFormField _emailTextFormField() {
//      return AppTextFormField(
//        focusNode: controller.emailFocusNode,
//        isLabel: true,
//        controller: controller.emailTextController,
//        labelText: AppStrings.email,
//      );
//    }
//
//    AppTextFormField _bioTextFormField() {
//      return AppTextFormField(
//        focusNode: controller.bioFocusNode,
//        isLabel: true,
//        obscureText: false,
//        maxLines: 1,
//        controller: controller.bioTextController,
//        labelText: AppStrings.bio,
//      );
//    }
//
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import '../../components/app_text_form_field.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  @override
  EditProfileController controller = Get.put(EditProfileController());

  File? newImage;

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(),
              Obx(() => _profileImage(context)),
              _fullNameTextFormField().paddingOnly(top: AppSize.height15),
              _phoneTextFormField().paddingOnly(top: AppSize.height15),
              _emailTextFormField().paddingOnly(top: AppSize.height15),
              _bioTextFormField().paddingOnly(top: AppSize.height15),
              Obx(
                () => controller.saveLoading.value
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      )
                    : AppButton(
                        onTap: controller.updateProfile,
                        // onTap: (){},
                        text: AppStrings.save,
                        color: AppColors.secondary,
                      ).paddingOnly(top: AppSize.height50),
              )
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: AppSize.width20),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppAssets.backIcon,
            height: AppSize.height35,
            width: AppSize.width40,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: CustomText(
            text: AppStrings.editProfile,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
            horizontal: AppSize.width15,
            vertical: AppSize.height5,
          ),
        ),
      ],
    );
  }

  Widget _profileImage(BuildContext context) {
    print('imageee${controller.image.value}');
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _showImagePickerDialog(context);
          },
          child: Container(
            height: AppSize.height100,
            width: AppSize.width100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
              image: controller.profileImageUrl.value.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(controller.profileImageUrl.value),
                      fit: BoxFit.cover,
                    )
                  : controller.image.value != null
                      ? DecorationImage(
                          image: FileImage(controller.image.value!),
                          fit: BoxFit.cover,
                        )
                      : null,
            ),
            child: controller.profileImageUrl.value.isEmpty &&
                    controller.image.value == null
                ? const Icon(Icons.camera_alt)
                : null,
          ),
        ),
        Positioned(
          bottom: 6,
          right: 0,
          child: Image.asset(AppAssets.editIcon),
        ),
      ],
    );
  }

  AppTextFormField _fullNameTextFormField() {
    return AppTextFormField(
      focusNode: controller.fullNameFocusNode,
      isLabel: true,
      showIcon: true,
      isPrefixIcon: false,
      controller: controller.fullNameTextController,
      labelText: AppStrings.fullName,
    );
  }

  AppTextFormField _phoneTextFormField() {
    return AppTextFormField(
      focusNode: controller.phoneFocusNode,
      isLabel: true,
      showIcon: true,
      isPrefixIcon: false,
      keyboardType: TextInputType.phone,
      controller: controller.phoneTextController,
      labelText: AppStrings.phoneNumber,
    );
  }

  AppTextFormField _emailTextFormField() {
    return AppTextFormField(
      focusNode: controller.emailFocusNode,
      isLabel: true,
      showIcon: true,
      isPrefixIcon: false,
      keyboardType: TextInputType.emailAddress,
      controller: controller.emailTextController,
      labelText: AppStrings.email,
    );
  }

  AppTextFormField _bioTextFormField() {
    return AppTextFormField(
      focusNode: controller.bioFocusNode,
      isLabel: true,
      obscureText: false,
      showIcon: true,
      isPrefixIcon: false,
      maxLines: 1,
      controller: controller.bioTextController,
      labelText: AppStrings.bio,
    );
  }

  Future<void> _showImagePickerDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppStrings.selectPicture,
            style: TextStyles.regularText,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text(
                    AppStrings.takePicture,
                    style: TextStyles.regularText,
                  ),
                  onTap: () {
                    controller
                        .selectPictureFromCamera()
                        .then((value) => Get.back());
                    // Navigator.of(context).pop();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text(
                    AppStrings.chooseFromGallery,
                    style: TextStyles.regularText,
                  ),
                  onTap: () {
                    controller.selectPictureFromGallery().then((value) {
                      controller.image.value = value;
                      Get.back();
                    });
                    // Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
