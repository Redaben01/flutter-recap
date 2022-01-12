import 'package:flutter/foundation.dart';

class Settings extends ChangeNotifier {
  bool _darkMode = false;

  bool get isDark => _darkMode ?? false;

  void changeMode(bool isDark) {
    _darkMode = isDark;
    notifyListeners();
  }
}
