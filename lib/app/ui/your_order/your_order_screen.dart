// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:old_delhi_food/app/ui/your_order/your_order_controller.dart';
// import '../../components/cutom_text.dart';
// import '../../components/text_styles.dart';
// import '../../utils/app_assets.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/app_pages.dart';
// import '../../utils/app_size.dart';
// import '../../utils/app_strings.dart';
// import '../your_order_detail/your_order_detail_screen.dart';
//
// class YourOrderScreen extends GetView<YourOrderController>{
//    YourOrderScreen({super.key});
//
//   YourOrderController controller= Get.put(YourOrderController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      body: SafeArea(
//        child: Column(
//          children: [
//            _appBar(),
//            Obx(() {
//              if (controller.isLoading.value) {
//                return Center(child: CircularProgressIndicator()); // Show loading indicator
//              } else {
//                return _orderList(); // Show the list once data is loaded
//              }})
//
//          ],
//        ).paddingSymmetric(horizontal: AppSize.width10),
//      ),
//    );
//   }
//
//    Widget _appBar(){
//      return Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: [
//          GestureDetector(
//              onTap: (){
//                Get.back();
//              },
//              child: Image.asset(AppAssets.backIcon,
//                height: AppSize.height35,
//                width: AppSize.width40,
//                fit: BoxFit.fill,)),
//
//          Expanded(
//            child: CustomText(text: AppStrings.yourOrder, textStyle: TextStyles.regularText,
//              fontSize: AppSize.font18,
//            ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height5),
//          ),
//
//
//        ],
//      ).paddingSymmetric(vertical: 5);
//    }
//
//    Widget _orderList()
//    {
//       return Expanded(
//          child: ListView.builder(
//            padding: EdgeInsets.all(0),
//              shrinkWrap: true,
//              itemCount: controller.orderResponse?.value.data.length,
//              itemBuilder: (context, index){
//                final order = controller.orderResponse!.value.data[index];
//                List<String> names = controller.getProductNames(order.orderItems);
//
//                return InkWell(
//                  onTap: (){
//                    Get.to(() => OrderDetailsScreen(order: order));
//                  },
//                  child: Container(
//                      decoration: BoxDecoration(
//                          color: AppColors.containerColor,
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.withOpacity(0.5),
//                              spreadRadius: 1,
//                              blurRadius: 4,
//                              offset: Offset(0, 5), // changes the position of the shadow
//                            ),
//                          ],
//                          borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
//                      ),
//
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          order.orderItems[0].productItem.images[0].url.isEmpty?
//                            Image.asset(AppAssets.kajudalbiji, height: AppSize.height80, width: AppSize.width100,
//                            fit: BoxFit.fill,): Image.network((order.orderItems[0].productItem.images[0].url), height: AppSize.height60, width: AppSize.width80,
//                            fit: BoxFit.fill,),
//
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//
//                              SizedBox(width: Get.width*0.55,
//                                child: CustomText(text:order.orderItems[0].productItem.product.name,maxLine: 2, textStyle: TextStyles.boldOrderText,
//                                // child: CustomText(text:names.join(', '),maxLine: 2, textStyle: TextStyles.boldOrderText,
//                                fontSize: AppSize.font16,
//                                ),
//                              ),
//
//                              CustomText(text: "\u{20B9}${order.grandTotal}", textStyle: TextStyles.boldText,
//                              fontSize: AppSize.font12,
//                              ),
//
//                              Container(
//                                decoration: BoxDecoration(
//                                  color: AppColors.secondary,
//                                   borderRadius: BorderRadius.all(Radius.circular(AppSize.radius10))
//
//                                ),
//
//                                child: CustomText(text: order.status=='PENDING'?'Order Received':'Track Your Order',
//                                textStyle: TextStyles.mediumText, color: Colors.black,fontSize: AppSize.font14,
//                                ).paddingSymmetric(horizontal: AppSize.width10, vertical: AppSize.height5),
//                              ),
//
//                             // index.isEven ?   RatingBar.builder(
//                             //    initialRating: 4,
//                             //    minRating: 1,
//                             //    direction: Axis.horizontal,
//                             //    allowHalfRating: true,
//                             //    itemCount: 5,
//                             //    itemSize: AppSize.height20,
//                             //    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                             //    itemBuilder: (context, _) => Icon(
//                             //      Icons.star,
//                             //      color: AppColors.primary,
//                             //    ),
//                             //    onRatingUpdate: (rating) {
//                             //      print(rating);
//                             //    },
//                             //
//                             //  ) : SizedBox(),
//                            ],
//                          ).paddingSymmetric(horizontal: AppSize.width10)
//
//                        ],
//                      ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height15)
//
//                  ).paddingSymmetric(vertical: AppSize.height10),
//                );
//              }),
//        );
//    }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/your_order/your_order_controller.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';
import '../your_order_detail/your_order_detail_screen.dart';

