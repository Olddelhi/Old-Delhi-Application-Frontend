import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/Home/home_controller.dart';

import '../../responses/specfic_category_response.dart';
import '../../responses/category_response.dart' as category;

class SearchProductController extends GetxController {
  RxString nonVegCategory = "".obs;
  RxString vegCategory = "".obs;
  RxList<CategoryDetail> specificCategoryList = <CategoryDetail>[].obs;

  final homeController = Get.find<HomeController>();

  @override
  void onReady() {
    // getArguments();
    super.onReady();
  }

  getArguments() {
    vegCategory.value = Get.arguments['categoryVeg'];
    nonVegCategory.value = Get.arguments['categoryNonVeg'] ?? false;
  }

  var searchText = ''.obs;

  // Sort categories method
  void sortCategories(List<String> customOrder) {
    filteredCategories.sort((a, b) {
      final indexA = customOrder.indexOf(a.name!);
      final indexB = customOrder.indexOf(b.name!);
      return indexA.compareTo(indexB);
    });
  }

  RxList<category.Category> get filteredCategories {
    if (searchText.isEmpty) {
      return homeController.categoryList;
    } else {
      final filteredCategories = homeController.categoryList
          .where((category) =>
              category.name!.toLowerCase().contains(searchText.toLowerCase()) ||
              (category.subCategories != null &&
                  category.subCategories!.any((subCategory) => subCategory
                      .toString()
                      .toLowerCase()
                      .contains(searchText.toLowerCase()))))
          .toList();

      // Separate categories and subcategories
      final List<category.Category> categories = [];
      final List<category.Category> subCategories = [];

      for (var category in filteredCategories) {
        if (category.subCategories != null &&
            category.subCategories!.isNotEmpty) {
          subCategories.add(category);
        } else {
          categories.add(category);
        }
      }

      return RxList(subCategories.isEmpty ? categories : subCategories);
    }

    // if (searchText.isEmpty) {
    //   return homeController.categoryList;
    // } else {
    //   return RxList(homeController.categoryList
    //       .where((category) =>
    //   category.name!.toLowerCase().contains(searchText.toLowerCase()) ||
    //       (category.subCategories != null &&
    //           category.subCategories!.any((subCategory) =>
    //               subCategory.toString().toLowerCase().contains(searchText.toLowerCase()))))
    //       .toList());
    // }
  }

  void search(String query) {
    searchText.value = query;
  }

  // void getSpecificCategory(category, fromShop) async{
  //   var res= await ApiResponse().getSpecificCategory(category.toString(), fromShop).then((value){
  //     if(value!=null){
  //       specificCategoryList.value=value.categoryDetail!;
  //     }
  //   });
  // }
}
