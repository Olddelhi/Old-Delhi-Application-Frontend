import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_controller.dart';
import 'package:old_delhi_food/app/ui/shop_item/shop_item_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';

import '../../components/text_styles.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_pages.dart';

// class ShopItemScreen extends GetView<ShopItemController> {
//   ShopItemScreen({super.key});
//
//   final ShopItemController controller = Get.put(ShopItemController());
//   final dashboardController= Get.put(DashboardController());
//
//   int selectedValue = 1;
//   final ScrollController _scrollController = ScrollController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [_appBar(context), _shopItemGridView()],
//         ).paddingSymmetric(horizontal: AppSize.width5),
//       ),
//     );
//   }
//
//   Widget _appBar(BuildContext context) {
//     return Column(
//       children: [
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Image.asset(
//                         AppAssets.backIcon,
//                         height: AppSize.height50,
//                         width: AppSize.width50,
//                       )),
//                   Visibility(
//                     visible: controller.showSearchBar.value == false,
//                     replacement: Container(
//                       height: AppSize.height35,
//                       width: AppSize.width200,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                             color: Colors
//                                 .black87), // You can adjust border properties here
//                       ),
//                       child: Center(
//                         child: Obx(
//                              ()=>TextFormField(
//                             controller: controller.searchTextController.value,
//                             style: TextStyle(color: Colors.black87),
//                             decoration: InputDecoration(
//                               hintText: 'Search',
//                               border: InputBorder.none,
//                               // Remove the border here
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 8), // Adjust padding as needed
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                             onChanged: (value){
//                               controller.searchItem(value);
//                             },
//                           ).paddingOnly(bottom: AppSize.height6),
//                         ),
//                       ),
//                     ).paddingSymmetric(vertical: AppSize.height8),
//                     child: Image.asset(
//                       AppAssets.logoIcon,
//                       height: AppSize.height50,
//                       width: AppSize.width50,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       controller.showSearchBar.value = true;
//                     },
//                     // child: Image.asset(
//                     //   AppAssets.searchIcon,
//                     //   height: AppSize.height50,
//                     //   width: AppSize.width50,
//                     // ),
//                     child: Icon(
//                       Icons.search,
//                       size: 30,
//                       // height: AppSize.height50,
//                       // width: AppSize.width50,
//                     ),
//                   ),
//                   Stack(
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           Get.toNamed(AppPages.cartScreen);
//                         },
//                         child: Image.asset(
//                           AppAssets.cartHomeIcon,
//                           height: AppSize.height50,
//                           width: AppSize.width50,
//                         ),
//                       ),
//                       dashboardController.cardItemList.length>0? Positioned(
//                         right: 5,
//                         top: 10,
//                         child: Container(
//                           height: AppSize.height18,
//                           width: AppSize.width18,
//                           decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.primary
//                           ),
//                           child: Center(child: CustomText(text: dashboardController.cardItemList.length.toString(),)),
//                         ),
//                       ):Container()
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Obx(
//         ()=> Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(width: AppSize.width50,),
//
//               Expanded(
//                 child: Center(
//                   child: Text(
//                      controller.category.value,
//                       style: TextStyle(
//                         fontFamily: FontFamily.bold,
//                         fontSize: AppSize.font18,
//                         color: Colors.black
//                       ),
//                   ).paddingSymmetric(
//                        vertical: AppSize.height5),
//                 ),
//               ),
//               // SizedBox(width: AppSize.width50,),
//               GestureDetector(
//                   onTap: () {
//                     _showSortDialog(context);
//                   },
//                   child: Image.asset(
//                     AppAssets.filterIcon,
//                     height: AppSize.height50,
//                     width: AppSize.width50,
//                   )),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _shopItemGridView() {
//     return Obx(
//       () => controller.isLoading.value?const Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(
//                 Colors.red),
//           ),
//         ),
//       ):Expanded(
//         child: GridView.builder(
//             padding: EdgeInsets.only(
//                 top: AppSize.height10, bottom: AppSize.height10,left: Get.size.width*0.04,right: Get.size.width*0.04),
//             // shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 18.0,
//               mainAxisSpacing: 18,
//             ),
//             itemCount: controller.searchTextController.value.text=="" ? controller.specificCategoryList.length:controller.searchedCategoryList.length,
//             itemBuilder: (BuildContext context, int index) {
//               var data =controller.searchTextController.value.text=="" ? controller.specificCategoryList[index]:controller.searchedCategoryList[index];
//               return GestureDetector(
//                 onTap: () {
//                   Get.toNamed(AppPages.foodDetailScreen,
//                       arguments: {"itemId": data.id});
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       // color: Colors.white,
//                       boxShadow: [
//                         // BoxShadow(
//                         //   color: Colors.grey.withOpacity(0.5),
//                         //   spreadRadius: 0,
//                         //   blurRadius: 4,
//                         //   offset: Offset(
//                         //       0, 5), // changes the position of the shadow
//                         // ),
//                       ],),
//                       // border: Border.all(color: Colors.grey),
//                       // borderRadius:
//                       //     BorderRadius.all(Radius.circular(AppSize.radius10))),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(border: Border.all(color: Color(0xFFA88C93),width: 1),borderRadius: BorderRadius.all(Radius.circular(12))),
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.all(Radius.circular(12) ),
//                             child: Image.network(
//                               (data.productItems?[0].images![0].url)! ?? "",
//                               width: 200,
//                               height: AppSize.height90,
//                               fit: BoxFit.fill,
//                               // fit: BoxFit.contain,
//                             )),
//                       ),
//                       CustomText(
//                         text: data.name.toString(),
//                         maxLine: 1,
//                         textStyle: TextStyles.semiBoldTextStyle,
//                         color: Colors.black,
//                         fontSize: AppSize.font12,
//                       ).paddingOnly(
//                           top: AppSize.height10,
//                           right: AppSize.width5,
//                           left: AppSize.width5),
//                       CustomText(
//                         text: data.price.toString() + " Rs. - "+ data.productItems![0].price.toString()+" Rs. ",
//                         textStyle: TextStyles.regularText,
//                         color: Colors.black,
//                         fontSize: AppSize.font12,
//                       ).paddingOnly(
//                           top: AppSize.height5,
//                           right: AppSize.width5,
//                           left: AppSize.width5)
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
//
//   void _showSortDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Sort By', style: TextStyle(
//               fontFamily: FontFamily.bold,
//               fontSize: AppSize.height10,
//               color: Colors.black
//           ),),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListTile(
//                 title: Text('Name (A-Z)', style: TextStyle(
//                     fontFamily: FontFamily.regular,
//                     fontSize: AppSize.height10,
//                     color: Colors.black
//                 ),),
//                 onTap: () {
//                   controller.sortByNameAscending();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text('Name (Z-A)', style: TextStyle(
//                     fontFamily: FontFamily.regular,
//                     fontSize: AppSize.height10,
//                     color: Colors.black
//                 ),),
//                 onTap: () {
//                   controller.sortByNameDescending();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text('Price (Low to High)', style: TextStyle(
//                     fontFamily: FontFamily.regular,
//                     fontSize: AppSize.height10,
//                     color: Colors.black
//                 ),),
//                 onTap: () {
//                   controller.sortByPriceAscending();
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text('Price (High to Low)', style: TextStyle(
//                     fontFamily: FontFamily.regular,
//                     fontSize: AppSize.height10,
//                     color: Colors.black
//                 ),),
//                 onTap: () {
//                   controller.sortByPriceDescending();
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   showPopup(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.cyan,
//           height: 200,
//           width: 200,
//           child: ListView.builder(
//             itemCount: 5, // Replace with the actual number of rows you want
//             itemBuilder: (context, index) {
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomText(
//                     text: "Default shorting",
//                     textStyle: TextStyles.mediumText,
//                     fontSize: AppSize.font15,
//                     color: Colors.black,
//                   ),
//                   Radio<int>(
//                       value: index,
//                       groupValue: selectedValue,
//                       onChanged: (int? value) {
//                         selectedValue = value!;
//                       })
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class ShopItemScreen extends GetView<ShopItemController> {
  ShopItemScreen({super.key});

  @override
  final ShopItemController controller = Get.put(ShopItemController());
  final DashboardController dashboardController =
      Get.put(DashboardController());
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_appBar(context), _shopItemGridView()],
        ).paddingSymmetric(horizontal: AppSize.width5),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      AppAssets.backIcon,
                      height: AppSize.height50,
                      width: AppSize.width50,
                    ),
                  ),
                  Visibility(
                    visible: controller.showSearchBar.value == false,
                    replacement: Container(
                      height: AppSize.height35,
                      width: AppSize.width200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black87),
                      ),
                      child: Center(
                        child: Obx(
                          () => TextFormField(
                            controller: controller.searchTextController.value,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              controller.searchItem(value);
                            },
                          ).paddingOnly(bottom: AppSize.height6),
                        ),
                      ),
                    ).paddingSymmetric(vertical: AppSize.height8),
                    child: Image.asset(
                      AppAssets.logoIcon,
                      height: AppSize.height50,
                      width: AppSize.width50,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.showSearchBar.value = true;
                    },
                    child: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.cartScreen);
                        },
                        child: Image.asset(
                          AppAssets.cartHomeIcon,
                          height: AppSize.height50,
                          width: AppSize.width50,
                        ),
                      ),
                      dashboardController.cardItemList.isNotEmpty
                          ? Positioned(
                              right: 5,
                              top: 10,
                              child: Container(
                                height: AppSize.height18,
                                width: AppSize.width18,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary),
                                child: Center(
                                  child: CustomText(
                                    text: dashboardController
                                        .cardItemList.length
                                        .toString(),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(width: AppSize.width50),
              Expanded(
                child: Center(
                  child: Text(
                    controller.category.value,
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: AppSize.font18,
                      color: Colors.black,
                    ),
                  ).paddingSymmetric(vertical: AppSize.height5),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     _showSortDialog(context);
              //   },
              //   child: Image.asset(
              //     AppAssets.filterIcon,
              //     height: AppSize.height50,
              //     width: AppSize.width50,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shopItemGridView() {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            )
          : Expanded(
              child: GridView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.only(
                  top: AppSize.height10,
                  bottom: AppSize.height10,
                  left: Get.size.width * 0.04,
                  right: Get.size.width * 0.04,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.0,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.75,
                ),
                itemCount: controller.searchTextController.value.text == ""
                    ? controller.specificCategoryList.length
                    : controller.searchedCategoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = controller.searchTextController.value.text == ""
                      ? controller.specificCategoryList[index]
                      : controller.searchedCategoryList[index];
                  // Calculate the minimum price
                  double? price1 = data.price?.toDouble();
                  double? price2 = data.productItems![0].price?.toDouble();
                  double minPrice = min(price1!, price2!);
                  double maxPrice = max(price1, price2);
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppPages.foodDetailScreen,
                          arguments: {"itemId": data.id});
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          // Existing decoration code
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFA88C93), width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Image.network(
                                (data.productItems?[0].images![0].url)! ?? "",
                                width: 200,
                                height: AppSize.height90,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          CustomText(
                            text: data.name.toString(),
                            maxLine: 1,
                            textStyle: TextStyles.semiBoldTextStyle,
                            color: Colors.black,
                            fontSize: AppSize.font12,
                          ).paddingOnly(
                            top: AppSize.height10,
                            right: AppSize.width5,
                            left: AppSize.width5,
                          ),
                          CustomText(
                            text: "\u{20B9}$minPrice - \u{20B9}$maxPrice",
                            // text: data.price.toString() +
                            //     " Rs. - " +
                            //     data.productItems![0].price.toString() +
                            //     " Rs. ",
                            textStyle: TextStyles.regularText,
                            color: Colors.black,
                            fontSize: AppSize.font12,
                          ).paddingOnly(
                            top: AppSize.height5,
                            right: AppSize.width5,
                            left: AppSize.width5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showSortDialog(BuildContext context) {
    // Existing _showSortDialog code
  }

  showPopup(BuildContext context) {
    // Existing showPopup code
  }
}
