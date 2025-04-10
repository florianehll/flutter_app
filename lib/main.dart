import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'api/services/audio_db_service.dart';
import 'blocs/artist/artist_bloc.dart';
import 'blocs/album/album_bloc.dart';
import 'blocs/charts/charts_bloc.dart';
import 'blocs/search/search_bloc.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'config/theme.dart';
import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // Initialize Dio for API requests
  final dio = Dio();
  
  // Initialize the API service
  final audioDbService = AudioDbService(dio);
  
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
    audioDbService: audioDbService,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final AudioDbService audioDbService;

  const MyApp({
    Key? key,
    required this.sharedPreferences,
    required this.audioDbService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArtistBloc>(
          create: (context) => ArtistBloc(audioDbService: audioDbService),
        ),
        BlocProvider<AlbumBloc>(
          create: (context) => AlbumBloc(audioDbService: audioDbService),
        ),
        BlocProvider<ChartsBloc>(
          create: (context) => ChartsBloc(audioDbService: audioDbService)
            ..add(const LoadTopSingles())
            ..add(const LoadTopAlbums()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(audioDbService: audioDbService),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(preferences: sharedPreferences)
            ..add(const LoadFavorites()),
        ),
      ],
      child: MaterialApp.router(
        title: 'AudioDB App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('fr'), // French
          Locale('de'), // German
          Locale('es'), // Spanish
          Locale('it'), // Italian
        ],
      ),
    );
  }
}