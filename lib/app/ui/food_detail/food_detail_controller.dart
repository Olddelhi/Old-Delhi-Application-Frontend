import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/shared_preferns.dart';
import '../../responses/product_detail_response.dart';
import '../../services/end_points.dart';
import '../../services/http_services.dart';

class FoodDetailController extends GetxController {
  final RxBool showAllItems = false.obs;

  Rx<ProductDetail> productDetail = ProductDetail().obs;
  RxBool showLoader = true.obs;
  RxList<String> list = <String>[].obs;
  RxString selectedItem = "".obs;
  Rx<ProductItems> productItems = ProductItems().obs;

  RxBool isFavorite = false.obs;
  RxBool showButtonLoader = false.obs;

  var id;
  DateTime now = DateTime.now();

  RxInt quantity = 1.obs;
  // RxInt minOrderQuantity = 1.obs; // Minimum order quantity

  void toggleShowAllItems() {
    showAllItems.value = !showAllItems.value;
  }

  @override
  void onInit() {
    // getArguments();
    // Fetch favorite status when initializing the controller
    fetchFavoriteStatus();
    super.onInit();
  }

  @override
  void onReady() {
    getArguments();
    super.onReady();
  }

  getArguments() {
    id = Get.arguments['itemId'];
    print("iddetails-sssss---->${id.toString()}");
    if (id != null) {
      getItemDetail(id.toString());
    }
  }

  Future<void> fetchFavoriteItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      if (token == null || token.isEmpty) {
        isFavorite.value = false;
        return;
      }

