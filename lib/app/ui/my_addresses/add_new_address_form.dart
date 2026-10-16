import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/app_buttons.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_size.dart';
import 'my_addresses_controller.dart';

class NewAddressForm extends StatelessWidget {
  final MyAddressesController myController = Get.find();

  NewAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _appBar(),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Form(
                    key: myController.formKey.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: TextFormField(
                            controller: myController.nameController.value,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              hintText: 'Name*',
                              labelText: 'Name*',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black87)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ).paddingSymmetric(vertical: AppSize.height8),
                        ),
                        Container(
                          child: TextFormField(
                            controller: myController.pincodeController.value,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              hintText: 'Pincode (Required)*',
                              labelText: 'Pincode (Required)*',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black87)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ).paddingSymmetric(vertical: AppSize.height8),
                        ),
                        Container(
                          child: TextFormField(
                            controller: myController.phoneController.value,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black87),
                            decoration: const InputDecoration(
                              hintText: 'Phone (Required)*',
                              labelText: 'Phone Number (Required)*',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black87)),
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
                                controller: myController.stateController.value,
                                style: const TextStyle(color: Colors.black87),
                                decoration: const InputDecoration(
                                  hintText: 'State (Required)*',
                                  labelText: 'State (Required)*',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black87)),
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
                                controller: myController.cityController.value,
                                style: const TextStyle(color: Colors.black87),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.search),
                                  hintText: 'City (Required)*',
                                  labelText: 'City (Required)*',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black87)),
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
                          controller: myController.addressController.value,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            hintText: 'Address *',
                            labelText: 'Address *',
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
                          controller: myController.localityController.value,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            hintText: 'locality *',
                            labelText: 'Locality *',
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
                          controller: myController.landmarkController.value,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintText: 'Landmark*',
                            labelText: 'Landmark*',
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
                          controller:
                              myController.alternatePhoneController.value,
                          style: const TextStyle(color: Colors.black87),
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Alternate number',
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

                        // Obx(()=>
                        // controller.isLoading.value?Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red), )): AppButton(onTap: (){
                        //   controller.validateForm();
                        // }, text: AppStrings.save).paddingSymmetric(vertical: AppSize.height30,
                        //     horizontal: AppSize.width40),
                        // )
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => myController.isAddLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ))
                      : AppButton(
                              onTap: () {
                                if (myController.formKey.value.currentState!
                                    .validate()) {
                                  myController.isAddLoading.value = true;
                                  myController.fetchPincodeData();
                                }
                              },
                              text: 'Add')
                          .paddingSymmetric(
                              vertical: AppSize.height30,
                              horizontal: AppSize.width40),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        Expanded(
          child: Center(
            child: CustomText(
              text: 'Add Address',
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font16,
            ),
          ),
        ),
      ],
    );
  }
}
