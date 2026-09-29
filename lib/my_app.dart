import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/di/service_locator.dart';
import 'package:iti_training/core/routes/app_router.dart';
import 'package:iti_training/core/routes/app_routes.dart';
import 'package:iti_training/features/auth/presentation/cubit/cubit/auth_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.login,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      },
    );
  }
}