part of 'user_slots_cubit.dart';

abstract class UserSlotsState {}

class UserSlotsInitial extends UserSlotsState {}

class GetUserSlotsLoading extends UserSlotsState {}

class GetUserSlotsLoaded extends UserSlotsState {}

class GetUserSlotsError extends UserSlotsState {}

class LogoutLoading extends UserSlotsState {}

class LogoutLoaded extends UserSlotsState {}

class LogoutError extends UserSlotsState {}
