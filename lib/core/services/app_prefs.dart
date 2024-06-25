import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constance.dart';
import 'services_locator.dart';

enum SharedKey {
  authentication,
  language,
  footId,
  userName,
}

class AppPreferences {
  final _sharedPreferences = sl<SharedPreferences>();
  Future<void> init() async {
    kAppLanguageCode = getAppLanguageCode();
    kAuthentication = getIsLogin();
    kFootId = getFootId();
    kUserName = getUserName();

    await Future.delayed(const Duration(seconds: 1), () {
      log(kAppLanguageCode, name: 'Language Code');
      log(kAuthentication.toString(), name: 'Is Login');
      log(kFootId.toString(), name: 'Foot Id');
      log(kUserName.toString(), name: 'User Name');
    });
  }

  /// Save is Login to the shared preferences
  Future<void> setIsLogin(int authentication) async {
    await _sharedPreferences.setInt(
      SharedKey.authentication.toString(),
      authentication,
    );
  }

  /// Get is Login from the shared preferences
  int getIsLogin() {
    return _sharedPreferences.getInt(SharedKey.authentication.toString()) ?? 0;
  }

  /// Remove is Login from the shared preferences
  Future<void> removeIsLogin() async {
    await _sharedPreferences.remove(SharedKey.authentication.toString());
  }

  /// Save the SessionId to the shared preferences
  Future<void> setAppLanguageCode(String languageCode) async {
    await _sharedPreferences.setString(
      SharedKey.language.toString(),
      languageCode,
    );
  }

  /// Get the SessionId from the shared preferences
  String getAppLanguageCode() {
    return _sharedPreferences.getString(SharedKey.language.toString()) ?? 'en';
  }

  /// Remove the SessionId from the shared preferences
  Future<void> removeLanguageCode() async {
    await _sharedPreferences.remove(SharedKey.language.toString());
  }

  /// Save the footID to the shared preferences
  Future<void> setFootId(int footId) async {
    await _sharedPreferences.setInt(
      SharedKey.footId.toString(),
      footId,
    );
  }

  /// Get the footID from the shared preferences
  ///
  /// If the footID is not found, it will return 0
  int getFootId() {
    return _sharedPreferences.getInt(SharedKey.footId.toString()) ?? 0;
  }

  /// Remove the footID from the shared preferences
  Future<void> removeFootId() async {
    await _sharedPreferences.remove(SharedKey.footId.toString());
  }

  /// Save the User Name to the shared preferences
  Future<void> setUserName(String userName) async {
    await _sharedPreferences.setString(
      SharedKey.userName.toString(),
      userName,
    );
  }

  /// Get the User Name from the shared preferences
  ///
  /// If the User Name is not found, it will return 0
  String getUserName() {
    return _sharedPreferences.getString(SharedKey.userName.toString()) ?? '';
  }

  /// Remove the User Name from the shared preferences
  Future<void> removeUserName() async {
    await _sharedPreferences.remove(SharedKey.userName.toString());
  }

  /// Clear all the shared preferences
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
