import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/payment_method/payment_method_controller.dart';

class PaymentMethodBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut(() => PaymentMethodController());
  }



}