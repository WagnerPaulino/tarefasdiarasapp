// flutter packages pub run build_runner build --delete-conflicting-outputs
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'ThemeSwitch.g.dart';

// This is the class used by rest of your codebase
class ThemeSwitchStore = ThemeSwitchBase with _$ThemeSwitchStore;

// The store-class

abstract class ThemeSwitchBase with Store {
  
  @observable
  bool isLight;

  ThemeSwitchBase({this.isLight = true}) {
    bool isLight = SchedulerBinding.instance!.window.platformBrightness == Brightness.light;
    this.isLight = isLight;
  }

  @action
  void changeTheme() {
    this.isLight = !this.isLight;
  }

  @action
  void setTheme(bool isLight) {
    this.isLight = isLight;
  }
}
