import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/your_order_detail/your_order_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../responses/get_orders_response.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

enum OrderStatus {
  PENDING,
  PROCESSING,
  SHIPPED,
  DELIVERED,
  CANCELLED,
}

class OrderDetailsScreen extends GetView<YourOrderDetailController> {
  OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  Order order;

  @override
  final YourOrderDetailController controller =
      Get.put(YourOrderDetailController());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _appBar(),
            ),
            const SliverToBoxAdapter(
              child: Divider(thickness: 2),
            ),
            SliverToBoxAdapter(
              child:
                  _orderList(), // Make sure _orderList is scrollable within the same CustomScrollView
            ),
            const SliverToBoxAdapter(
              child: Divider(thickness: 2),
            ),
            SliverToBoxAdapter(
              child: _orderStatusStepper(),
            ),
            const SliverToBoxAdapter(
              child: Divider(thickness: 2),
            ),
            SliverToBoxAdapter(
              child: _paymentDetail(),
            ),
            SliverToBoxAdapter(
              child: _addressDetail(),
            ),
            const SliverToBoxAdapter(
              child: Divider(thickness: 2),
            ),
            SliverToBoxAdapter(
              child: _cancelAndHelpButton(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderList() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Prevent independent scrolling
      itemCount: order.orderItems.length,
      itemBuilder: (context, index) {
        final OrderItem item = order.orderItems[index];
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: AppSize.width15, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Product Name (Fixed width)
              SizedBox(
                width: Get.width * 0.42, // Fixed width for name
                child: CustomText(
                  text: item.productItem.product.name,
                  maxLine: 2,
                  textStyle: TextStyles.regularText,
                  fontSize: AppSize.font14,
                  // overflow: TextOverflow.ellipsis, // Prevents overflow
                ),
              ),
              SizedBox(width: AppSize.width8),

              // Weight (if available and > 100)
              // if (item.productItem.weight != null && item.productItem.weight! > 100)
              /*     SizedBox(
                    width: AppSize.width40, // Fixed width for weight
                    child: CustomText(
                      text: "${item.productItem.weight}g",
                      textStyle: TextStyles.regularText,
                      fontSize: AppSize.font14,
                      textAlign: TextAlign.center,
                    ),
                  ),*/
              SizedBox(width: AppSize.width10),

              // Quantity
              SizedBox(
                width: AppSize.width30, // Fixed width for quantity
                child: CustomText(
                  text: "x${item.quantity}",
                  textStyle: TextStyles.regularText,
                  fontSize: AppSize.font14,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: AppSize.width5),

              // Price
              SizedBox(
                width: AppSize.width60, // Fixed width for price
                child: CustomText(
                  text: "\u{20B9}${item.productItem.price * item.quantity}",
                  textStyle: TextStyles.regularText,
                  fontSize: AppSize.font14,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentDetail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Total",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font16,
            ),
            SizedBox(
              width: Get.width * 0.2,
              child: CustomText(
                text: "\u{20B9}${order.grandTotal}",
                maxLine: 2,
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font14,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Payment Status",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            SizedBox(
              width: Get.width * 0.25,
              child: CustomText(
                text: order.paymentStatus.toString(),
                maxLine: 2,
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font14,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Payment Via",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            SizedBox(
              width: Get.width * 0.45,
              child: Text(
                order.paymentGateway.toString(),
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ).paddingOnly(right: 20),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Payment Id",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            // SizedBox(width: Get.width*0.2,
            //   child: order.paymentId.toString()=="null"?Container():CustomText(text:order.paymentId.toString(),maxLine: 2, textStyle: TextStyles.regularText,
            //     fontSize: AppSize.font14,
            //   ),
            // ),
          ],
        ),
      ],
    ).paddingOnly(left: 20);
  }

  Widget _addressDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Address Details",
          textStyle: TextStyles.boldOrderText,
          fontSize: AppSize.font16,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Name: ",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            SizedBox(
                width: Get.width * 0.3,
                child: Text(
                  order.orderAddress.name.toString(),
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Address: ",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            SizedBox(
                width: Get.width * 0.3,
                child: Text(
                  "${order.orderAddress.address} ${order.orderAddress.city}",
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Pin Code: ",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            SizedBox(
                width: Get.width * 0.15,
                child: Text(
                  order.orderAddress.pincode.pincode,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Phone Number: ",
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
            ),
            SizedBox(
                width: Get.width * 0.25,
                child: Text(
                  order.orderAddress.mobile,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: AppSize.width15, vertical: AppSize.height10);
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
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          AppAssets.logoIcon,
          height: AppSize.height50,
          width: AppSize.width50,
        ),
        Expanded(
          child: CustomText(
            text: AppStrings.orderDetail,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    ).paddingSymmetric(vertical: 5);
  }

  Widget _orderStatusStepper() {
    return Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.red, // Change this to your desired active color
            surface: Colors.grey, // Change this to your desired inactive color
          ),
        ),
        child: Stepper(
          physics:
              const NeverScrollableScrollPhysics(), // Prevent Stepper from interfering with scroll
          margin: EdgeInsets.zero,
          currentStep: _getCurrentStep(),
          steps: _getStepperSteps(),
          controlsBuilder: (BuildContext context, ControlsDetails) {
            return Container(); //Hiding controls as we only need the steps for display
          },
        ));
  }

  int _getCurrentStep() {
    switch (order.status) {
      case "PENDING":
        return 0;
      case "PROCESSING":
        return 1;
      case 'SHIPPED':
        return 2;
      case "DELIVERED":
        return 3;
      case "CANCELLED":
        return 4;
      default:
        return 0;
    }
  }

  List<Step> _getStepperSteps() {
    return [
      Step(
        title: Column(
          children: [
            CustomText(
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font14,
              text: 'Pending',
            ),
            CustomText(
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font10,
              text:
                  "${DateTime.parse(order.createdAt).day}/${DateTime.parse(order.createdAt).month}/${DateTime.parse(order.createdAt).year}",
            ),
            CustomText(
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font10,
              text:
                  "${DateTime.parse(order.createdAt).hour}:${DateTime.parse(order.createdAt).minute}:${DateTime.parse(order.createdAt).second}",
            ),
          ],
        ),
        content: const SizedBox.shrink(),
        isActive: order.status == 'PENDING',
      ),
      Step(
        title: CustomText(
          textStyle: TextStyles.regularText,
          fontSize: AppSize.font14,
          text: 'Processing',
        ),
        content: const SizedBox.shrink(),
        isActive: order.status == 'PROCESSING',
      ),
      Step(
        title: CustomText(
          textStyle: TextStyles.regularText,
          fontSize: AppSize.font14,
          text: 'Shipped',
        ),
        content: const SizedBox.shrink(),
        isActive: order.status == 'SHIPPED',
      ),
      Step(
        title: CustomText(
          textStyle: TextStyles.regularText,
          fontSize: AppSize.font14,
          text: 'Delivered',
        ),
        content: const SizedBox.shrink(),
        isActive: order.status == 'DELIVERED',
      ),
      Step(
        title: CustomText(
          textStyle: TextStyles.regularText,
          fontSize: AppSize.font14,
          text: 'Cancelled',
        ),
        content: const SizedBox.shrink(),
        isActive: order.status == 'CANCELLED',
      ),
    ];
  }

  Widget _cancelAndHelpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        // Container(
        //   height: Get.size.height*0.04,
        //   width: Get.size.width*0.2,
        //   decoration: BoxDecoration(
        //    border: Border.all( color: Colors.red,),
        //     borderRadius: BorderRadius.all(Radius.circular(6))
        //   ),
        //   child: Center(
        //     child: CustomText(text:AppStrings.cancel,textStyle: TextStyles.regularText,
        //       fontSize: AppSize.font14,color: Colors.red,),
        //   ),
        // ),
        InkWell(
          onTap: () {
            launchUrl(Uri.parse(
                "https://wa.link/fx1qa0")); // Assuming you're launching a URL
          },
          child: Container(
            height: Get.size.height * 0.04,
            width: Get.size.width * 0.25,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: Center(
              child: CustomText(
                text: AppStrings.needHelp,
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    ).paddingOnly(left: 20, top: 10, right: 20);
  }
}
