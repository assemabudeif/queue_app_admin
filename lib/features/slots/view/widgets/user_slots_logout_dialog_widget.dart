import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/core/utilities/font_manger.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dialog_button_widget.dart';
import 'user_slots_dialog_header_widget.dart';

class UserSlotsLogoutDialogWidget extends StatelessWidget {
  const UserSlotsLogoutDialogWidget({
    super.key,
    required this.logoutOPressed,
  });

  final Function logoutOPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      child: SizedBox(
        width: 100.w,
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserSlotsDialogHeaderWidget(
              title: AppStrings.logout.tr,
            ),
            const Divider(
              color: kBorderColor,
              thickness: 0.5,
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: Center(
                child: Text(
                  AppStrings.logoutMessage.tr,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: kFontWeightSemiBold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 2.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DialogButtonWidget(
                    text: AppStrings.no.tr,
                    onPressed: () {
                      Get.back();
                    },
                    color: kWhiteColor,
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  DialogButtonWidget(
                    text: AppStrings.yes.tr,
                    onPressed: () {
                      logoutOPressed();
                    },
                    color: kPrimaryColor,
                    width: 15.w,
                    haveBorder: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
