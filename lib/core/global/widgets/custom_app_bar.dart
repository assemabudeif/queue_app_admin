import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '/core/localization/app_strings.dart';
import '/core/localization/language_manger.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.haveLogout = false,
    this.logoutOnPressed,
    this.refreshOPressed,
  });

  final bool haveLogout;
  final Function? logoutOnPressed;
  final Function? refreshOPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 0,
      title: refreshOPressed != null
          ? IconButton(
              icon: Icon(
                Icons.refresh,
                color: kOtpButtonColor,
                size: 20.sp,
              ),
              onPressed: () {
                refreshOPressed!();
              },
            )
          : null,
      leading: haveLogout && logoutOnPressed != null
          ? IconButton(
              icon: Icon(
                Icons.logout,
                color: kOtpButtonColor,
                size: 20.sp,
              ),
              onPressed: () {
                logoutOnPressed!();
              },
            )
          : null,
      actions: [
        TextButton(
          onPressed: () {
            changeAppLanguage(context);
          },
          child: Text(
            AppStrings.changeLanguage.tr,
            style: context.textTheme.titleMedium!.copyWith(
              color: kTextButtonColor,
              fontWeight: kFontWeightSemiBold,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(5.h);
}
