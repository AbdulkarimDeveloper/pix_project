import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:pixa_project/modules/models/pix_data.dart';
import 'package:pixa_project/modules/views/home_view.dart';
import 'package:pixa_project/modules/views/image_details_view.dart';
import 'package:pixa_project/modules/views/login_view.dart';
import 'package:pixa_project/modules/views/profile_view.dart';
import 'package:pixa_project/modules/views/register_view.dart';
import 'package:pixa_project/utils/router/routers.dart';

/// Create [GoRouter] Object to manage routing
class RouteGenerator {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  /// Create [GoRouter] object
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    observers: [NavigatorObserver()],
    errorBuilder: (context, state) => SizedBox(),
    routes: [
      //! Login
      GoRoute(
        path: Routers.rootRoute,
        name: Routers.rootName,
        pageBuilder: (context, state) {
          return CustomFadeTransition(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: LoginView(),
          );
        },
      ),

      //! Register
      GoRoute(
        path: Routers.registerRoute,
        name: Routers.registerName,
        pageBuilder: (context, state) {
          return CustomFadeTransition(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: RegisterView(),
          );
        },
      ),

      //! Home
      GoRoute(
        path: Routers.homeRoute,
        name: Routers.homeName,
        pageBuilder: (context, state) {
          return CustomFadeTransition(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: HomeView(),
          );
        },
      ),

      //! ImageDetails
      GoRoute(
        path: Routers.imageDetailsRoute,
        name: Routers.imageDetailsName,
        pageBuilder: (context, state) {
          final image = state.extra as Hit;

          return CustomFadeTransition(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: ImageDetailView(image: image),
          );
        },
      ),

      //! Profile
      GoRoute(
        path: Routers.profileDetailsRoute,
        name: Routers.profileDetailsName,
        pageBuilder: (context, state) {
          return CustomFadeTransition(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: ProfileView(),
          );
        },
      ),
    ],
  );

  static GoRouter get routerClient => _router;
}

/// Create custom animation when navigate to next screen
class CustomFadeTransition extends CustomTransitionPage<void> {
  CustomFadeTransition({super.key, required super.child, super.restorationId})
    : super(
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}
