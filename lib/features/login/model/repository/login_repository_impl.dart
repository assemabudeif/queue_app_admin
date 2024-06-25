import 'package:dartz/dartz.dart' show Either;
import '/core/data/requests/login_request.dart';
import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/network/custom_request.dart';
import '/features/login/model/models/login_model.dart';

import 'login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest request) {
    return CustomRequest<LoginModel>(
      path: ApiConstance.login,
      fromJson: (json) {
        return LoginModel.fromJson(json);
      },
      data: request.toJson(),
    ).sendPostRequest();
  }
}
