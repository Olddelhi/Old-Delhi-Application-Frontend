import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/app_buttons.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/components/text_styles.dart';
import 'package:old_delhi_food/app/ui/maually_detail/maually_detail_controller.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';

class ManuallyDetailScreen extends GetView<ManuallyDetailController> {
  ManuallyDetailScreen({super.key});

  @override
  final controller = Get.put(ManuallyDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(),
              CustomText(
                text: AppStrings.enterYourInfo,
                textStyle: TextStyles.regularText,
                fontSize: AppSize.font12,
              ).paddingSymmetric(vertical: AppSize.height20),
              _formWidget(),
            ],
          ).paddingSymmetric(horizontal: AppSize.width10),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.arrow_back),
        Expanded(
          child: Center(
            child: CustomText(
              text: AppStrings.manuallyDetail,
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _formWidget() {
    return Obx(
      () => Form(
        key: controller.formKey.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSize.width200,
              child: TextFormField(
                controller: controller.pinCodeTextController.value,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  hintText: 'Pincode (Required)*',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ).paddingSymmetric(vertical: AppSize.height8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: AppSize.width150,
                  child: TextFormField(
                    controller: controller.stateTextController.value,
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                      hintText: 'state (Required)*',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ).paddingSymmetric(vertical: AppSize.height8),
                ),
                SizedBox(
                  width: AppSize.width170,
                  child: TextFormField(
                    controller: controller.cityTextController.value,
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'City (Required)*',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ).paddingSymmetric(vertical: AppSize.height8),
                ),
              ],
            ),
            TextFormField(
              controller: controller.houseNoTextController.value,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                hintText: 'House No, Building Name (Required)*',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ).paddingSymmetric(vertical: AppSize.height8),
            TextFormField(
              controller: controller.roadNameTextController.value,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Road Name, Area Colony (Required)*',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ).paddingSymmetric(vertical: AppSize.height8),
            TextFormField(
              controller: controller.nearByTextController.value,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                labelText: '+Add Neaby Famouse Shop/Mall/Landmark',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ).paddingSymmetric(vertical: AppSize.height8),
            Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ))
                  : AppButton(
                          onTap: () {
                            controller.validateForm();
                          },
                          text: AppStrings.save)
                      .paddingSymmetric(
                          vertical: AppSize.height30,
                          horizontal: AppSize.width40),
            )
          ],
        ),
      ),
    );
  }
}
