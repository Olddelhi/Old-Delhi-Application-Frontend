// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:old_delhi_food/app/ui/personal_info/personal_info_controller.dart';
//
// import '../../components/cutom_text.dart';
// import '../../components/text_styles.dart';
// import '../../utils/app_assets.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/app_pages.dart';
// import '../../utils/app_size.dart';
// import '../../utils/app_strings.dart';
//
// class PersonalInfoScreen extends GetView<PersonalInfoController>{
//   const PersonalInfoScreen({super.key});
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//
//      body: SafeArea(
//        child: Column(
//          children: [
//            _appBar(),
//            _profileName(),
//            _personalInfoContainer(),
//
//          ],
//        ).paddingSymmetric(horizontal: AppSize.width10),
//      ),
//    );
//   }
//
//   Widget _appBar(){
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//             onTap: (){
//               Get.back();
//             },
//             child: Image.asset(AppAssets.backIcon,
//               height: AppSize.height35,
//               width: AppSize.width40,
//               fit: BoxFit.fill,)),
//
//         Expanded(
//           child: CustomText(text: AppStrings.profile, textStyle: TextStyles.regularText,
//             fontSize: AppSize.font18,
//           ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height5),
//         ),
//
//         GestureDetector(
//             onTap: (){
//               Get.toNamed(AppPages.editProfileScreen);
//             },
//             child: CustomText(text: AppStrings.edit,
//               textStyle: TextStyles.regularText, fontSize: AppSize.font15,
//                color: AppColors.orangeColor,)),
//       ],
//     );
//   }
//
//   Widget _profileName(){
//     return Row(
//       children: [
//         Container(
//           height: AppSize.height80,
//           width: AppSize.width80,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.orangeAccent
//           ),
//         ),
//
//         CustomText(text: "Price Chawla", textStyle: TextStyles.boldText,
//           fontSize: AppSize.font20,
//         ).paddingOnly(left: AppSize.width25)
//
//       ],
//     ).paddingSymmetric(vertical: AppSize.height15);
//   }
//
//   Widget _personalInfoContainer(){
//     return Container(
//       // height: AppSize.height150,
//         decoration: BoxDecoration(
//             color: AppColors.containerColor,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 1,
//                 blurRadius: 4,
//                 offset: Offset(0, 5), // changes the position of the shadow
//               ),
//             ],
//             borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
//         ),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             _profileInfoRow(AppAssets.personIcon, AppStrings.fullName,"Prince Chawla" ),
//             _profileInfoRow(AppAssets.addressIcon, AppStrings.email, "hello@hallalab.co"  ),
//             _profileInfoRow(AppAssets.addressIcon, AppStrings.phoneNumber,"408-841-0926" ),
//           ],
//         ).paddingSymmetric(horizontal: AppSize.width10, vertical: AppSize.height10)
//
//     );
//   }
//
//
//
//   Widget _profileInfoRow(String icon, String text, String value){
//     return GestureDetector(
//       onTap: (){},
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(icon,
//             height: AppSize.height30,
//             width: AppSize.width35,
//             fit: BoxFit.fill,),
//
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(text: text.toUpperCase(), textStyle: TextStyles.regularText,
//                 fontSize: AppSize.font13,
//               ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height5),
//
//
//               CustomText(text: value, textStyle: TextStyles.mediumText,
//                 fontSize: AppSize.font15,
//               ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height5),
//             ],
//           ),
//
//
//         ],
//       ).paddingAll(10),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as image;
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/profile/profile_controller.dart';

import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../responses/profile_response.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_pages.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(), // Initialize the controller
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _appBar(controller.user.value),
                _profileName(
                    controller.user.value.profile?.image?.url ?? '',
                    controller.user.value.profile?.fullName ??
                        controller.user.value.name ??
                        ''), // Pass the name
                _personalInfoContainer(
                    controller.user.value), // Pass the user data
              ],
            ).paddingSymmetric(horizontal: AppSize.width10),
          ),
        );
      },
    );
  }

  Widget _appBar(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: image.Image.asset(
              AppAssets.backIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: CustomText(
            text: AppStrings.profile,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppPages.editProfileScreen, arguments: {
              'name': user.profile?.fullName ?? user.name ?? '',
              'phoneNumber': user.phoneNumber,
              'email': user.email,
              'bio': user.profile?.bio ?? '',
              'picUrl': user.profile?.image?.url ?? '',
              'imageId': user.profile?.image?.id
            });
          },
          child: CustomText(
            text: AppStrings.edit,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font15,
            color: AppColors.orangeColor,
          ),
        ),
      ],
    );
  }

  Widget _profileName(String url, String name) {
    return Row(
      children: [
        url.isEmpty
            ? Container(
                height: AppSize.height80,
                width: AppSize.width80,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.orangeAccent),
              )
            : CircleAvatar(
                radius:
                    AppSize.width40, // Adjust the size of the avatar as needed
                backgroundColor: Colors
                    .orangeAccent, // You can set any background color you want
                backgroundImage: NetworkImage(
                    url ?? " "), // Set the image URL as the background image
              ),
        CustomText(
          text: name,
          textStyle: TextStyles.boldText,
          fontSize: AppSize.font20,
        ).paddingOnly(left: AppSize.width25)
      ],
    ).paddingSymmetric(vertical: AppSize.height15);
  }

  Widget _personalInfoContainer(User user) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 5), // changes the position of the shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _profileInfoRow(AppAssets.personIcon, AppStrings.fullName,
              user.profile?.fullName ?? user.name ?? ''),
          _profileInfoRow(
              AppAssets.addressIcon, AppStrings.email, user.email ?? ''),
          _profileInfoRow(AppAssets.addressIcon, AppStrings.phoneNumber,
              user.phoneNumber ?? ''),
        ],
      ).paddingSymmetric(
          horizontal: AppSize.width10, vertical: AppSize.height10),
    );
  }

  Widget _profileInfoRow(String icon, String text, String value) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image.Image.asset(
            icon,
            height: AppSize.height30,
            width: AppSize.width35,
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: text.toUpperCase(),
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font13,
              ).paddingSymmetric(
                  horizontal: AppSize.width15, vertical: AppSize.height5),
              SizedBox(
                width: AppSize.width250,
                child: CustomText(
                  text: value,
                  textStyle: TextStyles.mediumText,
                  fontSize: AppSize.font15,
                ).paddingSymmetric(
                    horizontal: AppSize.width15, vertical: AppSize.height5),
              ),
            ],
          ),
        ],
      ).paddingAll(10),
    );
  }
}
