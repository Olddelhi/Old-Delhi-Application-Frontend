import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/splash_screen/splash_screen_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';

class SplashScreen extends GetView<SplashScreenController> {
  SplashScreen({super.key});

  @override
  SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: Get.height,
            width: Get.width,
            child: Image.asset(
              AppAssets.splashScreenUpdated,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            )),
        // Center(child: Image.asset(AppAssets.splashIcon, color: Colors.black,).animate().tint(duration:Duration(seconds: 3), color: AppColors.primary).then().shake(duration: Duration(seconds: 1)))
      ],
    ));
  }
}
