import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_controller.dart';
import 'package:old_delhi_food/app/ui/food_detail/food_detail_controller.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_pages.dart';
import '../../utils/app_size.dart';
import '../shop_item/shop_item_controller.dart';
import 'dart:math';

class FoodDetailScreen extends GetView<FoodDetailController> {
  FoodDetailScreen({super.key});

  @override
  final FoodDetailController controller = Get.put(FoodDetailController());
  final dashboardController = Get.find<DashboardController>();
  final bool isShopItemControllerRegistered =
      Get.isRegistered<ShopItemController>();
  var shopItemController;

  @override
  // Widget build(BuildContext context) {
  //   print("isshopitemcontroller $isShopItemControllerRegistered");
  //   if (isShopItemControllerRegistered) {
  //     shopItemController = Get.find<ShopItemController>();
  //   }
  //
  //   return Scaffold(
  //     body: SafeArea(
  //       child: Obx(
  //         () => controller.showLoader.value == true
  //             ? const Center(
  //                 child: CircularProgressIndicator(
  //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
  //               ))
  //             : SingleChildScrollView(
  //                 child: SizedBox(width: Get.size.width,
  //                   height: controller.showAllItems.value
  //                       ? Get.size.height * 1.75
  //                       : Get.size.height * 1.5,
  //                   child: Column(
  //                     children: [
  //                       _appBar(),
  //                       // controller.showLoader.value==true? const CircularProgressIndicator():  _foodDetails(),
  //                       _foodDetails(),
  //                       Divider(
  //                         color: Colors.red,
  //                       ),
  //                       SizedBox(
  //                         height: AppSize.height10,
  //                       ),
  //                       Container(
  //                         width: Get.width,
  //                         height: Get.height * 0.24,
  //                         decoration: const BoxDecoration(
  //                           borderRadius: BorderRadius.only(
  //                               topLeft: Radius.circular(20),
  //                               topRight: Radius.circular(20)),
  //                           // color: AppColors.lightGreyColors
  //                         ),
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     CustomText(
  //                                       text:
  //                                           "\u{20B9} ${controller.productItems.value.price}.00",
  //                                       textStyle: TextStyles.boldText,
  //                                       fontSize: AppSize.height15,
  //                                       color: Colors.red,
  //                                     ),
  //                                     SizedBox(
  //                                       width: AppSize.width10,
  //                                     ),
  //                                     Container(
  //                                       height: AppSize.height20,
  //                                       width: AppSize.width100,
  //                                       decoration: BoxDecoration(
  //                                           borderRadius: BorderRadius.all(
  //                                               Radius.circular(24)),
  //                                           border: Border.all(
  //                                               color: Colors.green)),
  //                                       child: Center(
  //                                         child: CustomText(
  //                                           text:
  //                                               "${controller.productItems.value.stock ?? " "} In Stock",
  //                                           textStyle: TextStyles.regularText,
  //                                           fontSize: AppSize.font12,
  //                                           color: Colors.green,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 Container(
  //                                   height: AppSize.height20,
  //                                   width: AppSize.width130,
  //                                   // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24)),border: Border.all(color: Colors.green)),
  //                                   child: Center(
  //                                     child: CustomText(
  //                                       text:
  //                                           "Min. Quantity: ${controller.productDetail.value.minOrderQuantity ?? " "}",
  //                                       textStyle: TextStyles.regularText,
  //                                       fontSize: AppSize.font12,
  //                                       color: Colors.black,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: AppSize.height10,
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: Container(
  //                                   width: Get.size.width * 0.85,
  //                                   height: AppSize.height30,
  //                                   decoration: const BoxDecoration(
  //                                       boxShadow: <BoxShadow>[
  //                                         BoxShadow(
  //                                             color: Colors.black54,
  //                                             blurRadius: 3.0,
  //                                             offset: Offset(0.0, 5))
  //                                       ],
  //                                       borderRadius: BorderRadius.all(
  //                                         Radius.circular(20),
  //                                       ),
  //                                       color: Colors.white),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: [
  //                                       InkWell(
  //                                         onTap: () {
  //                                           if (controller.quantity.value >
  //                                               int.parse(controller
  //                                                   .productDetail
  //                                                   .value
  //                                                   .minOrderQuantity!)) {
  //                                             controller.decreaseQuantity();
  //                                           }
  //                                         },
  //                                         child: Icon(Icons.remove).paddingSymmetric(horizontal: 10),
  //                                         // child: CustomText(
  //                                         //   text: "-",
  //                                         //   fontSize: AppSize.height20,
  //                                         //   color: Colors.black,
  //                                         // ).paddingSymmetric(horizontal: 10),
  //                                       ),
  //                                       Obx(() => CustomText(
  //                                             text: controller.quantity
  //                                                 .toString(),
  //                                             fontSize: AppSize.height15,
  //                                             color: Colors.black,
  //                                           ).paddingSymmetric(horizontal: 10)),
  //                                       InkWell(
  //                                         onTap: () {
  //                                           controller.increaseQuantity();
  //                                         },
  //                                   child: Icon(Icons.add).paddingSymmetric(horizontal: 10),
  //                                       ),
  //                                     ],
  //                                   )),
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Obx(() {
  //                                   DateTime now = DateTime.now();
  //
  //                                   // Parse the start time and end time strings
  //                                   String startTimeStr = controller
  //                                       .productDetail
  //                                       .value
  //                                       .timeSlot!
  //                                       .startTime!;
  //                                   String endTimeStr = controller
  //                                       .productDetail.value.timeSlot!.endTime!;
  //
  //                                   // Construct DateTime objects with today's date and the parsed time
  //                                   DateTime startTime = DateTime(
  //                                     now.year,
  //                                     now.month,
  //                                     now.day,
  //                                     int.parse(startTimeStr.split(':')[0]),
  //                                     // Extract hour from time string
  //                                     int.parse(startTimeStr.split(':')[1]),
  //                                     // Extract minute from time string
  //                                     int.parse(startTimeStr.split(':')[
  //                                         2]), // Extract second from time string
  //                                   );
  //
  //                                   DateTime endTime = DateTime(
  //                                     now.year,
  //                                     now.month,
  //                                     now.day,
  //                                     int.parse(endTimeStr.split(':')[0]),
  //                                     // Extract hour from time string
  //                                     int.parse(endTimeStr.split(':')[1]),
  //                                     // Extract minute from time string
  //                                     int.parse(endTimeStr.split(':')[
  //                                         2]), // Extract second from time string
  //                                   );
  //
  //                                   // Check if current time is within the specified time range
  //                                   bool isWithinTimeRange =
  //                                       now.isAfter(startTime) &&
  //                                           now.isBefore(endTime);
  //
  //                                   return controller.showButtonLoader.value
  //                                       ? const CircularProgressIndicator(
  //                                           valueColor: AlwaysStoppedAnimation<
  //                                                   Color>(
  //                                               Colors
  //                                                   .red), // Change color here
  //                                         )
  //                                       : SizedBox(
  //                                           width: Get.size.width * 0.85,
  //                                           height: Get.size.height * 0.05,
  //                                           child: AppButton(
  //                                               onTap:
  //                                                   // !isWithinTimeRange?(){
  //                                                   //   Get.snackbar("Alert", "Item not available at this time",colorText: Colors.white,
  //                                                   //     backgroundColor: Colors.red,);
  //                                                   // }:
  //                                                   () {
  //                                                 controller.addToCart();
  //                                               },
  //                                               text: "ADD TO CART",
  //                                               textColor:
  //                                                   // isWithinTimeRange?
  //                                                   Colors.white,
  //                                               // :
  //                                               // Colors.grey,
  //                                               color: AppColors.redColor
  //                                               // isWithinTimeRange? AppColors.redColor:AppColors.lightGreyColors,
  //                                               ),
  //                                         );
  //                                 }),
  //                               ],
  //                             ).paddingOnly(top: 5),
  //                             SizedBox(
  //                               height: AppSize.height10,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 SizedBox(
  //                                   width: Get.size.width * 0.85,
  //                                   height: Get.size.height * 0.05,
  //                                   child: AppButton(
  //                                     onTap: () {
  //                                       controller.isFavorite.value
  //                                           ? controller.removeFromFavorites()
  //                                           : controller.addToFavorites();
  //                                       // controller.addToCart();
  //                                     },
  //                                     text: "Add To WishList",
  //                                     color: AppColors.lightGreyColors,
  //                                     textColor: Colors.black,
  //                                   ),
  //                                 ),
  //
  //                                 // AppButton(onTap: (){
  //                                 //   controller.addToCart().then((value) =>   Get.toNamed(AppPages.cartScreen));
  //                                 // }, text: "ORDER NOW",color: AppColors.cartHeadingColor, )
  //                               ],
  //                             ).paddingOnly(top: 5),
  //                           ],
  //                         ).paddingSymmetric(
  //                           horizontal: AppSize.width10,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       isShopItemControllerRegistered
  //                           ? Align(
  //                               alignment: Alignment.topLeft,
  //                               child: CustomText(
  //                                 text: "Related Products",
  //                                 textStyle: TextStyles.boldText,
  //                                 fontSize: AppSize.height15,
  //                                 color: Colors.black,
  //                               )).paddingOnly(left: 10)
  //                           : Container(),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       isShopItemControllerRegistered
  //                           ? Expanded(
  //                               child: Container(
  //                                 // height: Get.size.height*0.64,
  //                                 child: GridView.builder(
  //                                     padding: EdgeInsets.all(AppSize.height15),
  //                                     shrinkWrap: true,
  //                                     // physics: const NeverScrollableScrollPhysics(),
  //                                     gridDelegate:
  //                                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                                       crossAxisCount: 2,
  //                                       crossAxisSpacing: 18.0,
  //                                       mainAxisSpacing: 18,
  //                                     ),
  //                                     itemCount: controller.showAllItems.value
  //                                         ? shopItemController
  //                                             .specificCategoryList.length
  //                                         : shopItemController
  //                                                     .specificCategoryList
  //                                                     .length >
  //                                                 4
  //                                             ? 4
  //                                             : shopItemController
  //                                                 .specificCategoryList.length,
  //                                     itemBuilder:
  //                                         (BuildContext context, int index) {
  //                                       var data = shopItemController
  //                                           .specificCategoryList[index];
  //                                       return InkWell(
  //                                         onTap: () async {
  //                                           print("here${data.id}");
  //                                           await loadDataForId(data.id);
  //                                           Get.back();
  //                                           Get.toNamed(
  //                                               AppPages.foodDetailScreen,
  //                                               arguments: {"itemId": data.id});
  //                                           controller.getArguments();
  //                                         },
  //                                         child: Container(
  //                                           child: Column(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               ClipRRect(
  //                                                   // borderRadius: BorderRadius.only(
  //                                                   //     topLeft: Radius.circular(AppSize.radius10),
  //                                                   //     topRight: Radius.circular(AppSize.radius10)),
  //                                                   child: Container(
  //                                                 decoration: BoxDecoration(
  //                                                     borderRadius:
  //                                                         BorderRadius.all(
  //                                                             Radius.circular(
  //                                                                 12)),
  //                                                     border: Border.all(
  //                                                         color:
  //                                                             Color(0xFFA88C93),
  //                                                         width: 1)),
  //                                                 child: ClipRRect(
  //                                                   borderRadius:
  //                                                       const BorderRadius.all(
  //                                                           Radius.circular(
  //                                                               12)),
  //                                                   child: Image.network(
  //                                                     (data
  //                                                             .productItems?[0]
  //                                                             .images![0]
  //                                                             .url)! ??
  //                                                         "",
  //                                                     width: Get.width,
  //                                                     height: AppSize.height90,
  //                                                     fit: BoxFit.fill,
  //                                                     // fit: BoxFit.contain,
  //                                                   ),
  //                                                 ),
  //                                               )),
  //                                               CustomText(
  //                                                 text: data.name.toString(),
  //                                                 maxLine: 1,
  //                                                 textStyle:
  //                                                     TextStyles.boldText,
  //                                                 color: Colors.black,
  //                                                 fontSize: AppSize.font12,
  //                                               ).paddingOnly(
  //                                                   top: AppSize.height10,
  //                                                   right: AppSize.width5,
  //                                                   left: AppSize.width5),
  //                                               CustomText(
  //                                                 text: data.price.toString() +
  //                                                     " Rs.",
  //                                                 textStyle:
  //                                                     TextStyles.boldText,
  //                                                 color: Colors.black,
  //                                                 fontSize: AppSize.font12,
  //                                               ).paddingOnly(
  //                                                   top: AppSize.height5,
  //                                                   right: AppSize.width5,
  //                                                   left: AppSize.width5)
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       );
  //                                     }),
  //                               ),
  //                             )
  //                           : Container(),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       isShopItemControllerRegistered
  //                           ? Visibility(
  //                               visible: shopItemController
  //                                       .specificCategoryList.length >
  //                                   4,
  //                               child: Center(
  //                                 child: InkWell(
  //                                   onTap: () {
  //                                     controller.toggleShowAllItems();
  //                                   },
  //                                   child: Container(
  //                                       width: AppSize.width100,
  //                                       height: AppSize.height30,
  //                                       decoration: BoxDecoration(
  //                                           color: Colors.red,
  //                                           borderRadius: BorderRadius.all(
  //                                               Radius.circular(24))),
  //                                       child: Obx(() => Center(
  //                                             child: CustomText(
  //                                               text: controller
  //                                                       .showAllItems.value
  //                                                   ? "View Less"
  //                                                   : "View All",
  //                                               textStyle:
  //                                                   TextStyles.mediumHomeText,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ))),
  //                                 ),
  //                               ),
  //                             )
  //                           : Container(),
  //                       SizedBox(
  //                         height: 5,
  //                       ),
  //                       // Image.asset(AppAssets.homeFooter,width: Get.width,),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    print("isshopitemcontroller $isShopItemControllerRegistered");
    if (isShopItemControllerRegistered) {
      shopItemController = Get.find<ShopItemController>();
    }

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.showLoader.value
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ))
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          _appBar(context),
                          _foodDetails(),
                          const Divider(color: Colors.red),
                          SizedBox(
                            height: AppSize.height10,
                          ),
                          Container(
                            width: Get.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              // color: AppColors.lightGreyColors
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          text:
                                              "\u{20B9} ${controller.productItems.value.price}.00",
                                          textStyle: TextStyles.boldText,
                                          fontSize: AppSize.height15,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: AppSize.width10,
                                        ),
                                        Container(
                                          height: AppSize.height20,
                                          width: AppSize.width100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(24)),
                                              border: Border.all(
                                                  color: Colors.green)),
                                          child: Center(
                                            child: CustomText(
                                              text:
                                                  "${controller.productItems.value.stock ?? " "} In Stock",
                                              textStyle: TextStyles.regularText,
                                              fontSize: AppSize.font12,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: AppSize.height20,
                                      width: AppSize.width130,
                                      // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24)),border: Border.all(color: Colors.green)),
                                      child: Center(
                                        child: CustomText(
                                          text:
                                              "Min. Quantity: ${controller.productDetail.value.minOrderQuantity ?? " "}",
                                          textStyle: TextStyles.regularText,
                                          fontSize: AppSize.font12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppSize.height10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: Get.size.width * 0.85,
                                      height: AppSize.height30,
                                      decoration: const BoxDecoration(
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Colors.black54,
                                                blurRadius: 3.0,
                                                offset: Offset(0.0, 5))
                                          ],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (controller.quantity.value >
                                                  int.parse(controller
                                                      .productDetail
                                                      .value
                                                      .minOrderQuantity!)) {
                                                controller.decreaseQuantity();
                                              }
                                            },
                                            child: const Icon(Icons.remove)
                                                .paddingSymmetric(
                                                    horizontal: 10),
                                            // child: CustomText(
                                            //   text: "-",
                                            //   fontSize: AppSize.height20,
                                            //   color: Colors.black,
                                            // ).paddingSymmetric(horizontal: 10),
                                          ),
                                          Obx(() => CustomText(
                                                text: controller.quantity
                                                    .toString(),
                                                fontSize: AppSize.height15,
                                                color: Colors.black,
                                              ).paddingSymmetric(
                                                  horizontal: 10)),
                                          InkWell(
                                            onTap: () {
                                              controller.increaseQuantity();
                                            },
                                            child: const Icon(Icons.add)
                                                .paddingSymmetric(
                                                    horizontal: 10),
                                          ),
                                        ],
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() {
                                      DateTime now = DateTime.now();

                                      // Parse the start time and end time strings
                                      String startTimeStr = controller
                                          .productDetail
                                          .value
                                          .timeSlot!
                                          .startTime!;
                                      String endTimeStr = controller
                                          .productDetail
                                          .value
                                          .timeSlot!
                                          .endTime!;

                                      // Construct DateTime objects with today's date and the parsed time
                                      DateTime startTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        int.parse(startTimeStr.split(':')[0]),
                                        // Extract hour from time string
                                        int.parse(startTimeStr.split(':')[1]),
                                        // Extract minute from time string
                                        int.parse(startTimeStr.split(':')[
                                            2]), // Extract second from time string
                                      );

