import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/food_detail/food_detail_controller.dart';

class FoodDetailBinding extends Bindings{


  @override
  void dependencies() {
     Get.lazyPut(() => FoodDetailController());
  }



}