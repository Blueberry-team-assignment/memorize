import 'package:flutter/material.dart';
import 'package:flutter_memorize/presentation/pages/deck_list_screen.dart';
import 'package:flutter_memorize/presentation/pages/home_screen.dart';
import 'package:flutter_memorize/presentation/pages/memorize_list_screen.dart';
import 'package:flutter_memorize/presentation/pages/setting_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/memorize',
      builder: (BuildContext context, GoRouterState state) {
        return const MemorizeListScreen();
      },
    ),
    GoRoute(
      path: '/deck_list',
      builder: (BuildContext context, GoRouterState state) {
        return const DeckListScreen();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingScreen();
      },
    ),
  ],
);
