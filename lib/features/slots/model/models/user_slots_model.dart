import 'package:equatable/equatable.dart';
import '/core/localization/language_manger.dart';

class UserSlotsModel extends Equatable {
  final List<UserSlotsDataModel> data;

  const UserSlotsModel({
    required this.data,
  });

  factory UserSlotsModel.fromJson(List<dynamic> json) {
    return UserSlotsModel(
      data: List<UserSlotsDataModel>.from(
        json.map(
          (x) => UserSlotsDataModel.fromJson(x),
        ),
      ),
    );
  }

  @override
  List<Object> get props => [
        data,
      ];
}

class UserSlotsDataModel extends Equatable {
  final int slotId;
  final int deptId;
  final String slotName;
  final String orgName;
  final String depName;

  const UserSlotsDataModel({
    required this.slotId,
    required this.slotName,
    required this.deptId,
    required this.orgName,
    required this.depName,
  });

  factory UserSlotsDataModel.fromJson(Map<String, dynamic> json) {
    return UserSlotsDataModel(
      slotId: json['slotId'] ?? 0,
      slotName: getAppLanguageCode == 'ar'
          ? json['slotArName'] ?? ''
          : json['slotName'] ?? '',
      orgName: getAppLanguageCode == 'ar'
          ? json['organization']['orgArName'] ?? ''
          : json['organization']['orgEnName'] ?? '',
      depName: getAppLanguageCode == 'ar'
          ? json['department']['deptName'] ?? ''
          : json['department']['deptEnName'] ?? '',
      deptId: json['department']['deptId'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        slotId,
        deptId,
        slotName,
        orgName,
      ];
}
