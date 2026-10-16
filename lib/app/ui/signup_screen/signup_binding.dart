import 'package:get/instance_manager.dart';
import 'package:old_delhi_food/app/ui/signup_screen/signup_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }



}