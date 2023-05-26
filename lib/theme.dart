import 'package:flutter/material.dart';

const double _buttonHeight = 48;
const double _buttonHeightReduce = 36;
const AppFontSize _buttonTextSize = AppFontSize.heading5;
const AppFontSize _buttonTextSizeReduce = AppFontSize.heading6;
final BorderRadius kAppBorderRadius = BorderRadius.circular(4);
const AppColor kAppPrimaryButtonColor = AppColor.purple;
const AppColor kAppOutlinedButtonColor = AppColor.purple;
const double kAppPadding = 12;
const EdgeInsets _appPadding = EdgeInsets.all(kAppPadding);
const EdgeInsets _buttonPadding = EdgeInsets.symmetric(vertical: 4);

enum AppFontSize {
  label,
  normal,
  heading6,
  heading5,
  heading4,
  heading3,
  heading2,
  heading1,
  subtitle,
  title,
  print
}

enum AppColor {
  primary,
  secondary,
  success,
  warning,
  error,
  black,
  white,
  // neutral,
  grey,
  purple,
  linkBlue,
}

enum AppFontWeight {
  app,
  bold,
  normal,
  semibold,
}

// Map<AppFontSize, double> appFontSize = {
//   AppFontSize.label: 10,
//   AppFontSize.normal: 12,
//   AppFontSize.heading3: 16,
//   AppFontSize.heading2: 20,
//   AppFontSize.heading1: 27,
//   AppFontSize.subtitle: 30,
//   AppFontSize.title: 35,
//   AppFontSize.print: 16,
// };

