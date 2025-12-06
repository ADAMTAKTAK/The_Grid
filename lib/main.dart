import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/games_provider.dart';
import 'package:the_grid/providers/audio_provider.dart';
import 'package:the_grid/routes/app_routes.dart';
import 'package:the_grid/themes/app_theme.dart';
import 'package:the_grid/widgets/widgets.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GamesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AudioProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LifecycleManager(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Grid',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        theme: AppTheme.darkTheme,
      ),
    );
  }
}