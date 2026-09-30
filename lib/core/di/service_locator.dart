import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:iti_training/core/network/api_constants.dart';
import 'package:iti_training/core/network/api_service.dart';
import 'package:iti_training/features/auth/data/repo/auth_repo.dart';
import 'package:iti_training/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:iti_training/features/home/data/repo/home_repo.dart';
import 'package:iti_training/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:iti_training/features/movie_details/presentation/cubit/cubit/movie_details_cubit.dart';
import 'package:iti_training/features/wishlist/data/repo/wish_list_repo.dart';
import 'package:iti_training/features/wishlist/presentation/cubit/cubit/wish_list_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(
      getIt<ApiService>(),
    ),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      getIt<HomeRepo>(),
    ),
  );
  getIt.registerFactory<MovieDetailsCubit>(
  () => MovieDetailsCubit(
    getIt<HomeRepo>(),
  ),
);
getIt.registerLazySingleton<WishlistRepo>(
  () => WishlistRepo(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  ),
);

getIt.registerFactory<WishlistCubit>(
  () => WishlistCubit(
    getIt<WishlistRepo>(),
  ),
);
}