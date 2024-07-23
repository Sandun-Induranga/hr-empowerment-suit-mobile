import "package:flutter/material.dart";

/// The [ColorCodes] class contains color codes used throughout the app's theming and UI.

abstract class ColorCodes {
  ColorCodes._();

  /// greenColor
  static const Color greenColor = Color(0xFF122C30);

  /// [Color(0xff128efe)]
  static const Color primaryColor = Color(0xff128efe);

  /// [Color(0xff00031b)]
  static const Color secondaryColor = Color(0xff00031b);

  /// [Color(0xFF212121)]
  static const Color greyColor = Color(0xFF212121);

  static const Color whiteColor = Color(0xffffffff);

  static const Color lightGreyColor = Color(0xff767676);

  static const Color lightGreyColorAlpha = Color(0x76767680);

  static const Color redColor = Color(0xFF7E1B1B);

  /// [Color(0x66212121)]
  static const Color backgroundColor = Color(0x66212121);

  /// [Color(0xFFFF2B44)]

  /// [Color(0xFF000000)]
  static const Color blackColor = Color(0xFF000000);

  /// [Color(0xff063057)]
  static const Color darkBlueColor = Color(0xff2051E5);

  /// [Color(0x21212166)]
  static const Color boderColor = Color(0x21212166);

  static const Color switchEnableColor = Color(0xFF2B4433);

  static const Color zoomSelectTextColor = Color(0xffffD60A);

  static const Color acceptColour = Color(0xFF8BDA67);

  static const Color acceptBackgroundColour = Color(0x198BDA67); //.1

  static const Color acceptOutlineBorderColour = Color(0x598BDA67); //.35

  static const Color switchDisableColor = Color(0x8BDA6733);

  static const Color onboardColor = Color(0xff92BDFF);

  static const Color onboardButtonColor = Color(0xff5985F0);

  static const Color customGrayColor = Color(0xff767676);

  static const Color reviewColor = Color(0xffEAC785);

  static const Color transparent = Color(0x00ffffff);


  static const Color flavourColor1 = Color(0xFFCC493F);
  static const Color flavourColor2 = Color(0xFFE3C503);
  static const Color flavourColor3 = Color(0xFFB29827);
  static const Color flavourColor4 = Color(0xFFE04A4C);
  static const Color flavourColor5 = Color(0xFFF9A215);
  static const Color flavourColor6 = Color(0xFFF66745);

  static const List<Color> flavourColors = [
    flavourColor1,
    flavourColor2,
    flavourColor3,
    flavourColor4,
    flavourColor5,
    flavourColor6,
  ];
}
