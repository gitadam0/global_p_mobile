

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (context,state) => MyHomePage(title: "u")
    )
  ]);
});
