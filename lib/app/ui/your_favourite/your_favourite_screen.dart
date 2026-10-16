import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/your_favourite/your_favourite_controller.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_pages.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class YourFavouriteScreen extends GetView<YourFavouriteController> {
  YourFavouriteScreen({super.key});

  @override
  YourFavouriteController controller = Get.put(YourFavouriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                )); // Show loading indicator
              } else {
                return _orderList(); // Show the list once data is loaded
              }
            })
          ],
        ).paddingSymmetric(horizontal: AppSize.width10),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).maybePop();
            },
            child: Image.asset(
              AppAssets.backIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: CustomText(
            text: AppStrings.yourFavourite,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    ).paddingSymmetric(vertical: 5);
  }

  Widget _orderList() {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: controller.favoriteItems.length,
          itemBuilder: (context, index) {
            final item = controller.favoriteItems[index];
            return InkWell(
              onTap: () {
                Get.toNamed(AppPages.foodDetailScreen, arguments: {
                  "itemId": item['productItem']['product']['id']
                });
                // Get.toNamed(AppPages.shopItemScreen, arguments: {"category": item['productItem']['product']['slug'],});
              },
              child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.containerColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 5), // changes the position of the shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.radius20))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            item['productItem']['images'][0]['url'],
                            height: AppSize.height35,
                            width: AppSize.width40,
                            fit: BoxFit.fill,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.size.width * 0.6,
                                child: CustomText(
                                  text: item['productItem']['product']['name'],
                                  maxLine: 2,
                                  textStyle: TextStyles.boldText,
                                  fontSize: AppSize.font18,
                                ),
                              ),
                              CustomText(
                                text:
                                    "\u{20B9}${item['productItem']['product']['price']}-\u{20B9}${item['productItem']['price']}",
                                textStyle: TextStyles.boldText,
                                fontSize: AppSize.font12,
                              ),
                            ],
                          ).paddingSymmetric(horizontal: AppSize.width10)
                        ],
                      ).paddingSymmetric(
                          horizontal: AppSize.width15,
                          vertical: AppSize.height15))
                  .paddingSymmetric(vertical: AppSize.height10),
            );
          }),
    );
  }
}
