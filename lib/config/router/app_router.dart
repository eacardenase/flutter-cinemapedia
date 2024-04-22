import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _movieDetailsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'movie_details');

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(childView: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _movieDetailsNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id']!;

                    return MovieScreen(movieId: movieId);
                  },
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoriteView(),
            )
          ],
        )
      ],
    )
  ],
);
