import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_colors.dart';

@immutable
class AppTypography {
  TextStyle get title => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: AppColors().black,
      );
  TextStyle get label => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors().purple,
      );
  TextStyle get label2 => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors().gray,
      );
  TextStyle get label3 => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: AppColors().purple,
      );
  TextStyle get subTitle => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors().gray,
      );
  TextStyle get content => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: AppColors().white,
      );
  TextStyle get input => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors().input,
      );
  TextStyle get forgotPassword => TextStyle(
        fontFamily: 'Manrope',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors().forgotPassword,
      );
}
