import 'package:get/get.dart';

import '../../responses/shop_response.dart';
import '../../services/api_response.dart';

class PopularShopController extends GetxController{

 RxList<Shop> shopList= <Shop>[].obs;


  @override
  void onInIt(){

    // getAllCategories();
    super.onInit();
  }

  @override
  void onReady()
  {
    // getShopList();
    super.onReady();
  }





  getShopList()async{
    var res= await ApiResponse().getShopList().then((value) {
      if(value!=null){

        shopList.value=value.shop!;
        shopList.refresh();
      }

    });
  }
}