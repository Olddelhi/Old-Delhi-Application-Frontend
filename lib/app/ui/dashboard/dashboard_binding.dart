import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_controller.dart';

class DashboardBinding extends Bindings{


  @override
  void dependencies() {
   Get.lazyPut(() => DashboardController());
  }


}