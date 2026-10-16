import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/search_product/search_product_controller.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';
import '../../components/text_styles.dart';
import '../../responses/category_response.dart';
import '../../utils/app_pages.dart';
import '../Home/home_controller.dart';

class SearchProductScreen extends GetView<SearchProductController> {
  SearchProductScreen({super.key});

  @override
  SearchProductController controller = Get.put(SearchProductController());
  HomeController homeController = Get.find<HomeController>();
// Define a custom order for categories
  final customOrder = [
    "Namkeens & Sweets",
    "Chandini Chowk Se",
    "Kuremal Kulfi",
    "Jama Mazjid Se",
    "Chaat",
    "Purani Dilli Spices",
    "Gajak",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.width20, vertical: AppSize.height35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).maybePop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black45,
                    )),
                Expanded(
                  child: TextFormField(
                    onChanged: controller.search,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Product',
                    ),
                  ).paddingOnly(left: AppSize.width10),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Expanded(
            //   child: ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     padding: EdgeInsets.zero,
            //     itemCount: homeController.categoryList.length,
            //     itemBuilder: (context, index) {
            //       return buildCategoryItem(homeController.categoryList[index]);
            //     },
            //   ),
            // ),

            Obx(() {
              controller.filteredCategories.sort((a, b) {
                final indexA = customOrder.indexOf(a.name!);
                final indexB = customOrder.indexOf(b.name!);
                return indexA.compareTo(indexB);
              });
              final filteredCategories = controller.filteredCategories;
              return controller.filteredCategories.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.zero,
                        itemCount: controller.filteredCategories.length,
                        itemBuilder: (context, index) {
                          final category = filteredCategories[index];
                          if (category.subCategories != null &&
                              category.subCategories!.isNotEmpty) {
                            return buildCategoryItem(category);
                          } else {
                            return buildCategoryItem(category);
                          }
                          // return buildCategoryItem(controller.filteredCategories[index]);
                        },
                      ),
                    );
            }),

            // Expanded(child: SizedBox()),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(AppPages.personalInfoScreen);
                },
                child: textIconRow(AppStrings.profile, Icons.person_outline)),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(AppPages.cartScreen);
                },
                child:
                    textIconRow(AppStrings.cart, Icons.card_travel_outlined)),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(AppPages.yourFavouriteScreen);
                },
                child: textIconRow(AppStrings.wishList, Icons.favorite_border)),
          ],
        ),
      ),
    );
  }

  // Widget buildCategoryItem(Category category) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: InkWell(
  //       onTap: () {
  //
  //       },
  //       child: ExpansionTile(
  //         title: CustomText(
  //           text: category.name!.toUpperCase(),
  //           textStyle: TextStyles.mediumText,
  //           color: Colors.black,
  //           fontSize: AppSize.font15,
  //         ),
  //
  //         children:
  //
  //         buildSubCategoryList(category.subCategories)
  //       ),
  //     ),
  //   );
  // }

  Widget buildCategoryItem(Category category) {
    if (category.subCategories == null || category.subCategories!.isEmpty) {
      // If there are no subcategories, navigate to another page
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () {
            // Navigate to another page
            Get.toNamed(AppPages.shopItemScreen, arguments: {
              "category": category.slug,
            });
          },
          child: ListTile(
            title: CustomText(
              text: category.name!.toUpperCase(),
              textStyle: TextStyles.mediumText,
              color: Colors.black,
              fontSize: AppSize.font15,
            ),
          ),
        ),
      );
    } else {
      // If there are subcategories, expand to show them
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ExpansionTile(
          title: CustomText(
            text: category.name!.toUpperCase(),
            textStyle: TextStyles.mediumText,
            color: Colors.black,
            fontSize: AppSize.font15,
          ),
          children: buildSubCategoryList(category.subCategories),
        ),
      );
    }
  }

  List<Widget> buildSubCategoryList(List<dynamic>? subCategories) {
    if (subCategories == null || subCategories.isEmpty) {
      return [];
    }

    return subCategories.map((subCategory) {
      if (subCategory is Map<String, dynamic>) {
        final category = Category.fromJson(subCategory);
        return buildCategoryItem(category);
      } else {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomText(
              text: subCategory.toString(),
              textStyle: TextStyles.mediumText,
              color: Colors.black,
              fontSize: AppSize.font15,
            ),
          ),
        );
      }
    }).toList();
  }
}

