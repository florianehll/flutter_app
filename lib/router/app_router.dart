import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/constants.dart';
import '../screens/home/home_screen.dart';
import '../screens/artist/artist_details_screen.dart';
import '../screens/album/album_details_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppConstants.homeRoute,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return HomeScreen(child: child);
        },
        routes: [
          GoRoute(
            path: AppConstants.homeRoute,
            builder: (context, state) => const SizedBox(), // Empty widget as it's handled by HomeScreen
          ),
        ],
      ),
      GoRoute(
        path: AppConstants.artistRoute,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final artistId = state.pathParameters['id'] ?? '';
          return ArtistDetailsScreen(artistId: artistId);
        },
      ),
      GoRoute(
        path: AppConstants.albumRoute,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final albumId = state.pathParameters['id'] ?? '';
          return AlbumDetailsScreen(albumId: albumId);
        },
      ),
    ],
    errorBuilder: (context, state) => 
      Scaffold(
        body: Center(
          child: Text('Page non trouvée: ${state.error}'),
        ),
      ),
  );
}