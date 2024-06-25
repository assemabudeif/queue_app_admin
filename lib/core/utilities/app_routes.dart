import 'dart:developer';

import 'package:get/get.dart';
import '/features/login/view/login_view.dart';
import '/features/slots/model/models/user_slots_model.dart';
import '/features/slots/view/slots_view.dart';
import '/features/splash/views/splash_view.dart';
import '/features/tokens/view/tokens_view.dart';

import '/core/localization/app_strings.dart';

/// Routes names
class AppRoutes {
  static const String splashPath = '/';
  static const String loginPath = '/login';
  static const String tokensPath = '/tokens';
  static const String slotsPath = '/slots';
}

/// App Routes
List<GetPage<dynamic>> get appRoutes => [
      // Splash Screen
      GetPage(
        name: AppRoutes.splashPath,
        page: () => const SplashView(),
      ),

      // Login Screen
      GetPage(
        name: AppRoutes.loginPath,
        page: () => const LoginView(),
      ),

      // Home Layout Screen
      GetPage(
        name: AppRoutes.tokensPath,
        page: () => TokensView(
          userSlotsModel: Get.arguments as UserSlotsDataModel,
        ),
      ),

      // Slots Screen
      GetPage(
        name: AppRoutes.slotsPath,
        page: () => const SlotsView(),
      ),
    ];

/// Middleware to log the page name
class MyMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    log(page?.name.toString() ?? AppStrings.invalidPageName.tr);
    return super.onPageCalled(page);
  }
}
