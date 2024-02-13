

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/help.dart';
import 'package:global_p/home.dart';
import 'package:global_p/onboarding.dart';
import 'package:global_p/splash.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../map.dart';
import '../widgets/categoryDetails/CategoryDetails.dart';

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
        GoRoute(
            path: "/map",
            builder: (context,state) => MapSample()
        ),
        GoRoute(
            path: "/help",
            builder: (context,state) => Help()
        ),
        GoRoute(
          path: '/categoryDetails/:id1/:id2',  // 👈 Defination of params in the path is important
          name: 'categoryDetails',
          builder: (context, state) => CategoryDetails(
            id1: state.pathParameters['id1'],
            id2: state.pathParameters['id2'],
          ),
        ),
  ]);
});
