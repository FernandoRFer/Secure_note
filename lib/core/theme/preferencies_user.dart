// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';

mixin IUserTheme implements ValueNotifier<UserThemeModel> {
  void setTheme();
  Future<ColorScheme?> setColor();
}

class UserTheme extends ValueNotifier<UserThemeModel> implements IUserTheme {
  UserTheme() : super(UserThemeModel(brightness: Brightness.light));

  // UserTheme() : super(UserThemeModel(brightness: Brightness.light));

  // static final UserTheme _singleton = UserTheme._internal();

  // factory UserTheme() {
  //   return _singleton;
  // }

  // UserTheme._internal() : super(UserThemeModel(brightness: Brightness.light));

  // static ValueNotifier<UserThemeModel> userTheme =
  //     ValueNotifier(UserThemeModel(brightness: Brightness.light));

  // final UserThemeModel _userThemeModel =
  //     UserThemeModel(brightness: Brightness.light);

  @override
  void setTheme() {
    value = value.copyWith(
        brightness:
            WidgetsBinding.instance.platformDispatcher.platformBrightness);
  }

  @override
  Future<ColorScheme?> setColor() async {
    CorePalette? getCorePalette = await DynamicColorPlugin.getCorePalette();
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (getCorePalette != null) {
      value = UserThemeModel(
          brightness: brightness,
          colorScheme: getCorePalette.toColorScheme(brightness: brightness));
      return getCorePalette.toColorScheme();
    }
    return null;
  }

  // ColorScheme? get getColorTeme =>
  //     _userThemeModel.brightness == Brightness.light
  //         ? _userThemeModel.lightColorScheme
  //         : _userThemeModel.darkColorScheme;
}

class UserThemeModel {
  Brightness brightness;
  ColorScheme? colorScheme;
  // ColorScheme? darkColorScheme;
  UserThemeModel({
    required this.brightness,
    this.colorScheme,
    // this.darkColorScheme,
  });

  UserThemeModel copyWith({
    Brightness? brightness,
    ColorScheme? colorScheme,
  }) {
    return UserThemeModel(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? colorScheme,
    );
  }
}
