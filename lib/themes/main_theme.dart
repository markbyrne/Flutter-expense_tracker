import 'package:flutter/material.dart';

Color babyPowder = Color.fromARGB(255, 255, 253, 247);
Color silverLakeBlue = Color.fromARGB(255, 108, 145, 194);
Color oxfordBlue = Color.fromARGB(255, 10, 35, 66);
Color mint = Color.fromARGB(255, 9, 188, 138);
Color persianOrange = Color.fromARGB(255, 219, 144, 101);

var kColorScheme = ColorScheme.fromSeed(seedColor: silverLakeBlue);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: oxfordBlue,
  brightness: Brightness.dark,
);

class MainTheme {

  static ThemeData get dark {
    return ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          scaffoldBackgroundColor: kDarkColorScheme.surfaceContainerLow,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kDarkColorScheme.onPrimaryContainer,
              fontSize: 20,
            ),
            titleMedium: TextStyle(color: kDarkColorScheme.onPrimaryContainer),
            bodyMedium: TextStyle(color: kDarkColorScheme.onPrimaryContainer),
            bodyLarge: TextStyle(color: kDarkColorScheme.onPrimaryContainer),
          ),
          cardTheme: CardThemeData().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.secondaryContainer,
            ),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(iconSize: 34),
          ),
        );
  }

  static ThemeData get light {
    return ThemeData().copyWith(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: kColorScheme.surfaceContainerLow,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onPrimaryContainer,
            fontSize: 20,
          ),
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.onPrimary,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(iconSize: 34),
        ),
      );
  }

}