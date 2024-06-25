import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '/core/utilities/app_routes.dart';

import '/core/services/app_prefs.dart';
import '/core/services/services_locator.dart';
import '../../../../core/constants/app_constance.dart';
import 'sliding_logo.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slidingAnimation;

  @override
  initState() {
    super.initState();
    _initAnimationControllers();

    _initAppPrefs();

    _navigateToNext();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlidingLogo(slidingAnimation: _slidingAnimation),
    );
  }

  void _navigateToNext() {
    Future.delayed(
      kSplashDuration,
      () {
        if (kAuthentication == 0) {
          Get.offNamed(AppRoutes.loginPath);
        } else {
          Get.offNamed(AppRoutes.slotsPath);
        }
      },
    );
  }

  Future<void> _initAppPrefs() async {
    await sl<AppPreferences>().init();
  }

  void _initAnimationControllers() {
    _animationController = AnimationController(
      vsync: this,
      duration: kSplashAnimationDuration,
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();
  }
}