                                      DateTime endTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        int.parse(endTimeStr.split(':')[0]),
                                        // Extract hour from time string
                                        int.parse(endTimeStr.split(':')[1]),
                                        // Extract minute from time string
                                        int.parse(endTimeStr.split(':')[
                                            2]), // Extract second from time string
                                      );

                                      // Check if current time is within the specified time range
                                      bool isWithinTimeRange =
                                          now.isAfter(startTime) &&
                                              now.isBefore(endTime);

                                      return controller.showButtonLoader.value
                                          ? const CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<
                                                      Color>(
                                                  Colors
                                                      .red), // Change color here
                                            )
                                          : SizedBox(
                                              width: Get.size.width * 0.85,
                                              height: Get.size.height * 0.05,
                                              child: AppButton(
                                                  onTap:
                                                      // !isWithinTimeRange?(){
                                                      //   Get.snackbar("Alert", "Item not available at this time",colorText: Colors.white,
                                                      //     backgroundColor: Colors.red,);
                                                      // }:
                                                      () {
                                                    controller.addToCart();
                                                  },
                                                  text: "ADD TO CART",
                                                  textColor:
                                                      // isWithinTimeRange?
                                                      Colors.white,
                                                  // :
                                                  // Colors.grey,
                                                  color: AppColors.redColor
                                                  // isWithinTimeRange? AppColors.redColor:AppColors.lightGreyColors,
                                                  ),
                                            );
                                    }),
                                  ],
                                ).paddingOnly(top: 5),
                                SizedBox(
                                  height: AppSize.height10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: Get.size.width * 0.85,
                                      child: AppButton(
                                        onTap: () {
                                          controller.isFavorite.value
                                              ? controller.removeFromFavorites()
                                              : controller.addToFavorites();
                                          // controller.addToCart();
                                        },
                                        text: "Add To WishList",
                                        color: AppColors.lightGreyColors,
                                        textColor: Colors.black,
                                      ),
                                    ),

                                    // AppButton(onTap: (){
                                    //   controller.addToCart().then((value) =>   Get.toNamed(AppPages.cartScreen));
                                    // }, text: "ORDER NOW",color: AppColors.cartHeadingColor, )
                                  ],
                                ).paddingOnly(top: 5),
                              ],
                            ).paddingSymmetric(
                              horizontal: AppSize.width10,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (isShopItemControllerRegistered)
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: CustomText(
                                  text: "Related Products",
                                  textStyle: TextStyles.boldText,
                                  fontSize: AppSize.height15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (isShopItemControllerRegistered)
                      SliverPadding(
                        padding: EdgeInsets.all(AppSize.height15),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18.0,
                            mainAxisSpacing: 18.0,
                            childAspectRatio: 0.75,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var data = shopItemController
                                  .specificCategoryList[index];
                              double? price1 = data.price?.toDouble();
                              double? price2 =
                                  data.productItems![0].price?.toDouble();
                              double minPrice = min(price1!, price2!);
                              double maxPrice = max(price1, price2);
                              return InkWell(
                                onTap: () {
                                  print("here${data.id}");
                                  Get.offNamed(AppPages.foodDetailScreen,
                                      arguments: {"itemId": data.id},
                                      preventDuplicates: false);
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: const Color(0xFFA88C93),
                                              width: 1,
                                            ),
                                          ),
                                          child: Image.network(
                                            data.productItems?[0].images![0]
                                                    .url ??
                                                "",
                                            width: Get.width,
                                            height: AppSize.height90,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      CustomText(
                                        text: data.name.toString(),
                                        maxLine: 1,
                                        textStyle: TextStyles.boldText,
                                        color: Colors.black,
                                        fontSize: AppSize.font12,
                                      ).paddingOnly(
                                        top: AppSize.height10,
                                        right: AppSize.width5,
                                        left: AppSize.width5,
                                      ),
                                      CustomText(
                                        text:
                                            "\u{20B9}$minPrice - \u{20B9}$maxPrice",
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
                            childCount: controller.showAllItems.value
                                ? shopItemController.specificCategoryList.length
                                : (shopItemController
                                            .specificCategoryList.length >
                                        4
                                    ? 4
                                    : shopItemController
                                        .specificCategoryList.length),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          if (isShopItemControllerRegistered &&
                              shopItemController.specificCategoryList.length >
                                  4)
                            Center(
                              child: InkWell(
                                onTap: () {
                                  controller.toggleShowAllItems();
                                },
                                child: Container(
                                  width: AppSize.width100,
                                  height: AppSize.height30,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: Center(
                                    child: Obx(
                                      () => CustomText(
                                        text: controller.showAllItems.value
                                            ? "View Less"
                                            : "View All",
                                        textStyle: TextStyles.mediumHomeText,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).maybePop();
                },
                child: Image.asset(
                  AppAssets.backIcon,
                  height: AppSize.height50,
                  width: AppSize.width50,
                )),
            Image.asset(
              AppAssets.logoIcon,
              height: AppSize.height50,
              width: AppSize.width50,
            ),

            // CustomText(
            //   text: "Details",
            //   color: Colors.black,
            //   fontSize: AppSize.font15,
            //   textStyle: TextStyles.boldText,
            // )
          ],
        ),
        // Row(
        //   children: [
        //     Image.asset(
        //       AppAssets.searchIcon,
        //       height: AppSize.height50,
        //       width: AppSize.width50,
        //     ),
        InkWell(
          onTap: () {
            Get.toNamed(AppPages.cartScreen);
          },
          child: Stack(
            children: [
              Image.asset(
                AppAssets.cartHomeIcon,
                height: AppSize.height50,
                width: AppSize.width50,
              ),
              Positioned(
                right: 5,
                top: 10,
                child: Container(
                  height: AppSize.height18,
                  width: AppSize.width18,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: Center(
                      child: CustomText(
                    text: dashboardController.cardItemList.length.toString(),
                  )),
                ),
              )
            ],
          ),
        ),
        //   ],
        // ),
      ],
    );
  }

  Widget _foodDetails() {
    print(
        "product items present in this ${controller.productDetail.value.productItems?.length}");
    print(controller.productItems.value.productConfig);
    final PageController pageController = PageController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //     decoration: BoxDecoration(
        //
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.2), // Shadow color
        //           spreadRadius: 2, // How much the shadow should spread
        //           blurRadius: 5, // How blurry the shadow should be
        //           offset: Offset(0, 5), // Shadow offset
        //         ),
        //       ],
        //     ),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.all(Radius.circular(12)),
        //       child: Image.network(
        //       controller.productItems.value.images?[0].url.toString() ?? "",
        //         height: AppSize.height148,
        //         width: Get.width,
        //         // width: 400,
        //         fit: BoxFit.fill,
        //         // fit: BoxFit.contain,
        //       ),
        //     )),
        Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2), // Shadow color
                  spreadRadius: 2, // How much the shadow should spread
                  blurRadius: 5, // How blurry the shadow should be
                  offset: const Offset(0, 5), // Shadow offset
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.height148,
                    width: Get.width * 0.8,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount:
                          controller.productItems.value.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Image.network(
                          controller.productItems.value.images?[index].url
                                  .toString() ??
                              "",
                          height: AppSize.height148,
                          width: Get.width * 0.8,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: controller.productItems.value.images?.length ?? 0,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.red,
              dotColor: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(color: Colors.black12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary),
                      child: Image.asset(
                        AppAssets.vegetarianIcon,
                        height: AppSize.height8,
                        width: AppSize.height8,
                      ).paddingAll(8)),
                  const SizedBox(width: 5.0),
                  SizedBox(
                    width: Get.size.width * 0.6,
                    child: CustomText(
                      text: controller.productDetail.value.shop?.name
                              .toString() ??
                          " ",
                      textStyle: TextStyles.boldText,
                      color: Colors.black,
                      fontSize: AppSize.font12,
                      maxLine: 2,
                    ),
                  ),
                ],
              ).paddingSymmetric(
                  horizontal: AppSize.width10, vertical: AppSize.height8),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  controller.isFavorite.value
                      ? controller.removeFromFavorites()
                      : controller
                          .addToFavorites(); // Call method to add to favorites
                },
                icon: controller.isFavorite.value
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                color: Colors.deepPurpleAccent,
              ),
            )
          ],
        ).paddingOnly(top: AppSize.height15),
        CustomText(
          text: controller.productDetail.value.name!,
          color: Colors.black,
          fontSize: AppSize.font20,
          textStyle: TextStyles.boldText,
        ).paddingSymmetric(vertical: AppSize.height5),
        CustomText(
          text: controller.productDetail.value.description!,
          color: Colors.black54,
          fontSize: AppSize.font12,
          textStyle: TextStyles.regularText,
        ).paddingSymmetric(vertical: AppSize.height0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Image.asset(
            //       AppAssets.starIcon,
            //       height: AppSize.height18,
            //       width: AppSize.width20,
            //       fit: BoxFit.fill,
            //     ).paddingOnly(right: 10),
            //     CustomText(
            //       text: "4.7",
            //       color: Colors.black,
            //       fontSize: AppSize.font15,
            //       textStyle: TextStyles.boldText,
            //     )
            //   ],
            // ).paddingAll(10),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Image.asset(
            //       AppAssets.starIcon,
            //       height: AppSize.height18,
            //       width: AppSize.width20,
            //       fit: BoxFit.fill,
            //     ).paddingOnly(right: 10),
            //     CustomText(
            //       text: "150",
            //       color: Colors.black,
            //       fontSize: AppSize.font15,
            //       textStyle: TextStyles.boldText,
            //     )
            //   ],
            // ).paddingAll(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.clockIcon,
                  height: AppSize.height18,
                  width: AppSize.width20,
                  fit: BoxFit.fill,
                ).paddingOnly(right: 10),
                CustomText(
                  text: controller.productDetail.value.timeSlot?.slot ?? "",
                  color: Colors.black,
                  fontSize: AppSize.font15,
                  textStyle: TextStyles.regularText,
                )
              ],
            ).paddingSymmetric(vertical: AppSize.height10),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ${controller.productItems.value.productConfig?[0].option?.value??''}
            Row(
              children: [
                CustomText(
                  text: "Weight: ",
                  textStyle: TextStyles.boldText,
                  fontSize: AppSize.height12,
                  color: Colors.black54,
                ),
                controller.productItems.value.productConfig == null ||
                        controller.productItems.value.productConfig!.isEmpty ||
                        (controller.productDetail.value.productItems?.length ??
                                0) >
                            1
                    ? Container()
                    : CustomText(
                        text: controller.selectedItem.value,
                        textStyle: TextStyles.regularText,
                        fontSize: AppSize.height12,
                        color: Colors.black54,
                      ),
              ],
            ),
            (controller.productDetail.value.productItems?.length ?? 0) > 1
                ? Obx(() => Container(
                      width: Get.size.width * 0.65,
                      decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1.0,
                              offset: Offset(0.0, 4))
                        ],
                        color: Color(0xFFF9EADA),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        // color: AppColors.lightGreyColors
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          // Initial Value
                          value: controller.selectedItem.value,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: controller.list
                              .asMap()
                              .entries
                              .map((MapEntry<int, String> entry) {
                            int index = entry.key;
                            String item = entry.value;
                            return DropdownMenuItem(
                              onTap: () {
                                controller.selectedItem.value =
                                    item; // Update selected item
                                controller.productItems.value = controller
                                    .productDetail.value.productItems![index];
                                print(
                                    "product id selected${controller.productDetail.value.productItems![index].id.toString()} ");
                                // Get.back();
                              },
                              value: item,
                              child: SizedBox(
                                width: Get.size.width * 0.45,
                                child: Text(
                                  item,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),

                          // After selecting the desired option, it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            controller.updatePrice(newValue!);

                            // Your onChanged logic goes here if needed.
                          },
                        ),
                      ),
                    ))
                : Container(),
          ],
        ).paddingSymmetric(vertical: AppSize.height10).paddingOnly(right: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Category",
              textStyle: TextStyles.boldText,
              fontSize: AppSize.height12,
              color: Colors.black54,
            ),
            SizedBox(
              height: AppSize.height15,
              child: CustomText(
                text: controller.productDetail.value.category?.slug ?? "Veg",
                textStyle: TextStyles.regularText,
                fontSize: AppSize.height12,
                color: Colors.black54,
              ),
            ).paddingOnly(top: AppSize.height6)
          ],
        ).paddingSymmetric(vertical: AppSize.height6),
        SizedBox(
          height: AppSize.height10,
        ),

        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //
        //     CustomText(text: "Stocks: ", textStyle: TextStyles.regularText,fontSize: AppSize.height12,color: Colors.black54,),
        //
        //     SizedBox(
        //       height: AppSize.height25,
        //       child:CustomText(text: controller.productItems.value.stock?? " ", textStyle: TextStyles.regularText,fontSize: AppSize.height12,color: Colors.black54,),
        //
        //     )
        //
        //   ],
        // ).paddingSymmetric(vertical: AppSize.height6),
      ],
    ).paddingSymmetric(horizontal: AppSize.width10, vertical: AppSize.height6);
  }

  Future<void> loadDataForId(String? id) async {
    try {
      // Simulate a delay or asynchronous data loading process
      await Future.delayed(const Duration(seconds: 1));

      // Once data is loaded, update the UI or perform additional processing
      print('Data loaded for ID $id');
    } catch (e) {
      // Handle any errors that occur during data loading
      print('Error loading data for ID $id: $e');
    }
  }
}
