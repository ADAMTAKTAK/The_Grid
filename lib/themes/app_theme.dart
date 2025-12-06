import 'package:flutter/material.dart';

class AppTheme {
  
  static const Color background = Colors.black; 
  static const Color primary = Color(0xFF0FF6FF);
  static const Color secondary = Color(0xFFFFB300);
  static const Color error = Color(0xFFE11212);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: 'Orbit',
      bodyColor: Colors.white,
      displayColor: primary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: primary, 
        fontFamily: 'Blanka', 
        fontSize: 24
      ),
      iconTheme: IconThemeData(color: primary),
    ),

    iconTheme: const IconThemeData(
      color: primary,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1A1A1A),
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), 
          bottomRight: Radius.circular(10)
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondary, width: 2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), 
          bottomRight: Radius.circular(10)
        ),
      ),
    ),
  );
}