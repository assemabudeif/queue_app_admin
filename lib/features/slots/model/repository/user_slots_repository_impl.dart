import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/constants/app_constance.dart';
import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';
import '/features/slots/model/models/user_slots_model.dart';

import 'user_slots_repository.dart';

class UserSlotsRepositoryImpl extends UserSlotsRepository {
  @override
  Future<Either<Failure, UserSlotsModel>> getUserSlots() async {
    try {
      final response = await DioLogger.getDio().post(
        ApiConstance.getUserSlots,
        data: {
          'empUsername': kUserName,
        },
      );
      return Right(UserSlotsModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure.fromResponse());
    }
  }

  @override
  Future<Either<Failure, int>> logout() async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.logout,
      );
      return Right(response.data['logout'] ?? 0);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure.fromResponse());
    }
  }
}
