import 'package:flutter/material.dart';
import 'package:old_delhi_food/app/components/cutom_text.dart';
import 'package:old_delhi_food/app/components/text_styles.dart';
import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class AppButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? text;
  final String? image;
  var prefixIcon;
  final bool? isIcon;
  final bool? isPrefixIcon;
  final Color? color;
  final Color? textColor;
  final BorderRadius? borderRadius = BorderRadius.all(
    Radius.circular(AppSize.radius10),
  );

  final bool enabled;

  AppButton({
    super.key,
    @required this.onTap,
    @required this.text,
    this.image,
    this.prefixIcon,
    this.color,
    this.textColor,
    this.isIcon = false,
    this.isPrefixIcon = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: enabled ? onTap : () {},
      child: Container(
        height: AppSize.height40,
        padding: EdgeInsets.all(AppSize.height10),
        decoration: BoxDecoration(
          color: color ?? (enabled ? AppColors.primary : Colors.grey),
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isPrefixIcon == true
                ? Icon(
                    Icons.favorite_border,
                    size: AppSize.height15,
                  )
                : const SizedBox(),
            CustomText(
              text: text!,
              color: textColor ?? Colors.white,
              fontSize: AppSize.height12,
              textStyle: TextStyles.mediumText,
            ),
            isIcon == true
                ? Image.asset(
                    image!,
                    height: AppSize.height25,
                    width: AppSize.width40,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
