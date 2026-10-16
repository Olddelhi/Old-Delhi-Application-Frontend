import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/components/text_styles.dart';
import 'package:old_delhi_food/app/utils/app_strings.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class AppTextFormField extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final IconData? icon;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? isLabel;
  final bool? isPrefixIcon;
  final bool? isPassword;
  final bool? showIcon;
  final bool? isVerifyText;
  final VoidCallback? show;
  final bool? obscureText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  const AppTextFormField({
    Key? key,
    this.onSaved,
    this.controller,
    this.show,
    this.validator,
    this.hintText = "",
    this.labelText = "",
    this.prefixText,
    this.maxLength,
    this.maxLines,
    this.icon,
    this.isPassword,
    this.keyboardType,
    this.showIcon = false,
    this.isPrefixIcon = false,
    this.enabled = true,
    this.obscureText = false,
    this.isVerifyText = false,
    this.isLabel = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabel == true
            ? CustomText(
                text: labelText!,
                textStyle: TextStyles.regularText,
                color: Colors.black54,
                fontSize: AppSize.font12,
              )
            : const SizedBox(),
        Container(
          height: AppSize.height50,
          decoration: BoxDecoration(
              color: AppColors.textFormColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSize.radius10))),
          padding: EdgeInsets.all(AppSize.height5),
          child: TextFormField(
            maxLines: maxLines ?? 1,
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyles.regularText,
              errorStyle: TextStyles.mediumText,
              prefixIconColor: Colors.black45,
              errorMaxLines: 1,
              prefixIcon:
                  isPrefixIcon == true ? const Icon(Icons.search) : null,
              suffixIcon: isVerifyText == true
                  ? CustomText(
                      text: AppStrings.verify.toUpperCase(),
                      textStyle: TextStyles.mediumText,
                      fontSize: AppSize.font12,
                      color: Colors.black,
                    ).paddingOnly(top: AppSize.height16)
                  : obscureText == true
                      ? GestureDetector(
                          onTap: show,
                          child: Icon(
                            showIcon == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )
                      : const SizedBox(),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0, // Adjust the vertical padding as needed
                horizontal: 12.0, // Adjust the horizontal padding as needed
              ),
              border: InputBorder.none,
            ),
//        textAlign: TextAlign.center,
            inputFormatters: (maxLength != null)
                ? obscureText!
                    ? [
                        LengthLimitingTextInputFormatter(maxLength),
                        // WhitelistingTextInputFormatter(RegExp("[0-9]"))
                      ]
                    : [LengthLimitingTextInputFormatter(maxLength)]
                : [],
            onSaved: onSaved,
            onFieldSubmitted: onFieldSubmitted,
            validator: validator,
            keyboardType: keyboardType,
            enabled: enabled,
            textInputAction: textInputAction,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyles.mediumText,
            obscureText: (!showIcon!),
          ),
        ).paddingOnly(top: AppSize.height10),
      ],
    );
  }
}
