import '/core/constants/app_constance.dart';

class ApiConstance {
  static String baseUrl =
      //  'https://c32d-196-150-161-204.ngrok-free.app';
      "https://kernel-code.site/qapp";

  /// Login
  static String login = "/userslogin";
  static String logout = "/userslogout/$kFootId";

  /// All Slots
  static String getUserSlots = "/getalluserslots";

  /// Home
  static String getCurrentToken({
    required int depId,
    required int slotId,
  }) =>
      "/current_token/$depId/$slotId";

  static String cancelToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  }) =>
      "/slot_cancel/$depId/$slotId/$tokenNumber/$kFootId";

  static String nextToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  }) =>
      "/slot_next/$depId/$slotId/$tokenNumber/$kFootId";
}
