import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/features/slots/model/models/user_slots_model.dart';

abstract class UserSlotsRepository {
  Future<Either<Failure, UserSlotsModel>> getUserSlots();
  Future<Either<Failure, int>> logout();
}
