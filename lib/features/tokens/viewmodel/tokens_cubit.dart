import 'dart:developer';

import 'package:bloc/bloc.dart';
import '/features/tokens/model/repository/tokens_repository.dart';

part 'tokens_state.dart';

class TokensCubit extends Cubit<TokensState> {
  TokensCubit(this._repository) : super(TokensInitial());

  final TokensRepository _repository;

  Future<void> getCurrentToken({
    required int depId,
    required int slotId,
  }) async {
    emit(GetTokenLoadingState());
    final result = await _repository.getCurrentToken(
      depId: depId,
      slotId: slotId,
    );
    result.fold(
      (error) {
        log('error: ${error.toString()}', name: 'TokensCubit');
        emit(GetTokenErrorState(error: error.toString()));
      },
      (token) => emit(GetTokenSuccessState(token: token)),
    );
  }

  Future<void> getNextToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  }) async {
    emit(GetTokenLoadingState());
    final result = await _repository.getNextToken(
      depId: depId,
      slotId: slotId,
      tokenNumber: tokenNumber,
    );
    result.fold(
      (error) => emit(GetTokenErrorState(error: error.toString())),
      (token) => emit(GetTokenSuccessState(token: token)),
    );
  }

  Future<void> cancelToken({
    required int depId,
    required int slotId,
    required String tokenNumber,
  }) async {
    emit(GetTokenLoadingState());
    final result = await _repository.cancelToken(
      depId: depId,
      slotId: slotId,
      tokenNumber: tokenNumber,
    );
    result.fold(
      (error) => emit(GetTokenErrorState(error: error.toString())),
      (token) => emit(GetTokenSuccessState(token: token)),
    );
  }
}
