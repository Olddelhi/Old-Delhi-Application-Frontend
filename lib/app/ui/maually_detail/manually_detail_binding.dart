import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/maually_detail/maually_detail_controller.dart';

class ManuallyDetailBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => ManuallyDetailController());
  }


}