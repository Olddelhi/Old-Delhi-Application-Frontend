import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/checkout/checout_controller.dart';

class CheckoutBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController());
  }


}