// class SearchProductScreen extends GetView<SearchProductController>{
//    SearchProductScreen({super.key});
//
//    SearchProductController controller = Get.put(SearchProductController());
//    HomeController homeController = Get.find<HomeController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: AppSize.width20, vertical: AppSize.height35),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 GestureDetector(
//                     onTap: (){
//                       Get.back();
//                     },
//                     child: Icon(Icons.arrow_back, color: Colors.black45,)),
//
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       hintText: 'Search Product',
//                     ),
//                   ).paddingOnly(left: AppSize.width10),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.zero,
//                 itemCount: homeController.categoryList.length,
//                 itemBuilder: (context, index) {
//                     // Adjust index to account for static text
//                       var data = homeController.categoryList[index];
//                       return CategoryItem(category: data);
//
//                         // Padding(
//                         // padding: const EdgeInsets.symmetric(vertical: 8.0),
//                         // child: InkWell(
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //     children: [
//                         //       CustomText(text: data.name.toString().toUpperCase(), textStyle: TextStyles.mediumText,color: Colors.black,fontSize: AppSize.font15,),
//                         //       Icon( Icons.arrow_forward_ios_outlined,size: AppSize.height12, color: Colors.black,).paddingOnly(right: AppSize.width20),
//                         //     ],
//                         //   ).paddingSymmetric(vertical: AppSize.height3),
//                         // ),
//                       // );
//
//                 },
//               ),
//             ),
//
//
//             Expanded(child: SizedBox()),
//             Divider(height: 1, color: Colors.grey,),
//             textIconRow(AppStrings.login,Icons.person_outline ),
//             Divider(height: 1, color: Colors.grey,),
//             textIconRow(AppStrings.cart,Icons.card_travel_outlined ),
//             Divider(height: 1, color: Colors.grey,),
//             textIconRow(AppStrings.wishList,Icons.favorite_border ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildRow(String text, IconData icon, ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: (){
//           switch (text) {
//             case "Namkeen & sweets":
//             // Do something when "Namkeen & sweets" row is tapped
//               break;
//             case "Chandini Chowk se":
//               // Do something when "Chandini Chowk se" row is tapped
//               break;
//             case "Kuremal Kulfi":
//             // Do something when "Kuremal Kulfi" row is tapped
//
//               break;
//             case "Jama Mazjid se":
//             // Do something when "Jama Mazjid se" row is tapped
//
//               break;
//             case "Chaat":
//             // Do something when "Chaat" row is tapped
//
//               break;
//             case "Purani Delhi Species":
//             // Do something when "Purani Delhi Species" row is tapped
//
//               break;
//             case "Gajak":
//             // Do something when "Gajak" row is tapped
//
//               break;
//             default:
//               break;
//           }
//           // Get.toNamed(AppPages.shopListScreen, arguments: {"category": controller.categoryList[0].name});
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CustomText(text: text.toUpperCase(), textStyle: TextStyles.mediumText,color: Colors.black,fontSize: AppSize.font15,),
//             Icon(icon,size: AppSize.height12, color: Colors.black,).paddingOnly(right: AppSize.width20),
//           ],
//         ).paddingSymmetric(vertical: AppSize.height3),
//       ),
//     );
//   }
//
//
Widget textIconRow(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          textStyle: TextStyles.mediumText,
          color: Colors.black,
          fontSize: AppSize.font13,
        ),
        Icon(
          icon,
          size: AppSize.height15,
          color: Colors.black,
        ).paddingOnly(right: AppSize.width20),
      ],
    ).paddingSymmetric(vertical: AppSize.height5),
  );
}

//
// }

class CategoryItem extends StatefulWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: widget.category.name!.toUpperCase(),
                  textStyle: TextStyles.mediumText,
                  color: Colors.black,
                  fontSize: AppSize.font15,
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: AppSize.height12,
                  color: Colors.black,
                ),
              ],
            ).paddingSymmetric(vertical: AppSize.height3),
          ),
        ),
        if (isExpanded)
          Column(
            children: widget.category.subCategories!.map((subCategory) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomText(
                  text: subCategory.name.toUpperCase(),
                  textStyle: TextStyles.mediumText,
                  color: Colors.black,
                  fontSize: AppSize.font15,
                ),
              );
            }).toList(),
          ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
