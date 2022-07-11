// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

// TODO(shohei): もういらんかも？
const kLocale = Locale('ja', 'JP');

final bool _android = defaultTargetPlatform == TargetPlatform.android;

// const String kFontFamilyAndroid = 'Robot';
// const String kFontFamilyCupertino = 'Hiragino Sans';
// final String kFontFamily = _android ? kFontFamilyAndroid : kFontFamilyCupertino;

final TextTheme _whiteTextTheme =
    _android ? Typography.whiteMountainView : Typography.whiteCupertino;
final TextTheme _blackTextTheme =
    _android ? Typography.blackMountainView : Typography.blackCupertino;

final Typography kTypography = Typography.material2021(
  platform: defaultTargetPlatform,
  white: textTheme(_whiteTextTheme),
  black: textTheme(_blackTextTheme),
  englishLike: textTheme(Typography.englishLike2021),
  dense: textTheme(Typography.dense2021),
  tall: textTheme(Typography.tall2021),
);

TextStyle? _textStyle(TextStyle? base) {
  return base?.copyWith(
    locale: kLocale,
    textBaseline: TextBaseline.ideographic,
  );
}

TextTheme textTheme(TextTheme base) {
  return base.copyWith(
    headline1: _textStyle(base.headline1),
    headline2: _textStyle(base.headline2),
    headline3: _textStyle(base.headline3),
    headline4: _textStyle(base.headline4),
    headline5: _textStyle(base.headline5),
    headline6: _textStyle(base.headline6),
    subtitle1: _textStyle(base.subtitle1),
    subtitle2: _textStyle(base.subtitle2),
    bodyText1: _textStyle(base.bodyText1),
    bodyText2: _textStyle(base.bodyText2),
    caption: _textStyle(base.caption),
    button: _textStyle(base.button),
    overline: _textStyle(base.overline),
  );
}
