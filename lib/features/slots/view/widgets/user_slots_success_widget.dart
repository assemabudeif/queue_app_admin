import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/global/widgets/custom_app_button_widget.dart';
import '/core/global/widgets/custom_body_widget.dart';
import '/core/localization/app_strings.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/app_routes.dart';
import '/core/utilities/font_manger.dart';
import '/features/slots/model/models/user_slots_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserSlotsSuccessWidget extends StatefulWidget {
  const UserSlotsSuccessWidget({
    super.key,
    required this.userSlotsModel,
  });
  final UserSlotsModel userSlotsModel;

  @override
  State<UserSlotsSuccessWidget> createState() => _UserSlotsSuccessWidgetState();
}

class _UserSlotsSuccessWidgetState extends State<UserSlotsSuccessWidget> {
  UserSlotsDataModel? _selectedWindow;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.queueStaff.tr,
          style: context.textTheme.titleLarge!.copyWith(
            color: kTextColor,
            fontWeight: kFontWeightSemiBold,
            fontSize: 28.sp,
            fontFamily: kSFProRoundedFontFamily,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5.h,
        ),
        Expanded(
          child: CustomBodyWidget(
            child: widget.userSlotsModel.data.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 5.h,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 5.h,
                          ),
                          child: Text(
                            widget.userSlotsModel.data.isNotEmpty
                                ? widget.userSlotsModel.data[0].orgName
                                : '',
                            style: context.textTheme.titleLarge!.copyWith(
                              color: kTextColor,
                              fontWeight: kFontWeightSemiBold,
                              fontFamily: kSFProRoundedFontFamily,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          widget.userSlotsModel.data.isNotEmpty
                              ? widget.userSlotsModel.data[0].depName
                              : '',
                          style: context.textTheme.titleLarge!.copyWith(
                            color: kTextColor,
                            fontWeight: kFontWeightMedium,
                            fontSize: 20.sp,
                            fontFamily: kSFProRoundedFontFamily,
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 8.h,
                          child: Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            color: kPrimaryColor,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                              ),
                              child: DropdownButton<UserSlotsDataModel>(
                                items: widget.userSlotsModel.data.map(
                                  (e) {
                                    return DropdownMenuItem<UserSlotsDataModel>(
                                      value: e,
                                      child: Text(
                                        e.slotName,
                                        style: context.textTheme.titleMedium!
                                            .copyWith(
                                          fontWeight: kFontWeightSemiBold,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                isExpanded: true,
                                dropdownColor: kWhiteColor,
                                icon: Icon(
                                  CupertinoIcons.chevron_down,
                                  color: kTextColor,
                                  size: 18.sp,
                                ),
                                borderRadius: BorderRadius.circular(2.w),
                                underline: Container(),
                                elevation: 5,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedWindow = value;
                                  });
                                },
                                hint: Text(AppStrings.selectWindow.tr),
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: kCardTextColor,
                                  fontWeight: kFontWeightSemiBold,
                                ),
                                value: _selectedWindow,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomAppButtonWidget(
                          onPressed: () {
                            if (_selectedWindow != null) {
                              Get.toNamed(
                                AppRoutes.tokensPath,
                                arguments: _selectedWindow,
                              );
                            } else {
                              AppSnackBars.showErrorSnackBar(
                                message: AppStrings.selectWindow.tr,
                                title: AppStrings.error.tr,
                              );
                            }
                          },
                          buttonColor: kOtpButtonColor,
                          textColor: kWhiteColor,
                          text: AppStrings.submit.tr,
                          borderRadius: 2.w,
                        )
                      ],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: Text(
                      AppStrings.noSlotsFoundTryAgain.tr,
                      style: context.textTheme.titleLarge!.copyWith(
                        color: kTextColor.withOpacity(0.5),
                        fontWeight: kFontWeightMedium,
                      ),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
