import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/track_order/track_order_controller.dart';

class TrackOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TrackOrderController());
  }


}