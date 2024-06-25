import 'package:flutter/material.dart';
import '/core/theme/app_colors_light.dart';

import 'widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhiteColor,
      body: SplashViewBody(),
    );
  }
}
