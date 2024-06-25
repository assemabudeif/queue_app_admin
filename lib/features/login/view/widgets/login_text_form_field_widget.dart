import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginTextFormFieldWidget extends StatelessWidget {
  const LoginTextFormFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.validatorText,
    this.isPassword = false,
  });

  final String title;
  final TextEditingController controller;
  final bool isPassword;
  final String validatorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium!.copyWith(
            fontWeight: kFontWeightSemiBold,
          ),
        ),
        SizedBox(
          height: 7.5.h,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.w),
              side: const BorderSide(
                color: kBorderColor,
                width: 1,
              ),
            ),
            child: TextFormField(
              controller: controller,
              obscureText: isPassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return validatorText;
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
