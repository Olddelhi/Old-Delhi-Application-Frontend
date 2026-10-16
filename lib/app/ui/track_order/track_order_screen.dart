import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/track_order/track_order_controller.dart';
import 'package:old_delhi_food/app/utils/app_colors.dart';

import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';
import '../../utils/app_strings.dart';

class TrackOrderScreen extends GetView<TrackOrderController> {
  @override
  TrackOrderController controller = TrackOrderController();

  TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textFormColor,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            Align(
                alignment: Alignment.center,
                child: Image.asset(AppAssets.trackOrderImage)
                    .paddingOnly(top: AppSize.height25))
          ],
        ).paddingSymmetric(horizontal: AppSize.width20),
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
              AppAssets.blackBackIcon,
              height: AppSize.height35,
              width: AppSize.width40,
              fit: BoxFit.fill,
            )),
        Expanded(
          child: CustomText(
            text: AppStrings.trackOrder,
            textStyle: TextStyles.regularText,
            fontSize: AppSize.font18,
          ).paddingSymmetric(
              horizontal: AppSize.width15, vertical: AppSize.height5),
        ),
      ],
    );
  }
}