Map<AppFontSize, TextStyle> appStyles = {
  AppFontSize.print: const TextStyle(
    color: AppTheme.blackColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  AppFontSize.label: const TextStyle(fontSize: 10),
  AppFontSize.normal: const TextStyle(fontSize: 12),
  AppFontSize.heading6: TextStyle(
      // fontStyle: FontStyle.italic,
      color: AppTheme.greyColor[700],
      fontWeight: FontWeight.w600,
      fontSize: 14),
  AppFontSize.heading5: const TextStyle(
    color: AppTheme.blackColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  AppFontSize.heading4: TextStyle(
      color: AppTheme.greyColor[700],
      fontWeight: FontWeight.w600,
      // fontStyle: FontStyle.italic,
      fontSize: 20),
  AppFontSize.heading3: TextStyle(
      color: AppTheme.greyColor[700],
      fontWeight: FontWeight.w600,
      fontSize: 22),
  AppFontSize.heading2: const TextStyle(
      color: AppTheme.blackColor, fontWeight: FontWeight.w600, fontSize: 25),
  AppFontSize.heading1: const TextStyle(
      color: AppTheme.blackColor, fontWeight: FontWeight.w600, fontSize: 27),
  AppFontSize.subtitle: TextStyle(
    color: AppTheme.greyColor[700],
    fontWeight: FontWeight.bold,
    fontSize: 30,
  ),
  AppFontSize.title: const TextStyle(
      color: AppTheme.blackColor, fontWeight: FontWeight.bold, fontSize: 35),
};

Map<AppColor, MaterialColor> appColors = {
  AppColor.black: AppTheme.blackColor,
  AppColor.grey: AppTheme.greyColor,
  AppColor.white: AppTheme.whiteColor,
  AppColor.error: AppTheme.errorColor,
  // AppColor.neutral: AppTheme.neutralColor,
  AppColor.warning: AppTheme.warningColor,
  AppColor.primary: AppTheme.primaryColor,
  AppColor.secondary: AppTheme.secondaryColor,
  AppColor.success: AppTheme.successColor,
  AppColor.purple: AppTheme.purpleColor,
  AppColor.linkBlue: AppTheme.linkBlueColor,
};

Map<AppFontSize, FontWeight> appFontWeight = {
  AppFontSize.label: FontWeight.normal,
  AppFontSize.normal: FontWeight.normal,
  AppFontSize.heading3: FontWeight.w500,
  AppFontSize.heading2: FontWeight.w600,
  AppFontSize.heading1: FontWeight.w600,
  AppFontSize.subtitle: FontWeight.w600,
  AppFontSize.title: FontWeight.w600,
};

Map<AppFontWeight, FontWeight> customFontWeight = {
  AppFontWeight.bold: FontWeight.w600,
  AppFontWeight.normal: FontWeight.normal,
  AppFontWeight.semibold: FontWeight.w500,
};

/// FIGMA
/// https://www.figma.com/file/7kABRZ3m9TyQfC2MMQru53/AtlasPOS?node-id=108%3A48&t=MIkSDvqEaWoU2kxa-0
///
abstract class AppTheme {
  // static const purple = Color(0xFF4d1476);
  // static const lilac = Color(0xFFc29eff);
  // static const red = Color(0xFFff0050);
  // static const newRed = Color(0xFFdb2828);
  // static const orange = Color(0xFFff6e00);
  // static const yellow = Color(0xFFffe166);
  // static const green = Color(0xFF22e57c);
  // static const newGreen = Color(0xFF21BA45);
  // static const teal = Color(0xFF07d6c5);
  // static const blue = Color(0xFF92ecf7);
  // static const grey = Color(0xFFd1dbe1);
  // static const darkBlue = Color(0xFF091b94);
  // static const newBlue = Color(0xFF2185d0);

  // New 12/22
  static const primaryColor = PrimaryColor.mcgpalette0;
  static const secondaryColor = SecondaryColor.mcgpalette0;
  static const successColor = SuccessColor.mcgpalette0;
  static const warningColor = WarningColor.mcgpalette0;
  static const errorColor = ErrorColor.mcgpalette0;
  static const blackColor = BlackColor.mcgpalette0;
  static const whiteColor = WhiteColor.mcgpalette0;
  // static const neutralColor = NeutralColor.mcgpalette0;
  static const greyColor = GreyColor.mcgpalette0;
  static const purpleColor = PurpleColor.mcgpalette0;
  static const linkBlueColor = LinkBlueColor.mcgpalette0;
}

abstract class PrimaryColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFE1FAF8),
    100: Color(0xFFB5F3EE),
    200: Color(0xFF83EBE2),
    300: Color(0xFF51E2D6),
    400: Color(0xFF2CDCCE),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF06D1BF),
    700: Color(0xFF05CCB8),
    800: Color(0xFF04C6B0),
    900: Color(0xFF02BCA3),
  });

  static const int _mcgpalette0PrimaryValue = 0xFF07D6C5;

  static const MaterialColor tmp =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFE5FFFB),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFF7FFFEC),
    700: Color(0xFF65FFE8),
  });
  static const int _mcgpalette0AccentValue = 0xFFB2FFF3;
}

abstract class SecondaryColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFFEFEFE),
    100: Color(0xFFFBFBFB),
    200: Color(0xFFF9F9F9),
    300: Color(0xFFF7F7F7),
    400: Color(0xFFF5F5F5),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFFF1F1F1),
    700: Color(0xFFEFEFEF),
    800: Color(0xFFEDEDED),
    900: Color(0xFFEAEAEA),
  });
  static const int _mcgpalette0PrimaryValue = 0xFFF3F3F3;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
  });
  static const int _mcgpalette0AccentValue = 0xFFFFFFFF;
}

abstract class SuccessColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFE4FCEF),
    100: Color(0xFFBDF7D8),
    200: Color(0xFF91F2BE),
    300: Color(0xFF64EDA3),
    400: Color(0xFF43E990),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF1EE274),
    700: Color(0xFF19DE69),
    800: Color(0xFF14DA5F),
    900: Color(0xFF0CD34C),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF22E57C;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFFEFFFE),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFF98FFB5),
    700: Color(0xFF7FFFA2),
  });
  static const int _mcgpalette0AccentValue = 0xFFCBFFDA;
}

