import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lcd_led/lcd_led.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/localization/app_strings.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/assets_data.dart';
import '/core/utilities/font_manger.dart';
import '/features/slots/model/models/user_slots_model.dart';
import '/features/tokens/viewmodel/tokens_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/tokens_button_widget.dart';

class TokensView extends StatefulWidget {
  const TokensView({
    super.key,
    required this.userSlotsModel,
  });

  final UserSlotsDataModel userSlotsModel;

  @override
  State<TokensView> createState() => _TokensViewState();
}

class _TokensViewState extends State<TokensView> {
  final _cubit = sl<TokensCubit>();

  @override
  void initState() {
    _cubit.getCurrentToken(
      depId: widget.userSlotsModel.deptId,
      slotId: widget.userSlotsModel.slotId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TokensCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Text(
                widget.userSlotsModel.slotName,
                style: context.textTheme.titleLarge!.copyWith(
                  color: kTextColor,
                  fontWeight: kFontWeightSemiBold,
                  fontSize: 28.sp,
                  fontFamily: kSFProRoundedFontFamily,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kShadowColor.withOpacity(0.3),
                        offset: const Offset(0, -1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 3.h,
                    ),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                _cubit.getCurrentToken(
                                  depId: widget.userSlotsModel.deptId,
                                  slotId: widget.userSlotsModel.slotId,
                                );
                              },
                              child: const Icon(
                                Icons.refresh,
                                color: kTextColor,
                                size: 30,
                              ),
                            )),
                        Text(
                          AppStrings.currentToken.tr,
                          style: context.textTheme.titleLarge!.copyWith(
                            fontWeight: kFontWeightSemiBold,
                            color: kTextColor,
                            fontSize: 23.sp,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        BlocBuilder<TokensCubit, TokensState>(
                          bloc: _cubit,
                          builder: (context, state) {
                            return Container(
                              height: 30.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: kBlackColor,
                                border: Border.all(
                                  color: kScreenBorderColor,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 6.h,
                                horizontal: 6.w,
                              ),
                              child: Center(
                                child: state is GetTokenLoadingState
                                    ? Center(
                                        child: SizedBox(
                                          height: 5.h,
                                          width: 5.h,
                                          child:
                                              const CircularProgressIndicator(
                                            color: kLEDColor,
                                          ),
                                        ),
                                      )
                                    : state is GetTokenSuccessState
                                        ? LedDigits(
                                            numberOfLeds: 4,
                                            backgroundColor: kBlackColor,
                                            onColor: kLEDColor,
                                            string: _buildLcdNumber(
                                                state.token.toString()),
                                          )
                                        : state is GetTokenErrorState
                                            ? Center(
                                                child: Text(
                                                  state.error,
                                                  style: context
                                                      .textTheme.titleLarge!
                                                      .copyWith(
                                                    color: kLEDColor,
                                                    fontWeight:
                                                        kFontWeightSemiBold,
                                                    fontSize: 20.sp,
                                                  ),
                                                ),
                                              )
                                            : const LedDigits(
                                                numberOfLeds: 4,
                                                backgroundColor: kBlackColor,
                                                onColor: kLEDColor,
                                                string: '0000',
                                              ),
                              ),
                            );
                          },
                        ),
                        Image.asset(
                          AssetsData.screenImage,
                          height: 7.h,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: BlocBuilder<TokensCubit, TokensState>(
                            bloc: _cubit,
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TokensButtonWidget(
                                    onPressed: () {
                                      if (state is GetTokenSuccessState) {
                                        if (state.token != 0) {
                                          _cubit.cancelToken(
                                            depId: widget.userSlotsModel.deptId,
                                            slotId:
                                                widget.userSlotsModel.slotId,
                                            tokenNumber: state.token.toString(),
                                          );
                                        } else {
                                          AppSnackBars.showAlertSnackBar(
                                            message: AppStrings.noMoreToken.tr,
                                          );
                                        }
                                      }
                                    },
                                    text: AppStrings.cancelToken.tr,
                                    image: AssetsData.cancelImage,
                                    color: kWhiteColor,
                                  ),
                                  TokensButtonWidget(
                                    onPressed: () {
                                      if (state is GetTokenSuccessState) {
                                        if (state.token != 0) {
                                          _cubit.getNextToken(
                                            depId: widget.userSlotsModel.deptId,
                                            slotId:
                                                widget.userSlotsModel.slotId,
                                            tokenNumber: state.token.toString(),
                                          );
                                        } else {
                                          AppSnackBars.showAlertSnackBar(
                                            message: AppStrings.noMoreToken.tr,
                                          );
                                        }
                                      }
                                    },
                                    text: AppStrings.nextToken.tr,
                                    image: AssetsData.nextImage,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildLcdNumber(String number) {
    List<int> list1 = [0, 0, 0, 0];
    var numbers = number.split('').toList();
    String result = '';
    int length = 3;
    for (int i = length; i >= 0; i--) {
      if (numbers.isNotEmpty) {
        list1[i] += int.parse(numbers.last);
        numbers.removeLast();
      }
    }
    for (var element in list1) {
      result += element.toString();
    }
    return result;
  }
}
