import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/your_favourite/your_favourite_controller.dart';

class YourFavouriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => YourFavouriteController());
  }


}