import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppButtonWidget extends StatelessWidget {
  const CustomAppButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
    required this.text,
    this.borderRadius,
  });

  final Function onPressed;
  final Color buttonColor;
  final Color textColor;
  final String text;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: EasyButton(
        onPressed: () {
          return onPressed();
        },
        loadingStateWidget: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kOtpButtonColor),
        ),
        useEqualLoadingStateWidgetDimension: true,
        width: 100.w,
        borderRadius: borderRadius ?? 5.w,
        useWidthAnimation: true,
        buttonColor: buttonColor,
        type: EasyButtonType.elevated,
        elevation: 8,
        height: 7.5.h,
        idleStateWidget: Text(
          text,
          style: context.textTheme.titleMedium!.copyWith(
            color: textColor,
            fontWeight: kFontWeightSemiBold,
          ),
        ),
      ),
    );
  }
}
