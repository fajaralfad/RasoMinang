import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFE8C00);
  static const Color secondaryColor = Color(0xFFF83600);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1A1A1A);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightGrey = Color(0xFF666666);
  static const Color lightGreyLight = Color(0xFF888888);

  // Dark theme colors 
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkGrey = Color(0xFFB0B0B0);
  static const Color darkGreyLight = Color(0xFF888888);
  static const Color darkCardSurface = Color(0xFF2D2D2D);
  static const Color darkOnCardSurface = Color(0xFFFFFFFF);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          background: lightBackground,
          surface: lightSurface,
          onBackground: lightOnBackground,
          onSurface: lightOnSurface,
          error: errorColor,
        ),
        fontFamily: 'Poppins',
        appBarTheme: _lightAppBarTheme,
        scaffoldBackgroundColor: lightBackground,
        textTheme: _lightTextTheme,
        cardTheme: _lightCardTheme, // Updated
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        inputDecorationTheme: _lightInputDecorationTheme,
        dialogTheme: _lightDialogTheme,
        bottomSheetTheme: _lightBottomSheetTheme, // Updated
        dividerTheme: _lightDividerTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: secondaryColor,
          background: darkBackground,
          surface: darkSurface,
          onBackground: darkOnBackground,
          onSurface: darkOnSurface,
          error: errorColor,
        ),
        fontFamily: 'Poppins',
        appBarTheme: _darkAppBarTheme,
        scaffoldBackgroundColor: darkBackground,
        textTheme: _darkTextTheme,
        cardTheme: _darkCardTheme, // Updated
        elevatedButtonTheme: _elevatedButtonTheme,
        textButtonTheme: _textButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        inputDecorationTheme: _darkInputDecorationTheme,
        dialogTheme: _darkDialogTheme,
        bottomSheetTheme: _darkBottomSheetTheme, // Updated
        dividerTheme: _darkDividerTheme,
        progressIndicatorTheme: _progressIndicatorTheme,
      );

  // App Bar Themes
  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: lightOnSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    iconTheme: IconThemeData(color: lightOnSurface),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: darkOnSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    iconTheme: IconThemeData(color: darkOnSurface),
  );

  // Text Themes
  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: lightGrey,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: lightGreyLight,
    ),
  );

  static const TextTheme _darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: darkOnSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: darkGrey,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: darkGreyLight,
    ),
  );

  // Component Themes - UPDATED for better contrast
  static final CardTheme _lightCardTheme = CardTheme(
    elevation: 2,
    color: lightSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
    surfaceTintColor: Colors.transparent,
  );

  static final CardTheme _darkCardTheme = CardTheme(
    elevation: 4,
    color: darkCardSurface, // Use darker surface for cards
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
    surfaceTintColor: Colors.transparent,
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      shadowColor: primaryColor.withOpacity(0.3),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final InputDecorationTheme _lightInputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: lightSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: errorColor, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFF999999),
      fontFamily: 'Poppins',
    ),
    labelStyle: const TextStyle(
      color: lightGrey,
      fontFamily: 'Poppins',
    ),
  );

  static final InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF2A2A2A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF404040)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF404040)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: errorColor, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    hintStyle: const TextStyle(
      color: Color(0xFF888888),
      fontFamily: 'Poppins',
    ),
    labelStyle: const TextStyle(
      color: darkGrey,
      fontFamily: 'Poppins',
    ),
  );

  static final DialogTheme _lightDialogTheme = DialogTheme(
    backgroundColor: lightSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 8,
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: lightOnSurface,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: lightGrey,
    ),
  );

  static final DialogTheme _darkDialogTheme = DialogTheme(
    backgroundColor: darkCardSurface, // Use card surface for dialogs
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 8,
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: darkOnCardSurface, // Use card surface text color
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Poppins',
      color: darkGrey,
    ),
  );

  // UPDATED: Separate bottom sheet themes for light and dark
  static const BottomSheetThemeData _lightBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: lightSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    elevation: 8,
  );

  static const BottomSheetThemeData _darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: darkCardSurface, // Use card surface for bottom sheets
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    elevation: 8,
  );

  static const DividerThemeData _lightDividerTheme = DividerThemeData(
    color: Color(0xFFF0F0F0),
    thickness: 1,
    space: 1,
  );

  static const DividerThemeData _darkDividerTheme = DividerThemeData(
    color: Color(0xFF404040),
    thickness: 1,
    space: 1,
  );

  static const ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: primaryColor,
    circularTrackColor: Color(0xFFE0E0E0),
  );
}