import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/new_password/new_password_controller.dart';

class NewPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewPasswordController());
  }



}