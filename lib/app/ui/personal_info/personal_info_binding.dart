import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/personal_info/personal_info_controller.dart';

class PersonalInfoBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalInfoController());
  }





}