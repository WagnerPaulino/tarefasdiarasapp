// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ThemeSwitch.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeSwitchStore on ThemeSwitchBase, Store {
  final _$isLightAtom = Atom(name: 'ThemeSwitchBase.isLight');

  @override
  bool get isLight {
    _$isLightAtom.reportRead();
    return super.isLight;
  }

  @override
  set isLight(bool value) {
    _$isLightAtom.reportWrite(value, super.isLight, () {
      super.isLight = value;
    });
  }

  final _$ThemeSwitchBaseActionController =
      ActionController(name: 'ThemeSwitchBase');

  @override
  void changeTheme() {
    final _$actionInfo = _$ThemeSwitchBaseActionController.startAction(
        name: 'ThemeSwitchBase.changeTheme');
    try {
      return super.changeTheme();
    } finally {
      _$ThemeSwitchBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLight: ${isLight}
    ''';
  }
}
