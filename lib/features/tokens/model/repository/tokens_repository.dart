import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';

abstract class TokensRepository {
  Future<Either<Failure, int>> getCurrentToken({
    required int depId,
    required int slotId,
  });

  Future<Either<Failure, int>> getNextToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  });

  Future<Either<Failure, int>> cancelToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  });
}