abstract class WarningColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFFFFBED),
    100: Color(0xFFFFF6D1),
    200: Color(0xFFFFF0B3),
    300: Color(0xFFFFEA94),
    400: Color(0xFFFFE67D),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFFFFDD5E),
    700: Color(0xFFFFD953),
    800: Color(0xFFFFD549),
    900: Color(0xFFFFCD38),
  });
  static const int _mcgpalette0PrimaryValue = 0xFFFFE166;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFFFFF7E1),
    700: Color(0xFFFFF0C8),
  });
  static const int _mcgpalette0AccentValue = 0xFFFFFFFF;
}

abstract class ErrorColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFFBE5E5),
    100: Color(0xFFF4BFBF),
    200: Color(0xFFED9494),
    300: Color(0xFFE66969),
    400: Color(0xFFE04848),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFFD72424),
    700: Color(0xFFD21E1E),
    800: Color(0xFFCD1818),
    900: Color(0xFFC40F0F),
  });
  static const int _mcgpalette0PrimaryValue = 0xFFDB2828;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFFFF1F1),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFFFF8B8B),
    700: Color(0xFFFF7272),
  });
  static const int _mcgpalette0AccentValue = 0xFFFFBEBE;
}

abstract class NeutralColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFE6E8E9),
    100: Color(0xFFC0C5C9),
    200: Color(0xFF979FA5),
    300: Color(0xFF6D7881),
    400: Color(0xFF4D5B66),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF293844),
    700: Color(0xFF23303B),
    800: Color(0xFF1D2833),
    900: Color(0xFF121B23),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF2E3E4B;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFF66B2FF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFF007FFF),
    700: Color(0xFF0073E6),
  });
  static const int _mcgpalette0AccentValue = 0xFF3399FF;
}

abstract class BlackColor {
  static const MaterialColor mcgpalette0 = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
}

abstract class WhiteColor {
  static const MaterialColor mcgpalette0 = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(_blackPrimaryValue),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  static const int _blackPrimaryValue = 0xFFFFFFFF;
}

class AppText extends StatelessWidget {
  final String data;
  final AppFontSize fontSize;
  final AppColor fontColor;
  final AppFontWeight fontWeight;
  final FontStyle fontStyle;
  final TextAlign align;
  final TextOverflow? overflow;
  final int? maxLines;

  /// The [data] parameter must not be null.
  const AppText(
    this.data, {
    this.fontStyle = FontStyle.normal,
    this.fontSize = AppFontSize.normal,
    this.fontColor = AppColor.white,
    this.fontWeight = AppFontWeight.app,
    this.align = TextAlign.left,
    super.key,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: fontWeight == AppFontWeight.app
          ? appStyles[fontSize]!.copyWith(
              fontStyle: fontStyle,
              color: fontColor == AppColor.success
                  ? appColors[fontColor]![900]
                  : fontColor == AppColor.grey
                      ? appColors[fontColor]![700]
                      : appColors[fontColor],
            )
          : appStyles[fontSize]!.copyWith(
              fontWeight: customFontWeight[fontWeight],
              fontStyle: fontStyle,
              color: appColors[fontColor],
            ),
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

abstract class GreyColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFEEEEEE),
    100: Color(0xFFD4D4D4),
    200: Color(0xFFB8B8B8),
    300: Color(0xFF9B9B9B),
    400: Color(0xFF858585),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF686868),
    700: Color(0xFF5D5D5D),
    800: Color(0xFF535353),
    900: Color(0xFF414141),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF707070;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFF5A9A9),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFFFF3A3A),
    700: Color(0xFFFF2020),
  });
  static const int _mcgpalette0AccentValue = 0xFFF07B7B;
}

abstract class PurpleColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFEAE3EF),
    100: Color(0xFFCAB9D6),
    200: Color(0xFFA68ABB),
    300: Color(0xFF825B9F),
    400: Color(0xFF68378B),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF46126E),
    700: Color(0xFF3D0E63),
    800: Color(0xFF340B59),
    900: Color(0xFF250646),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF4D1476;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFB27BFF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFF7615FF),
    700: Color(0xFF6800FB),
  });
  static const int _mcgpalette0AccentValue = 0xFF9448FF;
}

