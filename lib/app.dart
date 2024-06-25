
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/localization/app_translations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/localization/language_manger.dart';
import 'core/theme/theme_data/theme_data_light.dart';
import 'core/constants/app_constance.dart';
import 'core/utilities/app_routes.dart';

class QueueAppAdmin extends StatelessWidget {
  const QueueAppAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: kAppName,
          theme: getThemeDataLight,
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          getPages: appRoutes,
          initialRoute: AppRoutes.splashPath,
          themeMode: ThemeMode.light,
          locale: Locale(getAppLanguageCode),
          fallbackLocale: kDefaultLocale,
          defaultTransition: kDefaultRouteTransition,
          transitionDuration: kDefaultTransitionDuration,
        );
      },
    );
  }
}
