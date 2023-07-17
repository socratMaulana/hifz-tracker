import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

abstract class CustomTextStyle {
  static TextStyle black() {
    return GoogleFonts.inter(
      color: Colors.black,
    );
  }

  static TextStyle black8w600({double? height}) {
    return GoogleFonts.inter(
      fontSize: 8,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: height,
    );
  }

  static TextStyle black10w400({double? height}) {
    return GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      height: height,
    );
  }

  static TextStyle black10w600({double? height}) {
    return GoogleFonts.inter(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: height,
    );
  }

  static TextStyle black11w400() {
    return GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black11w600() {
    return GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle black12w700() {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle black12w400() {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black12w600() {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle black14w700() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle black15w400() {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black15w700() {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle black15Bold() {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle black16w400() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black16w700({double? height}) {
    return GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: height);
  }

  static TextStyle black20w400() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black20w700() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle black24w400() {
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black25w400() {
    return GoogleFonts.inter(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black32w400() {
    return GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  static TextStyle black4516w400() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black45,
    );
  }

  static TextStyle black4520w400() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black45,
    );
  }

  static TextStyle black54({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5412w400() {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5414w700() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5416w400() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5416w700() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5420w400() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5420w700() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black5424w700() {
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: const Color(0xff404A3D),
    );
  }

  static TextStyle black87({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.black87,
    );
  }

  static TextStyle black8715w700() {
    return GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
  }

  static TextStyle black8716w700() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
  }

  static TextStyle black8716w400() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    );
  }

  static TextStyle black8720w400() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    );
  }

  static TextStyle white({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.white,
    );
  }

  static TextStyle white14w700() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle white16w700() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle white20w400() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
  }

  static TextStyle white20w700() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }

  static TextStyle white24w700() {
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }

  static TextStyle white32w700() {
    return GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
  }

  static TextStyle red({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.red,
    );
  }

  static TextStyle red5416w700() {
    return GoogleFonts.inter(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.red);
  }

  static TextStyle grey({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Colors.grey,
    );
  }

  static TextStyle grey10w400() {
    return GoogleFonts.inter(
      fontSize: 10,
      color: Colors.grey,
    );
  }

  static TextStyle grey12w400() {
    return GoogleFonts.inter(
      fontSize: 12,
      color: Colors.grey,
    );
  }

  static TextStyle grey14w700() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.grey,
    );
  }

  static TextStyle grey16W700() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.grey,
    );
  }

  static TextStyle primary() {
    return GoogleFonts.inter(
      color: CustomColor.primaryColor,
    );
  }

  static TextStyle primary16W400() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: CustomColor.primaryColor,
    );
  }

  static TextStyle primary24W400() {
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: CustomColor.primaryColor,
    );
  }

  static TextStyle primary34W400() {
    return GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      color: CustomColor.primaryColor,
    );
  }

  static TextStyle primary34W700() {
    return GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: CustomColor.primaryColor,
    );
  }

  static TextStyle secondary() {
    return GoogleFonts.inter(
      color: CustomColor.secondaryColor,
    );
  }

  static TextStyle secondary14w700() {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: CustomColor.secondaryColor,
    );
  }

  static TextStyle secondary16w400() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: CustomColor.secondaryColor,
    );
  }

  static TextStyle secondary16w700() {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: CustomColor.secondaryColor,
    );
  }

  static TextStyle secondary20W400() {
    return GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: CustomColor.secondaryColor,
    );
  }

  static TextStyle outlined(
      {required Color strokeColor,
      required Color textColor,
      double? radius,
      double? fontSize,
      FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        shadows: [
          Shadow(
              // bottomLeft
              offset: const Offset(-1.5, -1.5),
              color: strokeColor,
              blurRadius: radius ?? 0),
          Shadow(
              // bottomRight
              offset: const Offset(1.5, -1.5),
              color: strokeColor,
              blurRadius: radius ?? 0),
          Shadow(
              // topRight
              offset: const Offset(1.5, 1.5),
              color: strokeColor,
              blurRadius: radius ?? 0),
          Shadow(
              // topLeft
              offset: const Offset(-1.5, 1.5),
              color: strokeColor,
              blurRadius: radius ?? 0),
        ]);
  }
}
