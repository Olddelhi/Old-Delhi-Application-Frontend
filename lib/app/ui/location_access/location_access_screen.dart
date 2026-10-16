import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/location_access/location_access_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';

import '../../components/text_styles.dart';

class LocationAccesScreen extends GetView<LocationAccesController> {
  LocationAccesScreen({super.key});

  @override
  final controller = Get.put(LocationAccesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.googleMapIcon,
              height: AppSize.height200,
              width: AppSize.width200,
            ).paddingOnly(bottom: AppSize.height15),
            _accessLocationButton().paddingOnly(top: AppSize.height50),
            CustomText(
              text: AppStrings.willAccessYourLocation.toUpperCase(),
              fontSize: AppSize.font15,
              color: Colors.black45,
              textStyle: TextStyles.mediumText,
            ).paddingOnly(
                top: AppSize.height20,
                bottom: AppSize.height35,
                right: AppSize.width40,
                left: AppSize.width40),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.manuallyDetailScreen);
                },
                child: CustomText(
                  text: AppStrings.enterManually.toUpperCase(),
                  fontSize: AppSize.font12,
                  color: Colors.black45,
                  textStyle: TextStyles.mediumText,
                ).paddingSymmetric(horizontal: AppSize.width20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _accessLocationButton() {
    return AppButton(
      onTap: () {
        // controller.getLocationPermission();
      },
      text: AppStrings.accessLocation,
      isIcon: true,
      image: AppAssets.mapPinIcon,
    ).paddingSymmetric(horizontal: AppSize.width80);
  }
}
