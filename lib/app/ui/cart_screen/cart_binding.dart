import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/cart_screen/cart_controller.dart';

class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }


}