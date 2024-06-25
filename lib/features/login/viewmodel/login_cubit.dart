import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:queue_app_admin/core/constants/app_constance.dart';
import '/core/data/requests/login_request.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/features/base/base_cubit.dart';
import '/features/login/model/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with BaseCubit {
  LoginCubit(this._loginRepository) : super(LoginInitial());

  final LoginRepository _loginRepository;

  final formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Future<void> init() async {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      final LoginRequest request = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );
      final result = await _loginRepository.login(request);
      result.fold(
        (failure) {
          AppSnackBars.showErrorSnackBar(
            message: failure.message,
            title: AppStrings.error.tr,
          );
          emit(LoginError());
        },
        (success) {
          if (success.authentication == 1) {
            _savePrefs(
              authentication: success.authentication,
              footId: success.footId,
            );
          } else {
            AppSnackBars.showErrorSnackBar(
              message: AppStrings.authenticationFailedPleaseTryAgain.tr,
              title: AppStrings.error.tr,
            );
          }
          emit(LoginSuccess());
        },
      );
    }
  }

  _savePrefs({
    required int authentication,
    required int footId,
  }) {
    // Save user data to shared preferences
    sl<AppPreferences>().setIsLogin(authentication);
    sl<AppPreferences>().setFootId(footId);
    sl<AppPreferences>().setUserName(usernameController.text);

    kAuthentication = authentication;
    kFootId = footId;
    kUserName = usernameController.text;

    Get.offAllNamed(AppRoutes.slotsPath);
  }
}
