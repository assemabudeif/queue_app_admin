import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_app_bar.dart';
import '/core/global/widgets/custom_body_widget.dart';
import '/core/localization/app_strings.dart';
import '/core/services/services_locator.dart';
import '/core/theme/app_colors_light.dart';
import '/core/utilities/font_manger.dart';
import '/core/global/widgets/custom_app_button_widget.dart';
import '/features/login/viewmodel/login_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/login_text_form_field_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginCubit _vm = sl<LoginCubit>();

  @override
  void initState() {
    _vm.init();
    super.initState();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => _vm,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
                child: Text(
                  AppStrings.queueStaff.tr,
                  style: context.textTheme.titleLarge!.copyWith(
                    color: kTextColor,
                    fontWeight: kFontWeightSemiBold,
                    fontSize: 28.sp,
                    fontFamily: kSFProRoundedFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomBodyWidget(
                height: 70.h,
                child: Form(
                  key: _vm.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginTextFormFieldWidget(
                        title: AppStrings.username.tr,
                        controller: _vm.usernameController,
                        validatorText: AppStrings.usernameRequired.tr,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      LoginTextFormFieldWidget(
                        title: AppStrings.password.tr,
                        controller: _vm.passwordController,
                        validatorText: AppStrings.passwordRequired.tr,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomAppButtonWidget(
                        onPressed: () {
                          return _vm.login();
                        },
                        text: AppStrings.login.tr,
                        textColor: kTextColor,
                        buttonColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
