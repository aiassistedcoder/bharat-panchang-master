import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsProvider extends ChangeNotifier {
  final Box _box = Hive.box('settings');

  Locale _locale = const Locale('hi');
  ThemeMode _themeMode = ThemeMode.system;
  bool _largeText = false;
  String _city = 'Mumbai';
  bool _useIndicNumerals = true;

  SettingsProvider() {
    _load();
  }

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get largeText => _largeText;
  String get city => _city;
  bool get useIndicNumerals => _useIndicNumerals;

  void _load() {
    final lang = _box.get('language', defaultValue: 'hi') as String;
    _locale = Locale(lang);

    final theme = _box.get('theme', defaultValue: 'system') as String;
    _themeMode = theme == 'light'
        ? ThemeMode.light
        : theme == 'dark'
            ? ThemeMode.dark
            : ThemeMode.system;

    _largeText = _box.get('largeText', defaultValue: false) as bool;
    _city = _box.get('city', defaultValue: 'Mumbai') as String;
    _useIndicNumerals = _box.get('indicNumerals', defaultValue: true) as bool;
  }

  void setLanguage(String code) {
    _locale = Locale(code);
    _box.put('language', code);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _box.put(
      'theme',
      mode == ThemeMode.light
          ? 'light'
          : mode == ThemeMode.dark
              ? 'dark'
              : 'system',
    );
    notifyListeners();
  }

  void setLargeText(bool value) {
    _largeText = value;
    _box.put('largeText', value);
    notifyListeners();
  }

  void setCity(String city) {
    _city = city;
    _box.put('city', city);
    notifyListeners();
  }

  void setIndicNumerals(bool value) {
    _useIndicNumerals = value;
    _box.put('indicNumerals', value);
    notifyListeners();
  }
}
