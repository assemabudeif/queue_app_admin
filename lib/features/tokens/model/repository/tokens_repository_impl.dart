import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/core/error/failures.dart';
import '/core/network/api_constance.dart';
import '/core/utilities/dio_logger.dart';

import 'tokens_repository.dart';

class TokensRepositoryImpl extends TokensRepository {
  @override
  Future<Either<Failure, int>> getCurrentToken({
    required int depId,
    required int slotId,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.getCurrentToken(
          depId: depId,
          slotId: slotId,
        ),
      );
      return Right(response.data ?? 0);
    } catch (e) {
      log('error: ${e.toString()}', name: 'TokensRepositoryImpl');
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure.fromResponse());
    }
  }

  @override
  Future<Either<Failure, int>> cancelToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.cancelToken(
          depId: depId,
          slotId: slotId,
          tokenNumber: tokenNumber,
        ),
      );
      return Right(response.data ?? 0);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure.fromResponse());
    }
  }

  @override
  Future<Either<Failure, int>> getNextToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  }) async {
    try {
      final response = await DioLogger.getDio().get(
        ApiConstance.nextToken(
          depId: depId,
          slotId: slotId,
          tokenNumber: tokenNumber,
        ),
      );
      return Right(response.data ?? 0);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.formDioException(e));
      }
      return Left(ServerFailure.fromResponse());
    }
  }
}
