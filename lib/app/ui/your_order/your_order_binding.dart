import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/your_order/your_order_controller.dart';

class YourOrderBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => YourOrderController());
  }


}