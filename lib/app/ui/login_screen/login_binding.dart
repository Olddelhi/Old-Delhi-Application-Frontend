import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/login_screen/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }

}