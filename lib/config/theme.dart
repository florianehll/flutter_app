import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF000000);
  static const Color accentColor = Color(0xFF1BB46B); // Vert pour les éléments d'accent
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF2A2A2A);
  static const Color textColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFF7D7D7D);
  static const Color dividerColor = Color(0xFFE5E5E5);
  static const Color lightButtonColor = Color(0xFFF5F5F5); // Couleur pour les boutons clairs
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 30,
    fontWeight: FontWeight.w900, // Black
    color: textColor,
    letterSpacing: -0.5,
  );
  
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'SFProDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w600, // SemiBold
    color: textColor,
    letterSpacing: -0.4,
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'SFProText',
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    color: secondaryTextColor,
    letterSpacing: -0.3,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'SFProText',
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    color: textColor,
    letterSpacing: -0.2,
  );

  static const TextStyle tabLabelStyle = TextStyle(
    fontFamily: 'SFProText',
    fontSize: 16,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: -0.2,
  );
  
  static const TextStyle buttonLabelStyle = TextStyle(
    fontFamily: 'SFProText',
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: -0.2,
  );
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'SFProText',
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleTextStyle: headingStyle,
        iconTheme: IconThemeData(
          color: textColor,
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: textColor,
        unselectedLabelColor: secondaryTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 16,
          fontWeight: FontWeight.w600, // SemiBold
          letterSpacing: -0.2,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          letterSpacing: -0.2,
        ),
        indicatorColor: accentColor,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: accentColor,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 12,
          fontWeight: FontWeight.w500, // Medium
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200]!,
        labelStyle: const TextStyle(
          fontFamily: 'SFProText',
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'SFProDisplay'),
        displayMedium: TextStyle(fontFamily: 'SFProDisplay'),
        displaySmall: TextStyle(fontFamily: 'SFProDisplay'),
        headlineLarge: TextStyle(fontFamily: 'SFProDisplay'),
        headlineMedium: TextStyle(fontFamily: 'SFProDisplay'),
        headlineSmall: TextStyle(fontFamily: 'SFProDisplay'),
        titleLarge: TextStyle(fontFamily: 'SFProText'),
        titleMedium: TextStyle(fontFamily: 'SFProText'),
        titleSmall: TextStyle(fontFamily: 'SFProText'),
        bodyLarge: TextStyle(fontFamily: 'SFProText'),
        bodyMedium: TextStyle(fontFamily: 'SFProText'),
        bodySmall: TextStyle(fontFamily: 'SFProText'),
        labelLarge: TextStyle(fontFamily: 'SFProText'),
        labelMedium: TextStyle(fontFamily: 'SFProText'),
        labelSmall: TextStyle(fontFamily: 'SFProText'),
      ),
    );
  }
}