import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/profile/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }


}