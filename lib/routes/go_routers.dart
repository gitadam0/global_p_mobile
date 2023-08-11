

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/home.dart';
import 'package:global_p/onboarding.dart';
import 'package:global_p/splash.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';

final goRouterProvider = Provider<GoRouter>((ref) {

  return GoRouter(
    initialLocation: "/",
      routes: [
          GoRoute(
              path: "/",
              builder: (context,state) => splash()
          ),
          GoRoute(
              path: "/login",
              builder: (context,state) => MyHomePage(title: "u")
          ),
          GoRoute(
              path: "/home",
              builder: (context,state) => home()
          ),
        GoRoute(
            path: "/onboarding",
            builder: (context,state) => onBoarding()
        ),
  ]);
});
