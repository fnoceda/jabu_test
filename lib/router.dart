import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentation/pages/detail/detail_page.dart';
import 'presentation/pages/home/home_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
        name: 'character',
        path: '/character/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = state.pathParameters['id'];
          return DetailPage(id: id!);
        }),
  ],
);
