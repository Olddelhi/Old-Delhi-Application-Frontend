import 'dart:async';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_screen.dart';
import 'package:old_delhi_food/app/ui/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/shared_preferns.dart';

class SplashScreenController extends GetxController {
  Timer? timer;

  @override
  void onInit() {
    print('onInit is called');
    startTimer();
    super.onInit();
  }

  @override
  void onReady() {
    print('onReady is called');
    // Remove the duplicate Get.toNamed() call from onReady
    super.onReady();
  }

  void startTimer() {
    timer = Timer(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if ((prefs.get(SharedPrefs.keys.authToken) != "" &&
          prefs.get(SharedPrefs.keys.authToken) != null)) {
        Get.offAll(() => DashboardScreen());
      } else {
        // not logged in
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    timer?.cancel();
    super.onClose();
  }
}
