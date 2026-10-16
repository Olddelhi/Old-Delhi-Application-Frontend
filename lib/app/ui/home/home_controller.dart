import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/responses/get_banner_response.dart';
import 'package:old_delhi_food/app/services/api_response.dart';
import '../../responses/category_response.dart';
import '../../responses/get_address_response.dart';
import '../../responses/get_all_product_respobse.dart' as all_product;
import '../../responses/product_detail_response.dart' as product;
import '../../responses/shop_response.dart';
import '../../responses/status_response.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  RxBool showListItem = false.obs;
  FocusNode searchTextNode = FocusNode();
  RxList<AddressList> addressList = <AddressList>[].obs;
  RxBool productLoading = false.obs;
  RxList<dynamic> filteredProductList = <dynamic>[].obs;

  RxList<dynamic> products = <dynamic>[].obs;

  RxList<Category> categoryList = <Category>[].obs;
  RxList<Category> categoryList1 = <Category>[].obs;

  RxList<Shop> shopList = <Shop>[].obs;

  final RxBool showAllItems = false.obs;

  RxList<Shop> filteredShopList = <Shop>[].obs;

  RxList<product.ProductDetail> productList = <product.ProductDetail>[].obs;
  RxList<dynamic> dataList = [].obs;

  var allProducts =
      <all_product.Datum>[].obs; // Observed variable to hold products
  List<all_product.Datum> filteredProducts = <all_product.Datum>[].obs;
  List<all_product.Datum> filteredVegProducts = <all_product.Datum>[].obs;
  List<all_product.Datum> filteredNonVegProducts = <all_product.Datum>[].obs;
  List<all_product.Datum> filteredNamkeenProducts = <all_product.Datum>[].obs;
  List<all_product.Datum> filteredChaatProducts = <all_product.Datum>[].obs;

  RxString selectedCategory = 'All'.obs;

  RxList<StatusData> data = <StatusData>[].obs;
  RxList<BannerModel> bannerData = <BannerModel>[].obs;

  RxInt currentPageIndex = 0.obs;

  void toggleShowAllItems() {
    showAllItems.value = !showAllItems.value;
  }

  @override
  void onInit() {
    filteredShopList.value = shopList;

    // getAllCategories();
    super.onInit();
  }

  @override
  void onReady() {
    getAllCategories();
    // getShopList();
    getAllProduct();
    fetchAllProducts();
    getAddress();
    getStatus();
    getBannerDetails();
    super.onReady();
  }

  // void playVideoFullScreen(String videoUrl) {
  //  if (_controller != null) {
  //   _controller!.dispose();
  //  }
  //  _controller = VideoPlayerController.networkUrl(Uri.parse("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
  //   _controller?.initialize().then((_) {
  //    _controller!.play();
  //    Get.to(
  //     FullScreenVideoScreen(controller: _controller!),
  //    );
  //   });
  // }

  void fetchAllProducts() async {
    try {
      // isLoading(true);
      var products = await ApiResponse().getAllProductAtOnce();
      allProducts.clear();
      filteredProducts.clear();
      filteredNonVegProducts.clear();
      filteredNamkeenProducts.clear();
      filteredVegProducts.clear();
      filteredChaatProducts.clear();
      if (products != null) {
        allProducts.assignAll(products);
        filteredProducts.assignAll(products);
        removeDuplicates();
        debugPrint("all product length $allProducts");
        // Filter products by categories
        filteredVegProducts.assignAll(products.where((product) =>
            product.category.name == "Veg" ||
            product.category.name == 'Chandini Chowk Se' ||
            product.category.name == 'Sita Ram Diwan Chand (Chole Bhaturey)' ||
            product.category.name == 'Sita Ram Diwan Chand (Chole Bhaturey)' ||
            product.category.name == 'Sita Ram Diwan Chand (Chole Bhaturey)'));
        removeDuplicates1(filteredVegProducts);
        filteredNonVegProducts.assignAll(products.where((product) =>
            product.category.name == "Non Veg" ||
            product.category.name == 'Jama Mazjid Se' ||
            product.category.slug == 'AL Jawahar - Specialities'));
        removeNonVegDuplicates();
        filteredNamkeenProducts.assignAll(products.where((product) =>
            product.category.name == "Namkeens & Sweets" ||
            product.category.name == "Meghraj & Sons Namkeens" ||
            product.category.name == "Sweets" ||
            product.category.name == 'Kanwarji Bhagirath Mal Sweets' ||
            product.category.name == 'Kanwarji Bhagirath Mal Namkeen' ||
            product.category.name == 'Jiwaram Sweets' ||
            product.category.name == 'Chaina Ram Sindhi Confectioners' ||
            product.category.name == 'Annapurna Bhandar'));
        removeNamkeenDuplicates();
        filteredChaatProducts.assignAll(products.where((product) =>
            product.category.name == "Chaat" ||
            product.category.name == 'Ashok Chaat Corner'));
        // Remove duplicates from filtered lists
        removeChaatDuplicates();
      } else {
        // Handle error condition here
      }
    } finally {
      // isLoading(false);
    }
  }

  // Method to filter shopList based on search query
  void filterShopList(String query) {
    if (query.isEmpty) {
      // If search query is empty, reset filteredShopList to the entire shopList
      filteredShopList.value = shopList;
    } else {
      // Filter shopList based on search query
      filteredShopList.value = shopList
          .where((shop) =>
              shop.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
  }

  getAddress() {
    var res = ApiResponse().getAddress().then((value) {
      if (value != null) {
        addressList.value = value.addressList!;
      }
    });
  }

  getAllCategories() async {
    try {
      var response = await ApiResponse().getAllCategories().then((value) {
        if (value != null) {
          categoryList.value = value.category!;
          categoryList1.value = value.category!;
        }
      });
    } catch (E) {
      print("error from category$E");
    }
  }

  // Method to filter productList based on search query
  void filterProductList(String query) {
    if (query.isEmpty) {
      // If search query is empty, reset filteredProductList to the entire productList
      filteredProductList.value = productList;
    } else {
      print("Query: $query");
      filteredProductList.assignAll(productList.where((productDetail) {
        bool containsQuery = productDetail.productItems!.any((item) =>
            item.product!.name!.toLowerCase().contains(query.toLowerCase()));
        print(
            "Product: ${productDetail.productItems![0].product!.name}, ContainsQuery: $containsQuery");
        return containsQuery;
      }).toList());
    }
    print(filteredProductList); // Print filtered list for debugging
  }

  getAllProduct() async {
    try {
      productLoading.value = true;
      var response = await ApiResponse().getAllProduct().then((value) {
        if (value != null) {
          products.clear(); // Clear the existing products list
          products.assignAll(value['data']);
          // var productList = all_product.productFromJson(jsonEncode(value));
          // allProducts.assignAll(productList.data); // Assign products to the observed variable

          // filteredProductList.assignAll(value['data']);
          for (var product in value['data']) {
            var productName = product['name'];
            var productPrice = product['price'];
            var imageUrl = product['shop']['images'][0]['url'];
            // print('Product Name: $productName, Price: $productPrice');
          }
          // productList.assignAll([value.productDetail!]);
          // print("product response ${  value['data']}");
          productLoading.value = false;
        } else {
          productLoading.value = false;
        }
      });
    } catch (E) {
      productLoading.value = false;
      print("error from all products$E");
    }
  }

  Future<void> filterProducts(String query) async {
    if (query.isEmpty) {
      filteredProductList.assignAll(products);
      return;
    }

    try {
      var res = await ApiResponse().getFilterShop(query);

      print("Search API Response: $res"); // Debugging

      if (res is List) {
        filteredProductList.assignAll(res); // Directly assign if it's a list
      } else {
        print("Unexpected response format: $res");
        filteredProductList.clear();
      }
    } catch (e) {
      print("Error fetching search results: $e");
      filteredProductList.clear();
    }
  }

  // void filterProducts(String query) {
  //  print("query ${query}  ${filteredProductList.length}  ${products.length}");
  //  if (query.isNotEmpty) {
  //   // Filter the products list based on the search query
  //   filteredProductList.assignAll(products.where((product) {
  //    final productName = product['name'].toString().toLowerCase();
  //    return productName.contains(query.toLowerCase());
  //   }).toList());
  //   print("filtered list ${filteredProductList}");
  //   print("filtered list ${products}");
  //   // print("Product: ${productDetail.productItems![0].product!.name}, ContainsQuery: $containsQuery");
  //  } else {
  //   // If the search query is empty, reset the products list to show all products
  //   filteredProductList.assignAll(products);
  //  }
  // }

  getShopList() async {
    var res = await ApiResponse().getShopList().then((value) {
      if (value != null) {
        shopList.value = value.shop!;
        shopList.refresh();
      }
    });
  }

  getStatus() async {
    var res = await ApiResponse().getStatus().then((value) {
      if (value != null) {
        data.value = value;
        // print("data of statusssss${data}");
        // for (StatusData item in data) {
        //  print('Name: ${item.name}');
        //  print('Description: ${item.description}');
        // }
      }
    });
  }

  void filterByCategory(String category) {
    print('Filtering by category: $category');

    selectedCategory.value = category;
    switch (category) {
      case 'All':
        filteredProducts.assignAll(allProducts);
        break;
      case 'Veg':
        filteredVegProducts.clear(); // Clear the filtered list first
        filteredVegProducts.assignAll(allProducts.where((product) =>
            product.category.name == 'Veg' ||
            product.category.name == 'Chandini Chowk Se' ||
            product.category.name == 'Sita Ram Diwan Chand (Chole Bhaturey)' ||
            product.category.name == 'Sita Ram Diwan Chand (Chole Bhaturey)' ||
            product.category.name == 'Sita Ram Diwan Chand (Chole Bhaturey)'));

        break;

      case 'Non Veg':
        filteredNonVegProducts.clear();
        filteredNonVegProducts.assignAll(allProducts.where((product) =>
            product.category.name == 'Non Veg' ||
            product.category.name == 'Jama Mazjid Se' ||
            product.category.name == 'Specialities'));

        break;
      case 'Namkeens & Sweets':
        filteredNamkeenProducts.clear();
        filteredNamkeenProducts.assignAll(allProducts.where((product) =>
            product.category.name == 'Namkeens & Sweets' ||
            product.category.name == "Meghraj & Sons Namkeens" ||
            product.category.name == "Sweets" ||
            product.category.name == 'Kanwarji Bhagirath Mal Sweets' ||
            product.category.name == 'Kanwarji Bhagirath Mal Namkeen' ||
            product.category.name == 'Jiwaram Sweets' ||
            product.category.name == 'Chaina Ram Sindhi Confectioners' ||
            product.category.name == 'Annapurna Bhandar'));

        break;
      case 'Chaat':
        filteredChaatProducts.clear();
        filteredChaatProducts.assignAll(allProducts.where((product) =>
            product.category.name == 'Chaat' ||
            product.category.name == 'Ashok Chaat Corner'));

        break;
      default:
        filteredProducts.assignAll(allProducts);
        break;
    }
    removeDuplicates();
  }

  void removeDuplicates() {
    Set<String> uniqueShops = <String>{};
    List<all_product.Datum> uniqueProducts = [];
    for (var product in filteredProducts) {
      if (!uniqueShops.contains(product.shop.name)) {
        uniqueShops.add(product.shop.name);
        uniqueProducts.add(product);
      }
    }
    filteredProducts.assignAll(uniqueProducts);
  }

  void removeNonVegDuplicates() {
    Set<String> uniqueShops = <String>{};
    List<all_product.Datum> uniqueProducts = [];
    for (var product in filteredNonVegProducts) {
      if (!uniqueShops.contains(product.shop.name)) {
        uniqueShops.add(product.shop.name);
        uniqueProducts.add(product);
      }
    }
    filteredNonVegProducts.assignAll(uniqueProducts);
  }

  void removeChaatDuplicates() {
    Set<String> uniqueShops = <String>{};
    List<all_product.Datum> uniqueProducts = [];
    for (var product in filteredChaatProducts) {
      if (!uniqueShops.contains(product.shop.name)) {
        uniqueShops.add(product.shop.name);
        uniqueProducts.add(product);
      }
    }
    filteredChaatProducts.assignAll(uniqueProducts);
  }

  void removeNamkeenDuplicates() {
    Set<String> uniqueShops = <String>{};
    List<all_product.Datum> uniqueProducts = [];
    for (var product in filteredNamkeenProducts) {
      if (!uniqueShops.contains(product.shop.name)) {
        uniqueShops.add(product.shop.name);
        uniqueProducts.add(product);
      }
    }
    filteredNamkeenProducts.assignAll(uniqueProducts);
  }

  void removeDuplicates1(List<all_product.Datum> productList) {
    var uniqueIds = <String>{};
    productList.removeWhere((product) => !uniqueIds.add(product.id));
  }

  getBannerDetails() async {
    var res = await ApiResponse().getBanner().then((value) {
      if (value != null) {
        bannerData.value = value;
      }
    });
  }
}
