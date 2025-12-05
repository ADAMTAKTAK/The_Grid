import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_grid/providers/games_provider.dart';
import 'package:the_grid/screens/home_screen.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => GamesProvider(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Grid',
      home: HomeScreen(),
    );
  }
}