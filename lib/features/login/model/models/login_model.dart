import 'package:equatable/equatable.dart' show Equatable;

class LoginModel extends Equatable {
  final int authentication;
  final int footId;

  const LoginModel({
    required this.authentication,
    required this.footId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      authentication: json['Authentication'] ?? 0,
      footId: json['footid'] ?? 0,
    );
  }

  @override
  List<Object> get props => [authentication, footId];
}
