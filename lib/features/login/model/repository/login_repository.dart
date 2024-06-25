import 'package:dartz/dartz.dart' show Either;
import '/core/data/requests/login_request.dart';
import '/core/error/failures.dart';
import '/features/login/model/models/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login(LoginRequest request);
}
