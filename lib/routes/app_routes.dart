import 'package:flutter/material.dart';
import 'package:the_grid/screens/screens.dart';

class AppRoutes {
  
  static const initialRoute = 'home';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'home':    ( _ ) => const HomeScreen(),
    'details': ( _ ) => const DetailsScreen(),
    'info':    ( _ ) => const InfoScreen(),
  };
}