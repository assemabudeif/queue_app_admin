import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TokensButtonWidget extends StatelessWidget {
  const TokensButtonWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onPressed,
    this.color = kPrimaryColor,
  });

  final String text;
  final String image;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 35.w,
      child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
            side: const BorderSide(
              color: kBlackColor,
              width: 1.5,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          color: color,
          elevation: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: kFontWeightSemiBold,
                  fontSize: 20.sp,
                  height: 1.2,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1.h,
              ),
              Image.asset(
                image,
                width: 11.w,
              ),
            ],
          )),
    );
  }
}
