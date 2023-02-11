import 'package:base_de_test/features/auth/application/auth_state_controller.dart';
import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/auth/domain/entities/auth_state/auth_state.dart';
import 'package:base_de_test/features/auth/presentation/screens/auth_screen.dart';
import 'package:base_de_test/features/auth/presentation/screens/sign_screen.dart';
import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:base_de_test/features/counter_app/presentation/home/view/my_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/common/presentation/screens/error_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute { homePage, authScreen, signInScreen }

final goRouterProvider = Provider<GoRouter>((ref) {
  // final countRepository = ref.watch(counterRepositoryProvider);
  // final counterState = ref.watch(counterStateProvider);
  final router = RouterNotifier(ref);

  return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: router._routes,
      observers: [routeObserver],
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

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authStateProvider, (_, __) => notifyListeners());
  }

/*  String? _redirectLogic(GoRouterState state) {
    final loginState = _ref.read(authStateProvider);
    final areLogged = state.location == '/sign-in';

    loginState.maybeWhen(
      authenticated: (status, user) => areLogged ? '/' : '/sign-in',
      unauthenticated: (status) => areLogged ? null : 'sign-up',
      orElse: () => '/sign-up',
    );

    return null;
  }*/

  List<RouteBase> get _routes => <RouteBase>[
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
          ],
        ),
      ];
}