      final response = await httpService.get(
        endPoint: EndPoints.addToFavorites,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final responseData = response.data;
      final data = responseData is Map ? responseData['data'] : null;
      final favoriteItems = data is Map && data['favoriteItems'] is List
          ? data['favoriteItems'] as List<dynamic>
          : <dynamic>[];
      final items = productDetail.value.productItems;

      if (items == null || items.isEmpty) {
        isFavorite.value = false;
        return;
      }

      final productId = items.first.id?.toString();
      final isFavoriteItem = favoriteItems.any((item) {
        if (item is! Map || item['productItem'] is! Map) {
          return false;
        }

        return item['productItem']['id']?.toString() == productId;
      });

      isFavorite.value = isFavoriteItem;
    } catch (e) {
      isFavorite.value = false;
      print('Failed to fetch favorite items: $e');
    }
  }

  // Method to update the price based on selected product configuration
  void updatePrice(String newValue) {
    // Update selectedItem value
    selectedItem.value = newValue;
    // Update the productItems value based on selected product configuration
    productItems.value = productDetail.value.productItems!.firstWhere(
        (item) => item.productConfig!.first.optionValue!.value == newValue,
        orElse: () => productDetail.value.productItems![0]);
  }

  // Future<void> getItemDetail(id) async {
  //   try {
  //     var res = await ApiResponse().getItemDetail(id).then((value) {
  //       if (value != null) {
  //         productDetail.value = value.productDetail!;
  //         productItems.value = value.productDetail!.productItems![0];
  //         for (int i = 0;
  //         i < productDetail.value.productItems!.length;
  //         i++) {
  //           // Check if productConfig list is not null and not empty
  //           if (productDetail.value.productItems![i].productConfig != null &&
  //               productDetail.value.productItems![i].productConfig!.isNotEmpty) {
  //             list.add(
  //                 (productDetail.value.productItems![i].productConfig![0]
  //                     .optionValue?.value) ??
  //                     "");
  //           }
  //         }
  //         showLoader.value = false;
  //         list.refresh();
  //         selectedItem.value = list.isNotEmpty ? list[0] : ""; // Handle empty list case
  //         print("selected item ${selectedItem.value}");
  //         // Parse start and end times from TimeSlot
  //
  //
  //       }
  //     });
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

  Future<void> getItemDetail(id) async {
    print("iddetails----->${id.toString()}");
    try {
      var res = await ApiResponse().getItemDetail(id).then((value) async {
        if (value != null) {
          productDetail.value = value.productDetail!;
          productItems.value = value.productDetail!.productItems![0];
          await fetchFavoriteItems();

          // Clear the list before adding new items
          list.clear();

          for (int i = 0; i < productDetail.value.productItems!.length; i++) {
            // Check if productConfig list is not null and not empty
            if (productDetail.value.productItems![i].productConfig != null &&
                productDetail
                    .value.productItems![i].productConfig!.isNotEmpty) {
              String valueToAdd = productDetail.value.productItems![i]
                      .productConfig![0].optionValue?.value ??
                  "";
              // Check if the valueToAdd is not already in the list
              if (!list.contains(valueToAdd)) {
                list.add(valueToAdd);
              }
            }
          }
          showLoader.value = false;
          list.refresh();
          selectedItem.value =
              list.isNotEmpty ? list[0] : ""; // Handle empty list case
          print("selected item ${selectedItem.value}");
          // Parse start and end times from TimeSlot
        }
      });
    } catch (e) {
      // Handle error
    }
  }

  // getItemDetail(id)async{
  //   var res= await ApiResponse().getItemDetail(id).then((value) {
  //     if(value!=null){
  //       productDetail.value= value.productDetail!;
  //       productItems.value=value.productDetail!.productItems![0];
  //       for(int i=0 ;i< productDetail.value.productItems!.length; i++){
  //         list.add((productDetail.value.productItems![i].productConfig?[0].optionValue!.value)!);
  //       }
  //       showLoader.value=false;
  //       list.refresh();
  //       selectedItem.value=list[0];
  //     }
  //
  //   });
  // }

  addToCart() async {
    showButtonLoader.value = true;
    print("quanityt ${quantity.value}");
    if (quantity.value == 0) {
      print("heree");
      showButtonLoader.value = false;
      // Handle case where quantity is zero (if needed)
    } else if (quantity.value <
        int.parse(productDetail.value.minOrderQuantity!)) {
      // Check if quantity is less than minimum order quantity
      Get.snackbar(
        "Error",
        "Minimum order quantity is ${productDetail.value.minOrderQuantity!}",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      showButtonLoader.value = false;
    } else {
      print("heree111");
      try {
        int selectedIndex = list.indexOf(selectedItem.value);
        print("$selectedIndex");
        if (selectedIndex != -1 &&
            selectedIndex < productDetail.value.productItems!.length) {
          print("heree22");
          var data = {
            "productItemId":
                productDetail.value.productItems![selectedIndex].id.toString(),
            "quantity": quantity.value,
          };
          var res = await ApiResponse().addToCart(data).then((value) {
            if (value == true) {
              Get.snackbar(
                "Success",
                "Product added to cart",
                colorText: Colors.white,
                backgroundColor: Colors.red,
              );
              var controller = Get.find<DashboardController>();
              controller.getCartItems();
              //Get.back();
              showButtonLoader.value = false;
            } else {
              showButtonLoader.value = false;
            }
          });
        } else {
          var data = {
            "productItemId": productDetail.value.productItems![0].id.toString(),
            "quantity": quantity.value,
          };
          var res = await ApiResponse().addToCart(data).then((value) {
            if (value == true) {
              Get.snackbar(
                "Success",
                "Product added to cart",
                colorText: Colors.white,
                backgroundColor: Colors.red,
              );
              var controller = Get.find<DashboardController>();
              controller.getCartItems();
              showButtonLoader.value = false;
              //Get.back();
            } else {
              showButtonLoader.value = false;
            }
          });
        }
      } catch (e) {
        print("error add to cart ${e.toString()}");
        showButtonLoader.value = false;
      }
    }
  }

  // Future<void> addToCart() async {
  //   showButtonLoader.value = true;
  //   if (quantity.value < int.parse(productDetail.value.minOrderQuantity!)) {
  //     // Check if quantity is less than minimum order quantity
  //     Get.snackbar("Error", "Minimum order quantity is ${productDetail.value.minOrderQuantity!}");
  //     showButtonLoader.value = false;
  //   } else {
  //     try {
  //       int selectedIndex = list.indexOf(selectedItem.value);
  //       if (selectedIndex != -1 &&
  //           selectedIndex < productDetail.value.productItems!.length) {
  //         var data = {
  //           "productItemId": productDetail.value.productItems![selectedIndex].id.toString(),
  //           "quantity": quantity.value,
  //         };
  //         var res = await ApiResponse().addToCart(data).then((value) {
  //           if (value == true) {
  //             Get.snackbar("Success", "Product added to cart");
  //             var controller = Get.find<DashboardController>();
  //             controller.getCartItems();
  //           }
  //           showButtonLoader.value = false;
  //         });
  //       }
  //     } catch (e) {
  //       print("error add to cart ${e.toString()}");
  //       showButtonLoader.value = false;
  //     }
  //   }
  // }

  void addToFavorites() async {
    var productId = productDetail.value.productItems![0].id.toString();
    await ApiResponse().addToFavorites(productId);
    isFavorite.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite', isFavorite.value);
    // update();
  }

  // Method to fetch favorite status from local storage
  Future<void> fetchFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve favorite status from local storage
    bool favoriteStatus = prefs.getBool('isFavorite') ?? false;
    // Update isFavorite value in the controller
    isFavorite.value = favoriteStatus;
  }

  // Future<void> fetchFavoriteStatus() async {
  //
  //
  //   // var productId = productDetail.value.productItems![0].id.toString();
  //   // var favoriteStatus = await ApiResponse().getFavoriteStatus(productId);
  //   // isFavorite = favoriteStatus ?? false;
  //   // update();
  // }

  void removeFromFavorites() async {
    var productId = productDetail.value.id.toString();
    await ApiResponse().removeFromFavorites(productId);
    // Update UI or perform any additional actions
    isFavorite.value = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite', isFavorite.value);
    // update();
  }

  // Increase quantity
  void increaseQuantity() {
    quantity++;
  }

  // Decrease quantity
  void decreaseQuantity() {
    if (quantity > int.parse(productDetail.value.minOrderQuantity!)) {
      quantity--;
    }
  }
}
