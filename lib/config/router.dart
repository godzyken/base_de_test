import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/auth/presentation/screens/auth_screen.dart';
import 'package:base_de_test/features/auth/presentation/screens/sign_screen.dart';
import 'package:base_de_test/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:base_de_test/features/counter_app/presentation/home/view/my_home_page.dart';
import 'package:base_de_test/features/profile/presentation/screens/profile_screen.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_entity.dart';
import 'package:base_de_test/features/transactions/presentation/views/boat_form_page.dart';
import 'package:base_de_test/features/transactions/presentation/views/boat_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../features/common/presentation/screens/error_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  homePage,
  authScreen,
  profileScreen,
  signInScreen,
  signUpScreen,
  boatListPage,
  boatFormPage,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  // final countRepository = ref.watch(counterRepositoryProvider);
  // final counterState = ref.watch(counterStateProvider);

  Boat? boat;
  return GoRouter(
      initialLocation: '/boat-list',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: AppRoute.homePage.name,
          pageBuilder: (context, state) => NoTransitionPage(
              child: MyHomePage(
            title: AppRoute.homePage.name,
            key: state.pageKey,
          )),
        ),
        GoRoute(
          path: '/auth',
          name: AppRoute.authScreen.name,
          builder: (context, state) => const AuthScreen(),
          routes: [
            GoRoute(
              path: 'sign-in',
              name: AppRoute.signInScreen.name,
              builder: (context, state) => const SignInScreen(),
            ),
            GoRoute(
              path: 'sign-up',
              name: AppRoute.signUpScreen.name,
              builder: (context, state) => const SignUpScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/profile',
          name: AppRoute.profileScreen.name,
          builder: (context, state) => const ProfileScreen(),
/*          routes: [
            GoRoute(
              path: 'sign-in',
              name: AppRoute.signInScreen.name,
              builder: (context, state) => const SignInScreen(),
            ),
            GoRoute(
              path: 'sign-up',
              name: AppRoute.signUpScreen.name,
              builder: (context, state) => const SignUpScreen(),
            ),
          ],*/
        ),
        GoRoute(
          path: '/boat-list',
          name: AppRoute.boatListPage.name,
          builder: (context, state) => BoatListPage(),
          routes: [
            GoRoute(
              path: 'add-boat',
              name: AppRoute.boatFormPage.name,
              builder: (context, state) => BoatFormPage(boat),
            ),
          ],
        ),
      ],
      observers: [routeObserver, sentryNavigatorObserver],
      /*   redirect: (state) {
      final loggedIn = authStateListenable.value;
      final goingToLogin = state.subloc.contains('/auth');

      if (!loggedIn && !goingToLogin) {
        return '/auth';
      }
      if (loggedIn && goingToLogin) return '/';

      return null;
    },*/
      refreshListenable: authStateListenable,
      errorBuilder: (context, state) =>
          ErrorScreen(message: context.tr.somethingWentWrong));
});

final routeInformationProvider = ChangeNotifierProvider((ref) {
  final router = ref.watch(goRouterProvider);
  return router.routeInformationProvider;
});

final routeInformationParser = Provider((ref) {
  final router = ref.watch(goRouterProvider);
  return router.routeInformationParser;
});

final currentRouteProvider = Provider((ref) {
  final location = ref.watch(routeInformationProvider).value.location;
  return location;
});

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final SentryNavigatorObserver sentryNavigatorObserver = SentryNavigatorObserver(
    autoFinishAfter: const Duration(seconds: 5),
    enableAutoTransactions: false,
    setRouteNameAsTransaction: true);
