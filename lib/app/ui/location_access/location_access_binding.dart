import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/location_access/location_access_controller.dart';

class LocationAccessBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => LocationAccesController());
  }



}