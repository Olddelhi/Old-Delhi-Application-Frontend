import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/profile/profile_controller.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:old_delhi_food/app/components/text_styles.dart'; // Corrected import path
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import '../../components/cutom_text.dart';
import '../../components/shared_preferns.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  @override
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            _profileName(),
            _personalInfoContainer().paddingOnly(top: AppSize.height15),
            _personalInfoContainer2().paddingOnly(top: AppSize.height15),
            _personalInfoContainer3().paddingOnly(top: AppSize.height15),
            _personalInfoContainer4().paddingOnly(top: AppSize.height15)
          ],
        ).paddingSymmetric(horizontal: AppSize.width15),
      ),
    ));
  }

  Widget _appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Image.asset(
              AppAssets.backIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: CustomText(
            text: AppStrings.profile,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    );
  }

  Widget _profileName() {
    return Obx(() {
      var user =
          controller.user.value; // Accessing the user data from the controller
      // debugPrint("user.profile?.fullName${user.profile?.fullName}  ${user.name}");

      return Row(
        children: [
          user.profile?.image?.url == null
              ? Container(
                  height: AppSize.height80,
                  width: AppSize.width80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.orangeAccent),
                )
              : CircleAvatar(
                  radius: AppSize
                      .width40, // Adjust the size of the avatar as needed
                  backgroundColor: Colors
                      .orangeAccent, // You can set any background color you want
                  backgroundImage: NetworkImage(user.profile?.image?.url ??
                      ""), // Set the image URL as the background image
                ),
          CustomText(
            text: user.profile?.fullName ?? user.name ?? '',
            textStyle: TextStyles.boldText, // Displaying user's name
            fontSize: AppSize.font20,
          ).paddingOnly(left: AppSize.width25)
        ],
      );
    });
  }

  Widget _personalInfoContainer() {
    return Container(
        // height: AppSize.height150,
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset:
                    const Offset(0, 5), // changes the position of the shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))),
        child: Column(
          children: [
            _profileInfoRow(AppAssets.personIcon, AppStrings.personalInfo, () {
              Get.toNamed(AppPages.personalInfoScreen);
            }),
            _profileInfoRow(AppAssets.addressIcon, AppStrings.addresses, () {
              Get.toNamed(AppPages.myAddressesScreen);
            }),
          ],
        ).paddingSymmetric(
            horizontal: AppSize.width10, vertical: AppSize.height10));
  }

  Widget _personalInfoContainer2() {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset:
                    const Offset(0, 5), // changes the position of the shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))),
        child: Column(
          children: [
            _profileInfoRow(AppAssets.profileCartIcon, AppStrings.cart, () {
              Get.toNamed(AppPages.cartScreen);
            }),
            _profileInfoRow(AppAssets.loveIcon, AppStrings.favourite, () {
              Get.toNamed(AppPages.yourFavouriteScreen);
            }),
            // _profileInfoRow(AppAssets.notificationIcon, AppStrings.notification,(){} ),
            // _profileInfoRow(AppAssets.paymentMethodIcon, AppStrings.paymentMethod,(){}  ),
          ],
        ).paddingSymmetric(
            horizontal: AppSize.width10, vertical: AppSize.height10));
  }

  Widget _personalInfoContainer3() {
    return Container(
        // height: AppSize.height150,
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset:
                    const Offset(0, 5), // changes the position of the shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))),
        child: Column(
          children: [
            _profileInfoRow(AppAssets.loveIcon, AppStrings.faqs, () {}),
            //  _profileInfoRow(AppAssets.yourOrderIcon, AppStrings.userReviews,(){}  ),
            _profileInfoRow(AppAssets.profileCartIcon, AppStrings.yourOrder,
                () {
              Get.toNamed(AppPages.yourOrderScreen);
            }),
          ],
        ).paddingSymmetric(
            horizontal: AppSize.width10, vertical: AppSize.height10));
  }

  Widget _personalInfoContainer4() {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset:
                    const Offset(0, 5), // changes the position of the shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))),
        child: Column(
          children: [
            _profileInfoRow(AppAssets.logOutIcon, AppStrings.logOut, () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString(SharedPrefs.keys.authToken, '');
              Get.toNamed(AppPages.loginScreen);
            }),
          ],
        ).paddingSymmetric(
            horizontal: AppSize.width10, vertical: AppSize.height10));
  }

  Widget _profileInfoRow(String icon, String text, Function() onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            icon,
            height: AppSize.height30,
            width: AppSize.width35,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: CustomText(
              text: text,
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font15,
            ).paddingSymmetric(
                horizontal: AppSize.width15, vertical: AppSize.height5),
          ),
          Image.asset(
            AppAssets.rightArrowIcon,
            height: AppSize.height30,
            width: AppSize.width30,
          ),
        ],
      ).paddingAll(10),
    );
  }
}
