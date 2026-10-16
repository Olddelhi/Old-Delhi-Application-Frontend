import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/popular_shop/popular_shop_controller.dart';

import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_pages.dart';
import '../../utils/app_size.dart';

class PopularShopScreen extends GetView<PopularShopController> {
  PopularShopScreen({super.key});

  @override
  final controller = Get.put(PopularShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(),
              Obx(
                () => ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.shopList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = controller.shopList[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.shopItemScreen,
                              arguments: {"category": data.name});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0,
                                      5), // changes the position of the shadow
                                ),
                              ],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppSize.radius10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(AppSize.radius10),
                                      topRight:
                                          Radius.circular(AppSize.radius10)),
                                  child: Image.network(
                                    data.images![0].url!,
                                    width: Get.width,
                                    fit: BoxFit.fill,
                                  )),
                              CustomText(
                                text: data.name.toString(),
                                textStyle: TextStyles.mediumText,
                                fontSize: AppSize.font18,
                                color: Colors.black,
                              ).paddingSymmetric(vertical: 5, horizontal: 5),

                              // CustomText(text:"Chicken - Rich - Wings", textStyle: TextStyles.mediumText, fontSize: AppSize.font12,
                              //   color: Colors.black38,
                              // ).paddingOnly(left: 10),

                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Icon(Icons.star_border_outlined, color: AppColors.orangeColor,).paddingAll(5),
                                  //     CustomText(text:"4.7", textStyle: TextStyles.boldText, fontSize: AppSize.font15,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ],
                                  // ),

                                  // Row(
                                  //   children: [
                                  //     Icon(Icons.delivery_dining, color: AppColors.orangeColor,).paddingAll(5),
                                  //     CustomText(text:"100", textStyle: TextStyles.boldText, fontSize: AppSize.font15,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              )
                            ],
                          ).paddingSymmetric(),
                        ).paddingSymmetric(vertical: 10, horizontal: 2),
                      );
                    }),
              ),
            ],
          ).paddingAll(10),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.backIcon,
                  height: AppSize.height50,
                  width: AppSize.width50,
                )),
            // Image.asset(
            //   AppAssets.logoIcon,
            //   height: AppSize.height50,
            //   width: AppSize.width50,
            // ),

            CustomText(
              text: "Popular Shops",
              color: Colors.black,
              fontSize: AppSize.font15,
              textStyle: TextStyles.boldText,
            )
          ],
        ),
        // Row(
        //   children: [
        //     Image.asset(
        //       AppAssets.searchIcon,
        //       height: AppSize.height50,
        //       width: AppSize.width50,
        //     ),
        //     Stack(
        //       children: [
        //         Image.asset(
        //           AppAssets.appBarCartIcon,
        //           height: AppSize.height50,
        //           width: AppSize.width50,
        //         ),
        //
        //         Positioned(
        //           right: 5,
        //           top: 10,
        //           child: Container(
        //             height: AppSize.height18,
        //             width: AppSize.width18,
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: AppColors.primary
        //             ),
        //             child: Center(child: CustomText(text: dashboardController.cardItemList.length.toString(),)),
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
