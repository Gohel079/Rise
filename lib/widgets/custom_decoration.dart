
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/constants/app_colors.dart';
import '../base/constants/app_images.dart';
import '../base/constants/app_styles.dart';

InputDecoration getTextFieldBorderDecoration(String hint) {
  return InputDecoration(
      contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 22,horizontal: 20),
      fillColor:  darkTextFieldFillColor,
      filled: true,
      suffixIcon:  InkWell(
        onTap: (){

        },
        child: SvgPicture.asset(
          AppImages.icEyePassword,
          height: 256,
        ),
      ),
      border: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(7))
      ),
      errorMaxLines: 2,
      isDense: true,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorStyle: const TextStyle(
        fontFamily: fontFamilyMontserrat,
        color: Colors.red,
        fontSize: 12,
      ));
}

InputDecoration getTextFieldBorderLightGrayDecoration(String hint) {
  return InputDecoration(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      fillColor:  darkTextFieldFillColor,
      filled: true,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: borderColor)
      ),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.red)
      ),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: secondaryColor)
      ),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: borderColor)
      ),
      disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: borderColor)
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: borderColor)
      ),
      errorMaxLines: 2,
      isDense: true,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorStyle: const TextStyle(
        fontFamily: fontFamilyMontserrat,
        color: Colors.red,
        fontSize: 12,
      ));
}
InputDecoration getTextFieldWithoutBorderDecoration(String hint) {
  return InputDecoration(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      fillColor:  white,
      filled: true,
      border: InputBorder.none,
      errorMaxLines: 2,
      isDense: true,
      hintText: hint,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorStyle: const TextStyle(
        fontFamily: fontFamilyMontserrat,
        color: Colors.red,
        fontSize: 12,
      ));
}