abstract class LinkBlueColor {
  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFE9EDFE),
    100: Color(0xFFC8D2FC),
    200: Color(0xFFA3B4FB),
    300: Color(0xFF7E95F9),
    400: Color(0xFF627FF7),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF3F60F5),
    700: Color(0xFF3755F3),
    800: Color(0xFF2F4BF2),
    900: Color(0xFF203AEF),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF4668F6;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFFC0C7FF),
    700: Color(0xFFA7B0FF),
  });
  static const int _mcgpalette0AccentValue = 0xFFF3F4FF;
}

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton(
    this.text, {
    this.onPressed,
    super.key,
    this.color = kAppPrimaryButtonColor,
    this.colorText,
    this.decreaseOpacity,
  });
  final String text;
  final AppColor color;
  final AppColor? colorText;
  final bool? decreaseOpacity;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _buttonPadding,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: kAppBorderRadius,
            color: decreaseOpacity != null
                ? appColors[color]![200]
                : appColors[color],
          ),
          height: _buttonHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Center(
                child: AppText(
              text,
              fontColor: colorText ?? _getButtonFontColor(color),
              fontSize: _buttonTextSize,
              // fontWeight: AppFontWeight.normal,
            )),
          ),
        ),
      ),
    );
  }

  AppColor _getButtonFontColor(AppColor color) {
    switch (color) {
      case AppColor.primary:
        return AppColor.black;
      case AppColor.white:
        return AppColor.black;
      default:
        return AppColor.white;
    }
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton(this.text,
      {this.onPressed,
      super.key,
      this.color = kAppOutlinedButtonColor,
      this.reduceSize = false,
      this.icon});
  final String text;
  final AppColor color;
  final void Function()? onPressed;
  final bool reduceSize;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _buttonPadding,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: appColors[color]!),
            borderRadius: kAppBorderRadius,
          ),
          height: reduceSize ? _buttonHeightReduce : _buttonHeight,
          child: icon == null
              ? Padding(
                  padding: reduceSize
                      ? const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0)
                      : const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0),
                  child: Center(
                      child: AppText(
                    text,
                    fontColor: _getButtonFontColor(color),
                    fontSize:
                        reduceSize ? _buttonTextSizeReduce : _buttonTextSize,
                    // fontWeight: AppFontWeight.normal,
                  )),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: AppTheme.blackColor,
                    ),
                    const SizedBox(width: 10),
                    AppText(
                      text,
                      fontColor: AppColor.black,
                      fontSize: AppFontSize.heading5,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  AppColor _getButtonFontColor(AppColor color) {
    switch (color) {
      case AppColor.grey:
        return AppColor.black;
      default:
        return color;
    }
  }
}

class AppOutlinedButtonLogin extends StatelessWidget {
  const AppOutlinedButtonLogin(
    this.text, {
    this.iconText,
    this.onPressed,
    super.key,
    this.color = AppColor.black,
    this.border = true,
  });
  final IconData? iconText;
  final String text;
  final AppColor color;
  final void Function()? onPressed;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: border
            ? BoxDecoration(
                border: Border.all(color: appColors[color]!),
                borderRadius: kAppBorderRadius,
              )
            : null,
        height: 49,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconText,
              color: appColors[color],
            ),
            const SizedBox(width: 10),
            AppText(
              text,
              fontColor: color,
              fontSize: AppFontSize.heading5,
            ),
          ],
        ),
      ),
    );
  }

  AppColor _getButtonFontColor(AppColor color) {
    switch (color) {
      case AppColor.grey:
        return AppColor.black;
      default:
        return color;
    }
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton(this.text, {this.onPressed, super.key});
  final String text;
  final void Function()? onPressed;
  final AppColor color = AppColor.linkBlue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _buttonPadding,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: kAppBorderRadius,
          ),
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            maxHeight: _buttonHeight,
            minHeight: _buttonHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Center(
                child: AppText(
              text,
              fontColor: color,
              fontSize: _buttonTextSize,
              fontWeight: AppFontWeight.bold,
            )),
          ),
        ),
      ),
    );
  }
}

class AppScreenPadding extends StatelessWidget {
  const AppScreenPadding({this.child, super.key});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _appPadding,
      child: child,
    );
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: AppTheme.greyColor[200],
    );
  }
}