class YourOrderScreen extends GetView<YourOrderController> {
  YourOrderScreen({super.key});

  @override
  YourOrderController controller = Get.put(YourOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            Obx(() {
              if (controller.isLoading.value &&
                  controller.currentPage.value == 1) {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ));
              } else {
                return Expanded(child: _orderList());
              }
            }),
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
          ),
        ),
        Expanded(
          child: CustomText(
            text: AppStrings.yourOrder,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
        _sortMenu(),
      ],
    ).paddingSymmetric(vertical: 5);
  }

  Widget _orderList() {
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: controller.orderResponse?.value.data?.length,
      itemBuilder: (context, index) {
        final order = controller.orderResponse?.value.data?[index];
        // List<String> names = controller.getProductNames(order!.orderItems);
        return InkWell(
          onTap: () {
            Get.to(() => OrderDetailsScreen(order: order));
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //       order?.orderItems.isNotEmpty == true
                //           ? Wrap(
                //         spacing: 8.0,
                //         runSpacing: 8.0,
                //         children: order!.orderItems.map((item) {
                //           final imageUrl = item.productItem.images.isNotEmpty
                //               ? item.productItem.images[0].url
                //               : null;
                //           return ClipRRect(
                //             borderRadius: BorderRadius.circular(8),
                //             child: imageUrl != null && imageUrl.isNotEmpty
                //                 ? Image.network(
                //               imageUrl,
                //               height: AppSize.height60,
                //               width: AppSize.width60,
                //               fit: BoxFit.cover,
                //             )
                //                 : Image.asset(
                //               AppAssets.kajudalbiji,
                //               height: AppSize.height60,
                //               width: AppSize.width60,
                //               fit: BoxFit.cover,
                //             ),
                //           );
                //         }).toList(),
                //       )
                //           :Image.asset(
                //   AppAssets.kajudalbiji,
                //   height: AppSize.height80,
                //   width: AppSize.width100,
                //   fit: BoxFit.fill,
                // ),
                order!.orderItems[0].productItem.images[0].url.isEmpty
                    ? Image.asset(
                        AppAssets.kajudalbiji,
                        height: AppSize.height80,
                        width: AppSize.width100,
                        fit: BoxFit.fill,
                      )
                    : ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          (order.orderItems[0].productItem.images[0].url),
                          height: AppSize.height60,
                          width: AppSize.width80,
                          fit: BoxFit.fill,
                        ),
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.5,
                      child: CustomText(
                        text: "#${_getLastPartOfName(order.id.toString())}",
                        maxLine: 2,
                        textStyle: TextStyles.boldOrderText,
                        fontSize: AppSize.font16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: CustomText(
                        text: order.orderItems.length > 1
                            ? "${order.orderItems[0].productItem.product.name}, ..."
                            : order.orderItems[0].productItem.product.name,
                        maxLine: 2,
                        textStyle: TextStyles.boldOrderText,
                        fontSize: AppSize.font12,
                      ),
                    ),
                    // CustomText(
                    //   text: "\u{20B9}${order.grandTotal}",
                    //   textStyle: TextStyles.boldText,
                    //   fontSize: AppSize.font12,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.radius10)),
                      ),
                      child: CustomText(
                        text: order.status == 'PENDING'
                            ? 'Order Received'
                            : order.status == 'DELIVERED'
                                ? 'Completed'
                                : 'Track Your Order',
                        textStyle: TextStyles.mediumText,
                        color: Colors.black,
                        fontSize: AppSize.font14,
                      ).paddingSymmetric(
                          horizontal: AppSize.width10,
                          vertical: AppSize.height5),
                    ),
                  ],
                ).paddingOnly(left: AppSize.width10),
                CustomText(
                  text: "\u{20B9}${order.grandTotal}",
                  textStyle: TextStyles.boldText,
                  fontSize: AppSize.font12,
                ).paddingSymmetric(vertical: 10),
              ],
            ).paddingSymmetric(
                horizontal: AppSize.width15, vertical: AppSize.height15),
          ).paddingSymmetric(vertical: AppSize.height10),
        );
      },
    );
  }

  String _getLastPartOfName(String name) {
    final parts = name.split('-');
    return parts.isNotEmpty ? parts.last.trim() : name;
  }

  Widget _sortMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.sort, color: Colors.black),
          onSelected: (value) {
            if (value == 'Latest') {
              controller.toggleSort(true);
            } else {
              controller.toggleSort(false);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'Latest',
              child: Row(
                children: [
                  Icon(
                    controller.sortByLatest.value
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Colors.red,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Text('Sort by Latest',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'Oldest',
              child: Row(
                children: [
                  Icon(
                    !controller.sortByLatest.value
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Colors.red,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  const Text('Sort by Oldest',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(vertical: AppSize.height10, horizontal: AppSize.width10);
  }
}
