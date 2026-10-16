import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/shop_item/shop_item_controller.dart';

class ShopItemBinding extends Bindings{


  @override
  void dependencies() {
   Get.lazyPut(() => ShopItemController());
  }



}