

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_p/categoryDetailsPages/categoryDetailsDiffrentTicketTypes/CategoryDetailsCRCClosed.dart';
import 'package:global_p/categoryDetailsPages/categoryDetailsDiffrentTicketTypes/CategoryDetailsCRCNew.dart';
import 'package:global_p/categoryDetailsPages/categoryDetailsDiffrentTicketTypes/CategoryDetailsCRCReopend.dart';
import 'package:global_p/help.dart';
import 'package:global_p/home.dart';
import 'package:global_p/onboarding.dart';
import 'package:global_p/splash.dart';
import 'package:global_p/widgets/CategoryItem.dart';
import 'package:go_router/go_router.dart';

import '../categoryDetailsPages/CategoryDetailsCRC.dart';
import '../categoryDetailsPages/categoryDetailsDiffrentTicketTypes/CategoryDetailsCRCDone.dart';
import '../categoryDetailsPages/categoryDetailsDiffrentTicketTypes/CategoryDetailsCRCanceled.dart';
import '../categoryDetailsPages/CategoryDetailsContacts.dart';
import '../mainLogin.dart';
import '../map.dart';

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
        /*GoRoute(
          path: '/categoryDetails/:id1/:id2',  // 👈 Defination of params in the path is important
          name: 'categoryDetails',
          builder: (context, state) => CategoryDetails(
            id1: state.pathParameters['id1'],
            id2: state.pathParameters['id2'],
          ),
        ),*/
        GoRoute(
          path: '/CategoryDetailsCRC',
          builder: (context, state) => CategoryDetailsCRC(),
        ),
        GoRoute(
          path: '/CategoryDetailsCRCNew',
          builder: (context, state) => CategoryDetailsCRCNew(),
        ),
        GoRoute(
          path: '/CategoryDetailsCRCDone',
          builder: (context, state) => CategoryDetailsCRCDone(),
        ),
        GoRoute(
          path: '/CategoryDetailsContacts',
          builder: (context, state) => CategoryDetailsContacts(),
        ),
   GoRoute(
          path: '/CategoryDetailsCRCanceled',
          builder: (context, state) => CategoryDetailsCRCanceled(),
        ),
    GoRoute(
          path: '/CategoryDetailsCRCReopend',
          builder: (context, state) => CategoryDetailsCRCReopend(),
        ),
    GoRoute(
          path: '/CategoryDetailsCRCClosed',
          builder: (context, state) => CategoryDetailsCRCClosed(),
        ),
  ]);
});
