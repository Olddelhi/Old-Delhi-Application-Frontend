import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/Home/home_controller.dart';

class HomeBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }



}