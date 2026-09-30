import 'package:flutter/material.dart';
import 'package:iti_training/features/auth/presentation/ui/screens/login_screen.dart';
import 'package:iti_training/features/auth/presentation/ui/screens/register_screen.dart';
import 'package:iti_training/features/main_shell/presentation/ui/screens/main_shell_screen.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _fadeRoute(
          const LoginScreen(),
          settings,
        );

      case AppRoutes.register:
        return _fadeRoute(
          const RegisterScreen(),
          settings,
        );

      case AppRoutes.home:
      case AppRoutes.mainSell:
        return _fadeRoute(
          const MainShellScreen(),
          settings,
        );

      default:
        return _fadeRoute(
          const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _fadeRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          page,
      transitionDuration: const Duration(
        milliseconds: 250,
      ),
      reverseTransitionDuration: const Duration(
        milliseconds: 200,
      ),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}