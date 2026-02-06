import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _titulocrear = 'crear pin';
  // String _email = '';

  String get titulocrear => _titulocrear;
  // String get email => _email;

  void setTitulocrear(String value) {
    _titulocrear = value;
    notifyListeners();
  }
}
