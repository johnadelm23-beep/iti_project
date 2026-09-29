import 'package:get_it/get_it.dart';
import 'package:iti_training/features/auth/data/repo/auth_repo.dart';
import 'package:iti_training/features/auth/presentation/cubit/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      getIt<AuthRepository>(),
    ),
  );
}