import 'package:flutter/services.dart';

import '../../core_imports.dart';

// ignore: non_constant_identifier_names
class CustomAppbar {
  static PreferredSizeWidget standard(
      {required String title, List<Widget>? actions}) {
    return AppBar(
      title: Text(
        title,
        maxLines: 1,
      ),
      actions: actions,
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: CustomColor.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
  }

  static PreferredSizeWidget transparent(
      {String? title,
      Widget? titleWidget,
      Color? titleColor,
      FontWeight? fontWeight,
      double? elevation,
      List<Widget>? actions}) {
    return AppBar(
      title: titleWidget ??
          Text(
            title ?? '',
            maxLines: 1,
            style: TextStyle(fontWeight: fontWeight, color: titleColor),
          ),
      actions: actions,
      elevation: elevation,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: CustomColor.primaryColor,
          statusBarIconBrightness: Brightness.dark),
    );
  }

  static PreferredSizeWidget customColor(
      {required Color bgColor,
      String? title,
      Widget? titleWidget,
      Color? titleColor,
      FontWeight? fontWeight,
      double? elevation,
      List<Widget>? actions}) {
    return AppBar(
      title: titleWidget ??
          Text(
            title ?? '',
            maxLines: 1,
            style: TextStyle(fontWeight: fontWeight, color: titleColor),
          ),
      actions: actions,
      elevation: elevation,
      centerTitle: false,
      backgroundColor: bgColor,
      foregroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: bgColor, statusBarIconBrightness: Brightness.light),
    );
  }
}
