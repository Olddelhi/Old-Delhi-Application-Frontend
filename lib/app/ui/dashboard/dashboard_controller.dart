import 'package:get/get.dart';

import '../../responses/get_cart_response.dart';
import '../../services/api_response.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<CardItems> cardItemList = <CardItems>[].obs;

  @override
  void onReady() {
    getCartItems();
    super.onReady();
  }

  getCartItems() {
    var res = ApiResponse().getCartItems().then((value) {
      if (value != null || value?.data != null) {
        cardItemList.value = value!.data!.cardItems!;
        update();
      }
    });
  }
}
