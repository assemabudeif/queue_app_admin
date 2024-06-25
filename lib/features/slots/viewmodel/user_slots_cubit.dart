import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import '/core/global/widgets/app_snackbars.dart';
import '/core/localization/app_strings.dart';
import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '/core/utilities/app_routes.dart';
import '/features/base/base_cubit.dart';
import '/features/slots/model/models/user_slots_model.dart';
import '/features/slots/model/repository/user_slots_repository.dart';
import '/features/slots/view/widgets/user_slots_logout_dialog_widget.dart';

part 'user_slots_state.dart';

class UserSlotsCubit extends Cubit<UserSlotsState> with BaseCubit {
  UserSlotsCubit(this._userSlotsRepository) : super(UserSlotsInitial());

  final UserSlotsRepository _userSlotsRepository;

  UserSlotsModel? userSlotsModel;
  String error = '';

  @override
  Future<void> init() async {
    await getUserSlots();
  }

  @override
  void dispose() {}

  void refresh() {
    userSlotsModel = null;
    error = '';
    getUserSlots();
  }

  Future<void> getUserSlots() async {
    emit(GetUserSlotsLoading());
    final result = await _userSlotsRepository.getUserSlots();
    result.fold(
      (failure) {
        error = failure.toString();
        emit(GetUserSlotsError());
      },
      (data) {
        userSlotsModel = data;
        emit(GetUserSlotsLoaded());
      },
    );
  }

  Future<void> _logout() async {
    emit(LogoutLoading());
    final result = await _userSlotsRepository.logout();
    result.fold(
      (failure) {
        AppSnackBars.showErrorSnackBar(
          message: failure.toString(),
          title: AppStrings.error.tr,
        );
        userSlotsModel = const UserSlotsModel(data: []);
        emit(LogoutError());
      },
      (data) {
        _removePrefs();
        emit(LogoutLoaded());
      },
    );
  }

  logoutDialog() {
    Get.dialog(
      UserSlotsLogoutDialogWidget(
        logoutOPressed: () {
          _logout();
        },
      ),
    );
  }

  _removePrefs() async {
    await sl<AppPreferences>().removeFootId();
    await sl<AppPreferences>().removeUserName();
    await sl<AppPreferences>().removeIsLogin();

    Get.offAllNamed(AppRoutes.loginPath);
  }
}
