import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/payment_successfull/payment_successfull_controller.dart';

class PaymentSuccessfullBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut(() => PaymentSuccessfullController());
  }



}
class PaymentUnSuccessfullBinding extends Bindings{


  @override
  void dependencies() {

    Get.lazyPut(() => PaymentUnSuccessfullController());
  }



}