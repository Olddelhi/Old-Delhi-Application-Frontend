import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/responses/specfic_category_response.dart';
import 'package:old_delhi_food/app/services/api_response.dart';

class ShopItemController extends GetxController {
  var searchTextController = TextEditingController().obs;
  RxList<CategoryDetail> specificCategoryList = <CategoryDetail>[].obs;
  RxList<CategoryDetail> searchedCategoryList = <CategoryDetail>[].obs;
  RxString category = "".obs;
  RxBool isLoading = false.obs;
  RxBool showSearchBar = false.obs;
  RxBool fromShop = false.obs;
  var currentPage = 1.obs;
  var hasMore = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onReady() {
    getArguments();
    super.onReady();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print("hasmore $hasMore");
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        hasMore.value) {
      getSpecificCategory(category.value, fromShop.value, isLoadMore: true);
    }
  }

  getArguments() {
    category.value = Get.arguments['category'];
    fromShop.value = Get.arguments['fromShop'] ?? false;
    getSpecificCategory(category.value, fromShop.value);
  }

  void getSpecificCategory(String category, bool fromShop,
      {bool isLoadMore = false}) async {
    if (isLoadMore) {
      currentPage.value += 1;
    } else {
      isLoading.value = true;
      currentPage.value = 1;
      specificCategoryList.clear();
      hasMore.value = true;
    }

    try {
      var res = await ApiResponse()
          .getSpecificCategory(category, fromShop, currentPage.value);
      if (res != null) {
        if (res.categoryDetail!.isEmpty) {
          hasMore.value = false;
        } else {
          specificCategoryList.addAll(res.categoryDetail!);
        }
      }
    } catch (e) {
      hasMore.value = false;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void searchItem(String value) {
    final searchItemLowerCase = value.toLowerCase();
    searchedCategoryList.value = specificCategoryList.where((element) {
      final elementLowerCase = element.name?.toLowerCase();
      return (elementLowerCase?.contains(searchItemLowerCase))!;
    }).toList();
    searchedCategoryList.refresh();
    specificCategoryList.refresh();
    update();
  }

  // Method to sort items by name in ascending order
  void sortByNameAscending() {
    specificCategoryList.sort((a, b) => a.name!.compareTo(b.name!));
  }

  // Method to sort items by name in descending order
  void sortByNameDescending() {
    specificCategoryList.sort((a, b) => b.name!.compareTo(a.name!));
  }

  // Method to sort items by price in ascending order
  void sortByPriceAscending() {
    specificCategoryList.sort((a, b) => a.price!.compareTo(b.price!));
  }

  // Method to sort items by price in descending order
  void sortByPriceDescending() {
    specificCategoryList.sort((a, b) => b.price!.compareTo(a.price!));
  }
}
