import 'package:flutter/material.dart';

class RememberMeProvider extends ChangeNotifier {
  bool _isRemembered = false;

  bool get isRemembered => _isRemembered;

  void toggleRememberMe() {
    _isRemembered = !_isRemembered;
    notifyListeners();
  }
}
