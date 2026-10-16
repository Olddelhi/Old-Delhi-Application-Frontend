import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/shop_list/shop_list_controller.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';

import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_pages.dart';
import '../../utils/app_size.dart';

class ShopListScreen extends GetView<ShopListController> {
  ShopListScreen({super.key});

  @override
  ShopListController controller = Get.put(ShopListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBar(),
            CustomText(
              text: AppStrings.popularShops,
              textStyle: TextStyles.mediumText,
              fontSize: AppSize.font15,
            ),
            _shopListGridView(),
          ],
        ).paddingSymmetric(horizontal: AppSize.width15),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20)),
              border: Border.all(color: Colors.black45)),
          child: Row(
            children: [
              CustomText(
                text: "Kuremal Kulfi",
                textStyle: TextStyles.boldText,
                fontSize: AppSize.font15,
              ).paddingSymmetric(
                  horizontal: AppSize.width15, vertical: AppSize.height5),
              Image.asset(
                AppAssets.polygonIcon,
                height: AppSize.height30,
                width: AppSize.width30,
              )
            ],
          ),
        ),
        GestureDetector(
            onTap: () {},
            child: Image.asset(
              AppAssets.searchBlackBackground,
              height: AppSize.height50,
              width: AppSize.width50,
            )),
        GestureDetector(
            onTap: () {},
            child: Image.asset(
              AppAssets.filterIcon,
              height: AppSize.height50,
              width: AppSize.width50,
            )),
      ],
    );
  }

  Widget _shopListGridView() {
    return SizedBox(
      height: Get.height * 0.9,
      child: GridView.builder(
          padding: EdgeInsets.only(top: AppSize.height10),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18.0,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppPages.foodDetailScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(
                            0, 5), // changes the position of the shadow
                      ),
                    ],
                    border: Border.all(color: Colors.grey),
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.radius10))),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.radius10),
                            topRight: Radius.circular(AppSize.radius10)),
                        child: Image.asset(
                          index.isEven
                              ? AppAssets.alJawahar
                              : AppAssets.lotanCholeImage,
                          height: AppSize.height90,
                          fit: BoxFit.fill,
                        )),
                    CustomText(
                      text: "AL- Jawahar Butter Chicken 600rs - 1150rs",
                      textStyle: TextStyles.regularText,
                      color: Colors.black,
                      fontSize: AppSize.font12,
                    ).paddingOnly(
                        top: AppSize.height10,
                        right: AppSize.width5,
                        left: AppSize.width5)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
