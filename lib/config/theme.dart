import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF000000);
  static const Color accentColor = Color(0xFF1DB954);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF2A2A2A);
  static const Color textColor = Color(0xFF000000);
  static const Color secondaryTextColor = Color(0xFF7D7D7D);
  static const Color dividerColor = Color(0xFFE5E5E5);
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'SFPro',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
  
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'SFPro',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'SFPro',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: secondaryTextColor,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'SFPro',
    fontSize: 14,
    color: textColor,
  );
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'SFPro',
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        background: backgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleTextStyle: titleStyle,
        iconTheme: IconThemeData(
          color: textColor,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: textColor,
        unselectedLabelColor: secondaryTextColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: accentColor,
        unselectedItemColor: secondaryTextColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 12,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200]!,
        labelStyle: const TextStyle(
          fontFamily: 'SFPro',
          fontSize: 14,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'SFPro'),
        displayMedium: TextStyle(fontFamily: 'SFPro'),
        displaySmall: TextStyle(fontFamily: 'SFPro'),
        headlineLarge: TextStyle(fontFamily: 'SFPro'),
        headlineMedium: TextStyle(fontFamily: 'SFPro'),
        headlineSmall: TextStyle(fontFamily: 'SFPro'),
        titleLarge: TextStyle(fontFamily: 'SFPro'),
        titleMedium: TextStyle(fontFamily: 'SFPro'),
        titleSmall: TextStyle(fontFamily: 'SFPro'),
        bodyLarge: TextStyle(fontFamily: 'SFPro'),
        bodyMedium: TextStyle(fontFamily: 'SFPro'),
        bodySmall: TextStyle(fontFamily: 'SFPro'),
        labelLarge: TextStyle(fontFamily: 'SFPro'),
        labelMedium: TextStyle(fontFamily: 'SFPro'),
        labelSmall: TextStyle(fontFamily: 'SFPro'),
      ),
    );
  }
}