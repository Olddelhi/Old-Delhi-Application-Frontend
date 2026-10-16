import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/splash_screen/splash_screen_controller.dart';

class SplashScreenBinding implements Bindings{
  @override
  void dependencies() {
   // Get.lazyPut(() => SplashScreenController());
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());

  }}