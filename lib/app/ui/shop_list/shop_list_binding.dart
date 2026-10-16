import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/shop_list/shop_list_controller.dart';

class ShopListBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => ShopListController());
  }



}