import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/add_card/add_card_controller.dart';

class AddCardBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => AddCardController());
   }



}