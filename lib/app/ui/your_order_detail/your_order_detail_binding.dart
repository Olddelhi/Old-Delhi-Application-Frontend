import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/your_order_detail/your_order_detail_controller.dart';

class YourOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => YourOrderDetailController());
  }
}
