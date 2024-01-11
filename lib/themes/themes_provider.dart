import 'package:flutter/material.dart';
import 'package:minimalchatx/themes/dark_mode.dart';
import 'package:minimalchatx/themes/light_mode.dart';
class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData =lightmode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkmode;
  set ThemeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darkmode;
    }else
      {
        themeData = lightmode;
      }
  }
}