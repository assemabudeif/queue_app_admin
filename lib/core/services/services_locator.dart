import 'package:get_it/get_it.dart';
import '/features/login/model/repository/login_repository.dart';
import '/features/login/model/repository/login_repository_impl.dart';
import '/features/login/viewmodel/login_cubit.dart';
import '/features/slots/model/repository/user_slots_repository.dart';
import '/features/slots/model/repository/user_slots_repository_impl.dart';
import '/features/slots/viewmodel/user_slots_cubit.dart';
import '/features/tokens/model/repository/tokens_repository.dart';
import '/features/tokens/model/repository/tokens_repository_impl.dart';
import '/features/tokens/viewmodel/tokens_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '/core/services/app_prefs.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// Initialize SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);

    /// Initialize AppPreferences
    sl.registerLazySingleton<AppPreferences>(() => AppPreferences());

    /// Blocs
    sl.registerFactory(() => LoginCubit(sl<LoginRepository>()));
    sl.registerFactory(() => UserSlotsCubit(sl<UserSlotsRepository>()));
    sl.registerFactory(() => TokensCubit(sl<TokensRepository>()));

    /// Repositories
    sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());
    sl.registerLazySingleton<UserSlotsRepository>(
        () => UserSlotsRepositoryImpl());
    sl.registerLazySingleton<TokensRepository>(() => TokensRepositoryImpl());
  }
}
