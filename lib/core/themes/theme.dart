import '../../core_imports.dart';

final appTheme = ThemeData(fontFamily: 'Inter').copyWith(
  primaryColor: CustomColor.primaryColor,
  appBarTheme: const AppBarTheme(
      backgroundColor: CustomColor.primaryColor, elevation: 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(CustomColor.primaryColor),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: CustomColor.primaryColor,
    cursorColor: CustomColor.primaryColor,
    selectionHandleColor: CustomColor.primaryColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: CustomColor.primaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: CustomColor.primaryColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        CustomTextStyle.primary(),
      ),
    ),
  ),
);
