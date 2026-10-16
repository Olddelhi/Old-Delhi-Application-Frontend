import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_text_form_field.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/ui/home/video_player_screen.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../components/text_styles.dart';
import '../../responses/category_response.dart';
import '../dashboard/dashboard_controller.dart';
import '../popular_shop/popular_shop_controller.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  @override
  HomeController controller = Get.put(HomeController());
  final popularController = Get.put(PopularShopController());
  List<String> category = ["All", "Vegetarian", "Non-vegetarian", "Chaat"];
  final dashboardController = Get.find<DashboardController>();

  final List<String> _image = [
    AppAssets.noodle,
    AppAssets.burger,
    AppAssets.biryani,
    AppAssets.kufli,
    AppAssets.biryani,
    AppAssets.burger,
  ];

  final List<String> _summerDealImage = [
    AppAssets.kuremal,
    AppAssets.alJawar,
    AppAssets.kanwarji,
  ];

  final List<String> _summerDealShop = [
    "Kuremal Mohan Lal Special Kulfi",
    "AL-Jawahar",
    "Kanwarji-Bhagirath-Mal",
  ];

  final List<String> _imageText = [
    "Noodles",
    "Burger",
    "Biryani",
    "Kulfi",
    "Biryani",
    "Burger",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // print("${controller.categoryList[1].name}${controller.categoryList[0].name}");
                            Get.toNamed(
                              AppPages.searchProductScreen,
                            );
                          },
                          child: Image.asset(
                            AppAssets.menuIcon,
                            height: AppSize.height35,
                            width: AppSize.width40,
                          )),
                      // _deliverToText(),
                      // Expanded(child: SizedBox()),
                      SizedBox(
                        width: AppSize.width10,
                      ),
                      Image.asset(
                        AppAssets.logoIcon,
                        height: AppSize.height35,
                        width: AppSize.width40,
                      ),
                      const Expanded(child: SizedBox()),
                      // Image.asset(
                      //   AppAssets.notificationHomeIcon,
                      //   height: AppSize.height35,
                      //   width: AppSize.width40,
                      // ),
                      Obx(
                        () => InkWell(
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
                                        )),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  _userNameAndGreeting(context),
                  // _searchTextField(),
                  Container(
                    height: AppSize.height40,
                    decoration: BoxDecoration(
                        color: AppColors.textFormColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.radius10))),
                    padding: EdgeInsets.all(AppSize.height5),
                    child: TextFormField(
                      controller: controller.searchTextController,
                      style: TextStyles.regularText,
                      onChanged: (query) {
                        controller.filterProducts(query);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: AppStrings.searchDishesRestaurant,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.searchTextController.text.isNotEmpty,
                      child: Column(
                        children: [
                          controller.filteredProductList.isEmpty
                              ? Image.asset(AppAssets.noSearchFound)
                              : SizedBox(
                                  height: Get.height * 0.2,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount:
                                        controller.filteredProductList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var product =
                                          controller.filteredProductList[index];
                                      return InkWell(
                                        onTap: () {
                                          print('category search');
                                          print(product['id']);
                                          Get.toNamed(AppPages.foodDetailScreen,
                                              arguments: {
                                                "itemId": product['id']
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            Image.network(
                                              product['productItems'][0]
                                                  ['images'][0]['url'],
                                              fit: BoxFit.fill,
                                              height: AppSize.height50,
                                              width: AppSize.width70,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.68,
                                                  child: CustomText(
                                                    text: product['name']
                                                            .toString() ??
                                                        '',
                                                    textStyle:
                                                        TextStyles.regularText,
                                                    color: Colors.black,
                                                    fontSize: AppSize.font16,
                                                    maxLine: 1,
                                                  ).paddingOnly(
                                                    top: AppSize.height10,
                                                    right: AppSize.width5,
                                                    left: AppSize.width10,
                                                  ),
                                                ),
                                                /*    Row(
                                                children: [
                  */ /*                                CustomText(
                                                    text:
                                                    "\u{20B9}${product['price']
                                                        .toString()} -" ??
                                                        '',
                                                    textStyle: TextStyles
                                                        .regularText,
                                                    color: Colors.grey,
                                                    fontSize: AppSize.font14,
                                                  ).paddingOnly(
                                                    top: AppSize.height5,
                                                    right: AppSize.width5,
                                                    left: AppSize.width5,
                                                  ),*/ /*
                                                  ...product['productItems']
                                                      .map<Widget>((item) {
                                                    return CustomText(
                                                      text:
                                                      "\u{20B9}${item['price']
                                                          .toString()}" ??
                                                          '',
                                                      textStyle: TextStyles
                                                          .regularText,
                                                      color: Colors.grey,
                                                      fontSize:
                                                      AppSize.font14,
                                                    ).paddingOnly(
                                                      top: AppSize.height5,
                                                      right: AppSize.width5,
                                                      // left: AppSize.width5,
                                                    );
                                                  }).toList(),
                                                ],
                                              ),*/
                                              ],
                                            ),
                                          ],
                                        ).paddingSymmetric(
                                          horizontal: AppSize.width10,
                                          vertical: AppSize.height10,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.all(Radius.circular(AppSize.radius10)),
                          //     border: Border.all(color: Colors.black),
                          //   ),
                          //   child: CustomText(
                          //     text: AppStrings.viewAll,
                          //     textStyle: TextStyles.mediumText,
                          //   ).paddingAll(12),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  Obx(() {
                    if (controller.bannerData.isEmpty) {
                      return Center(
                          child: SizedBox(
                              height: Get.size.height * 0.18,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      AppAssets.choleKulcheHome,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  );
                                },
                              ))).paddingSymmetric(vertical: 10);
                    } else {
                      final positionOneData = controller.bannerData
                          .where((app) => app.position == 1)
                          .toList();
                      return SizedBox(
                        height: Get.size.height * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: positionOneData.length,
                          itemBuilder: (context, index) {
                            final app = positionOneData[index];
                            return InkWell(
                                onTap: () {
                                  Get.toNamed(AppPages.shopItemScreen,
                                      arguments: {
                                        "category": app.category.slug,
                                        "fromShop": false
                                      });
                                },
                                child: Column(children: [
                                  Container(
                                    height: Get.size.height * 0.2,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Image.network(
                                        app.image.url,
                                        height: Get.size.height * 0.2,
                                        width: Get.size.width * 0.9,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ])).paddingSymmetric(horizontal: 10);
                          },
                        ),
                      ).paddingSymmetric(vertical: 20);
                    }
                  }),
                  // Image.asset(AppAssets.lotanCholeImage,
                  //   height: AppSize.height100, width: Get.width, fit: BoxFit.fill,).paddingSymmetric(vertical: AppSize.height15),
                  // CustomText(text: AppStrings.cityMostHotFavourite, textStyle: TextStyles.boldText,
                  //   fontSize:  AppSize.font14,color: Colors.black,).paddingSymmetric(vertical: AppSize.height15),
                  // _gridView(),
                  //  CustomText(text: AppStrings.mouthWateringFood, textStyle: TextStyles.boldText,
                  //    fontSize:  AppSize.font14,color: Colors.black,).paddingSymmetric(vertical: AppSize.height15),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => SizedBox(
                      height: Get.size.height * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.data.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, index) {
                          // Check if the URL is an image by verifying its file extension
                          bool isImage = controller.data[index].videoUrl
                                  .endsWith('.jpg') ||
                              controller.data[index].videoUrl
                                  .endsWith('.jpeg') ||
                              controller.data[index].videoUrl.endsWith('.png');

                          // Method to generate a video thumbnail if it's a video
                          Future<File> generateThumbnail() async {
                            final String? path =
                                await VideoThumbnail.thumbnailFile(
                              video: controller.data[index].videoUrl,
                              thumbnailPath:
                                  (await getTemporaryDirectory()).path,
                              imageFormat: ImageFormat.PNG,
                              maxHeight: 70,
                              quality: 50,
                            );
                            return File(path!);
                          }

                          // If the URL is an image, load it directly; otherwise, generate a thumbnail
                          final image = isImage ? null : generateThumbnail();
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (isImage) {
                                    Get.to(FullScreenVideoScreen(
                                      videoUrl: controller.data[index].videoUrl,
                                      description:
                                          controller.data[index].description,
                                      name: controller.data[index].name,
                                      thumbnailImage:
                                          controller.data[index].videoUrl,
                                    ));
                                    // Open the image in full screen
                                    // Get.to(FullScreenImageScreen(
                                    //   imageUrl: controller.data[index].videoUrl,
                                    // ));
                                  }
                                  // else {
                                  //   // Open the video in full screen
                                  //   Get.to(FullScreenVideoScreen(
                                  //     videoUrl: controller.data[index].videoUrl,
                                  //     description: controller.data[index].description,
                                  //     name: controller.data[index].name,
                                  //   ));
                                  // }
                                },
                                child: Stack(
                                  children: [
                                    isImage
                                        ? SizedBox(
                                            height: 85,
                                            width: 85,
                                            /* decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.red, width: 2),
                                      ),*/
                                            child: ClipOval(
                                              child: Image.network(
                                                controller.data[index].videoUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : FutureBuilder<File>(
                                            future: image,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child: SizedBox(
                                                    height: 85,
                                                    width: 85,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.red),
                                                    ),
                                                  ),
                                                ); // Show a loading indicator while fetching the thumbnail
                                              } else if (snapshot.hasData) {
                                                final thumbnailFile =
                                                    snapshot.data!;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                            FullScreenVideoScreen(
                                                          videoUrl: controller
                                                              .data[index]
                                                              .videoUrl,
                                                          description:
                                                              controller
                                                                  .data[index]
                                                                  .description,
                                                          name: controller
                                                              .data[index].name,
                                                          thumbnailImage:
                                                              thumbnailFile,
                                                        ));
                                                      },
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors.red,
                                                              width: 2),
                                                        ),
                                                        child: ClipOval(
                                                          child: Image.file(
                                                            thumbnailFile,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        controller
                                                            .data[index].name,
                                                        style: TextStyles
                                                            .semiBoldText,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.red,
                                                        width: 2),
                                                  ),
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      AppAssets.logoIcon,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 10, vertical: 0);
                        },
                      ),
                    ),
                  ),
                  //SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        // Get.toNamed(AppPages.popularShopScreen);
                      },
                      child: CustomText(
                        text: AppStrings.bestSummerDeals,
                        textStyle: TextStyles.semiBoldText,
                        fontSize: AppSize.font18,
                        color: Colors.black,
                      ).paddingSymmetric(horizontal: 20, vertical: 1),
                    ).paddingOnly(bottom: 8),
                  ),

                  SizedBox(
                    height: Get.height * 0.14,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        // itemCount: controller.shopList.length,// Replace 10 with your actual item count
                        itemBuilder: (context, index) {
                          // var data= controller.shopList[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _summerDealShop[index] ==
                                          "Kuremal Mohan Lal Special Kulfi"
                                      ? Get.toNamed(AppPages.shopItemScreen,
                                          arguments: {
                                              "category":
                                                  _summerDealShop[index],
                                              "fromShop": false
                                            })
                                      : Get.toNamed(AppPages.shopItemScreen,
                                          arguments: {
                                              "category":
                                                  _summerDealShop[index],
                                              "fromShop": true
                                            });
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppSize.radius10),
                                    ),
                                    child: Image.asset(
                                      _summerDealImage[index],
                                      width: Get.width * 0.29,
                                      fit: BoxFit.contain,
                                    )),
                              )
                              // Image.network(data.images![0].url!, width: Get.width*0.3,fit: BoxFit.fill,)),
                              // CustomText(text:data.name.toString(), textStyle: TextStyles.mediumText, fontSize: AppSize.font18,
                              // color: Colors.black,
                              // ).paddingSymmetric(vertical: 5, horizontal: 5)
                            ],
                          ).paddingSymmetric(horizontal: 5, vertical: 2);
                        }),
                  ),
                  CustomText(
                    text: AppStrings.mouthWateringFood,
                    textStyle: TextStyles.semiBoldText,
                    fontSize: AppSize.font18,
                    color: Colors.black,
                  ).paddingSymmetric(horizontal: 10, vertical: 10),

                  const SizedBox(
                    height: 10,
                  ),

                  CategorySection1(
                    categoryName: 'Namkeens & Sweets',
                    categories: controller.categoryList1,
                    showingCatName: 'Namkeens & Sweets',
                  ),
                  CategorySection1(
                    categoryName: 'Chandini Chowk Se',
                    categories: controller.categoryList1,
                    showingCatName: 'Veg',
                  ),
                  CategorySection1(
                    categoryName: 'Jama Mazjid Se',
                    categories: controller.categoryList1,
                    showingCatName: 'Non Veg',
                  ),
                  CategorySection1(
                    categoryName: 'Chaat',
                    categories: controller.categoryList1,
                    showingCatName: 'Chaat',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ).paddingSymmetric(
                  vertical: AppSize.height10, horizontal: AppSize.width10),
              Center(
                  child: Container(
                color: Colors.red.withValues(alpha: 0.5),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Purani Dilli is home to a number of delicacies',
                      style: TextStyle(
                        fontFamily: FontFamily.medium,
                        color: Colors.black,
                        fontSize: AppSize.font18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                          // width: MediaQuery.of(context).size.width*0.99,
                          height: Get.size.height * 0.28,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.allProducts.length > 15
                                ? 15
                                : controller.allProducts.length,
                            padding: const EdgeInsets.only(right: 8),
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(AppPages.shopItemScreen,
                                        arguments: {
                                          "category": controller
                                              .allProducts[index].shop.slug,
                                          "fromShop": true
                                        });
                                  },
                                  child: Container(
                                      // width: Get.size.width * 0.4,
                                      width: 160,
                                      height: Get.size.height * 0.28,
                                      // height: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12)),
                                            child: Image.network(
                                              controller
                                                  .allProducts[index]
                                                  .productItems[0]
                                                  .images[0]
                                                  .url,
                                              height: Get.size.height * 0.12,
                                              // height: 110,
                                              width: Get.size.width,
                                              fit: BoxFit.fill,
                                              // fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.size.height * 0.06,
                                            child: Text(
                                              controller
                                                  .allProducts[index].name,
                                              style: TextStyle(
                                                fontFamily: FontFamily.medium,
                                                color: Colors.black,
                                                fontSize: AppSize.font12,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ).paddingSymmetric(
                                                vertical: 10, horizontal: 15),
                                          ),
                                          const SizedBox(),
                                          CustomText(
                                            text:
                                                "\u{20B9}${controller.allProducts[index].price}-\u{20B9}${controller.allProducts[index].productItems[0].price}",
                                            textStyle: TextStyles.regularText,
                                            maxLine: 1,
                                            fontSize: AppSize.font12,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Expanded(child: SizedBox()),
                                          Container(
                                            height: 25,
                                            width: 100,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "View product",
                                                style: TextStyle(
                                                  fontFamily: FontFamily.medium,
                                                  color: Colors.white,
                                                  fontSize: AppSize.font10,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )).paddingOnly(bottom: 8),
              Center(
                  child: CustomText(
                text: AppStrings.getBestDeal,
                textStyle: TextStyles.mediumHomeText,
                maxLine: 2,
                fontSize: AppSize.font18,
                color: Colors.black,
              ).paddingSymmetric(vertical: 10)),
              Obx(() {
                if (controller.bannerData.isEmpty) {
                  return Container();
                } else {
                  final positionTwoData = controller.bannerData
                      .where((app) => app.position != 1)
                      .toList();
                  return SizedBox(
                    height: Get.size.height * 0.2,
                    child: CarouselSlider.builder(
                      itemCount: positionTwoData.length,
                      options: CarouselOptions(
                        height: Get.size.height * 0.2,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, index, _) {
                        final app = positionTwoData[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppPages.shopItemScreen, arguments: {
                              "category": app.category.slug,
                              "fromShop": false
                            });
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                child: Image.network(
                                  app.image.url,
                                  height: Get.size.height * 0.17,
                                  width: Get.size.width * 0.9,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ).paddingSymmetric(horizontal: 10);
                      },
                    ).paddingSymmetric(horizontal: 10, vertical: 10),
                  );
                }
              }),

              // Image.asset(
              //   AppAssets.ashokChaat,
              //   width: Get.width,
              // ).paddingSymmetric(vertical: 5),
              Image.asset(
                AppAssets.homeFooter,
                width: Get.width,
              ).paddingSymmetric(vertical: 10),
              Image.asset(
                AppAssets.homeBottom,
                width: Get.width * 0.9,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _wraperWidget()
  // {
  //   return Wrap(
  //     children: <Widget>[
  //       Container(
  //              decoration: BoxDecoration(
  //                color: AppColors.redColor,
  //                borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
  //
  //              ),
  //           child:CustomText(text: "All", textStyle: TextStyles.mediumText, fontSize: AppSize.font15,
  //           color: Colors.white,
  //           ).paddingAll(10)
  //       ).paddingAll(10),
  //       Container(
  //           decoration: BoxDecoration(
  //               color: AppColors.redColor,
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
  //
  //           ),
  //           child:CustomText(text: "Veg", textStyle: TextStyles.mediumText, fontSize: AppSize.font15,
  //             color: Colors.white,
  //           ).paddingAll(10)
  //       ).paddingAll(10),
  //       Container(
  //           decoration: BoxDecoration(
  //               color: AppColors.redColor,
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
  //
  //           ),
  //           child:CustomText(text: "Non-veg", textStyle: TextStyles.mediumText, fontSize: AppSize.font15,
  //             color: Colors.white,
  //           ).paddingAll(10)
  //       ).paddingAll(10),
  //       Container(
  //           decoration: BoxDecoration(
  //               color: AppColors.redColor,
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
  //
  //           ),
  //           child:CustomText(text: "Namkeens & sweets", textStyle: TextStyles.mediumText, fontSize: AppSize.font15,
  //             color: Colors.white,
  //           ).paddingAll(10)
  //       ).paddingAll(10),
  //       Container(
  //           decoration: BoxDecoration(
  //               color: AppColors.redColor,
  //               borderRadius: BorderRadius.all(Radius.circular(AppSize.radius20))
  //
  //           ),
  //           child:CustomText(text: "Chaat", textStyle: TextStyles.mediumText, fontSize: AppSize.font15,
  //             color: Colors.white,
  //           ).paddingAll(10)
  //       ).paddingAll(10),
  //     ],
  //   ).paddingSymmetric(horizontal: AppSize.width20);
  // }
  //
  // Widget _deliverToText(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       CustomText(text: AppStrings.deliverTo.toUpperCase(),
  //         textStyle: TextStyles.boldText,color: AppColors.orangeColor, ),
  //
  //       Row(
  //         children: [
  //   Obx(
  //   ()=>
  //              CustomText(text: controller.addressList.isNotEmpty? controller.addressList[0].address?.city??" ":" ",
  //               textStyle: TextStyles.boldText,color: Colors.black45, ),
  //           ),
  //            Icon(Icons.arrow_drop_down, color: Colors.black45,)
  //         ],
  //       )
  //
  //     ],
  //   ).paddingOnly(left: AppSize.width10);
  // }

  Widget _userNameAndGreeting(BuildContext context) {
    // Get the current time
    DateTime now = DateTime.now();
    int hour = now.hour;

    String greeting;
    // Determine the appropriate greeting based on the time of day
    if (hour < 12) {
      greeting = 'Good Morning!';
    } else if (hour < 17) {
      greeting = 'Good Afternoon!';
    } else {
      greeting = 'Good Evening!';
    }

    return RichText(
      text: TextSpan(
        text: 'Hey, ',
        style: TextStyle(
            color: Colors.black, fontSize: AppSize.font15, fontFamily: "Sen"),
        children: <TextSpan>[
          TextSpan(
            text: greeting,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: AppSize.font15,
                fontFamily: "Sen"),
          ),
        ],
      ),
    ).paddingSymmetric(vertical: AppSize.height10);
  }

  // Widget buildCategoryButton(String category) {
  //   return GestureDetector(
  //     onTap: () {
  //       controller.filterByCategory(category);
  //     },
  //     child: Obx(
  //       () => Container(
  //         margin: EdgeInsets.symmetric(horizontal: 10),
  //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //         decoration: BoxDecoration(
  //             color: controller.selectedCategory.value == category
  //                 ? Colors.white
  //                 : Colors.red,
  //             borderRadius: BorderRadius.circular(20),
  //             border: controller.selectedCategory.value == category
  //                 ? Border.all(color: Colors.red)
  //                 : Border.all(color: Colors.white)),
  //         child: Text(
  //           category,
  //           style: TextStyle(
  //             color: controller.selectedCategory.value == category
  //                 ? Colors.red
  //                 : Colors.white,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  AppTextFormField _searchTextField() {
    return AppTextFormField(
      isPrefixIcon: true,
      showIcon: true,
      onFieldSubmitted: (value) {},
      obscureText: false,
      controller: controller.searchTextController,
      focusNode: controller.searchTextNode,
      hintText: AppStrings.searchDishesRestaurant,
    );
  }
}

RxList<Category> filterCategories(
    RxList<Category> categories, String categoryName) {
  return categories
      .where((category) => category.name == categoryName)
      .toList()
      .obs;
}

class CategorySection1 extends StatelessWidget {
  final String categoryName;
  final String showingCatName;
  final RxList<Category> categories;

  const CategorySection1(
      {super.key,
      required this.categoryName,
      required this.showingCatName,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      RxList<Category> filteredCategories =
          filterCategories(categories, categoryName);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: showingCatName,
            textStyle: TextStyles.semiBoldText,
            fontSize: AppSize.font18,
            color: Colors.black,
          ).paddingSymmetric(
            horizontal: 10,
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: filteredCategories.length,
          //   itemBuilder: (context, index) {
          //     print("herrrererer------>${filteredCategories[index].subCategories?.length}");
          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         ListView.builder(
          //           shrinkWrap: true,
          //           physics: NeverScrollableScrollPhysics(),
          //           itemCount: filteredCategories[index].subCategories?.length,
          //           itemBuilder: (context, subIndex) {
          //
          //             return Padding(
          //               padding: const EdgeInsets.only(left: 16.0),
          //               child: ListTile(
          //                 title: Text(
          //                   filteredCategories[index].subCategories?[subIndex]['name'],
          //                   style: TextStyle(color: Colors.black),
          //                 ),
          //                 onTap: () {
          //                   // Handle subcategory tap
          //                 },
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.zero,
                itemCount: filteredCategories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount:
                          filteredCategories[index].subCategories?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, subIndex) {
                        // var data= controller.shopList[index];
                        print(
                            "slug name---->${filteredCategories[index].subCategories?[subIndex]['slug']}");
                        return InkWell(
                            onTap: () {
                              Get.toNamed(AppPages.shopItemScreen, arguments: {
                                "category": filteredCategories[index]
                                    .subCategories?[subIndex]['slug'],
                                // "fromShop": true
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.5),
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
                                            Radius.circular(AppSize.radius10),
                                      ),
                                      child: filteredCategories.isNotEmpty &&
                                              filteredCategories[index].subCategories !=
                                                  null &&
                                              filteredCategories[index]
                                                  .subCategories!
                                                  .isNotEmpty &&
                                              filteredCategories[
                                                              index]
                                                          .subCategories![
                                                      subIndex] !=
                                                  null &&
                                              filteredCategories[index]
                                                          .subCategories![subIndex]
                                                      ['image'] !=
                                                  null &&
                                              filteredCategories[index]
                                                          .subCategories![subIndex]
                                                      ['image']['url'] !=
                                                  null &&
                                              filteredCategories[index]
                                                  .subCategories![subIndex]
                                                      ['image']['url']
                                                  .isNotEmpty
                                          ? Image.network(
                                              filteredCategories[index]
                                                      .subCategories![subIndex]
                                                  ['image']['url'],
                                              width: 320,
                                              height: 65,
                                              fit: BoxFit.fitWidth,
                                            )
                                          : Image.asset(
                                              "assets/images/logo_icon.png",
                                              width: 320,
                                              height: 65,
                                              fit: BoxFit.fitWidth,
                                            ),
                                    ),
                                    Center(
                                      child: CustomText(
                                        text: filteredCategories[index]
                                            .subCategories?[subIndex]['name'],
                                        textStyle: TextStyles.mediumHomeText,
                                        textAlign: TextAlign.center,
                                        maxLine: 2,
                                        fontSize: AppSize.font12,
                                        color: Colors.black,
                                      ).paddingOnly(
                                          top: 2, left: 10, right: 10),
                                    ),
                                  ],
                                )));
                      });
                }),
          ),
        ],
      );
    });
  }
}
