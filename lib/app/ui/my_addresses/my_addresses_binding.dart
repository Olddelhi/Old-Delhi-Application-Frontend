import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/my_addresses/my_addresses_controller.dart';

class MyAddressesBinding extends Bindings{



  @override
  void dependencies() {
    Get.lazyPut(() => MyAddressesController());
   }



}