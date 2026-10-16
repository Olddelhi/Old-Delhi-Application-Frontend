import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/edit_profile/edit_profile_controller.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }




}