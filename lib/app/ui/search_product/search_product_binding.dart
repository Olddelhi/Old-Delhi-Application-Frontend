import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/search_product/search_product_controller.dart';

class SearchProductBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => SearchProductController());
  }


}