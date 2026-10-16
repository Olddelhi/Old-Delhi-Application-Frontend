import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/app_buttons.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../responses/get_address_response.dart';
import '../../utils/app_size.dart';
import 'my_addresses_controller.dart';

class EditAddressForm extends StatelessWidget {
  final Address address;
  final String addressId;
  final MyAddressesController myController = Get.find();

  EditAddressForm({super.key, required this.address, required this.addressId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: address.name);
    final TextEditingController phoneController =
        TextEditingController(text: address.mobile);
    final TextEditingController pincodeIdController =
        TextEditingController(text: address.pincode?.pincode);
    final TextEditingController localityController =
        TextEditingController(text: address.locality);
    final TextEditingController addressController =
        TextEditingController(text: address.address);
    final TextEditingController cityController =
        TextEditingController(text: address.city);
    final TextEditingController landmarkController =
        TextEditingController(text: address.landmark);
    final TextEditingController stateController =
        TextEditingController(text: address.state);
    final TextEditingController alternatePhoneController =
        TextEditingController(text: address.alternatePhone);

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
                        SizedBox(
                          width: AppSize.width150,
                          child: TextFormField(
                            controller: nameController,
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
                        SizedBox(
                          width: AppSize.width200,
                          child: TextFormField(
                            controller: pincodeIdController,
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
                        SizedBox(
                          width: AppSize.width200,
                          child: TextFormField(
                            controller: phoneController,
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
                                controller: stateController,
                                style: const TextStyle(color: Colors.black87),
                                decoration: const InputDecoration(
                                  hintText: 'state (Required)*',
                                  labelText: 'state (Required)*',
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
                                controller: cityController,
                                style: const TextStyle(color: Colors.black87),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.search),
                                  hintText: 'city (Required)*',
                                  labelText: 'city (Required)*',
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
                          controller: addressController,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            hintText: 'address *',
                            labelText: 'address *',
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
                          controller: localityController,
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
                          controller: landmarkController,
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
                          controller: alternatePhoneController,
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
                  () => myController.isEditLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ))
                      : AppButton(
                              onTap: () {
                                if (myController.formKey.value.currentState!
                                    .validate()) {
                                  myController.isEditLoading.value = true;
                                  myController.editAddress(
                                      addressId,
                                      nameController.text,
                                      phoneController.text,
                                      pincodeIdController.text,
                                      localityController.text,
                                      addressController.text,
                                      cityController.text,
                                      landmarkController.text,
                                      stateController.text,
                                      alternatePhoneController.text,
                                      context);
                                }
                              },
                              text: 'Update')
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
              text: 'Edit Address',
              textStyle: TextStyles.regularText,
              fontSize: AppSize.font16,
            ),
          ),
        ),
      ],
    );
  }
}
