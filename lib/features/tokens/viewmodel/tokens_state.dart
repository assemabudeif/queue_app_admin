part of 'tokens_cubit.dart';

abstract class TokensState {}

class TokensInitial extends TokensState {}

class GetTokenLoadingState extends TokensState {}

class GetTokenSuccessState extends TokensState {
  final int token;

  GetTokenSuccessState({required this.token});
}

class GetTokenErrorState extends TokensState {
  final String error;

  GetTokenErrorState({required this.error});
}
