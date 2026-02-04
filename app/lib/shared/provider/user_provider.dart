import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isUnlocked = false;
  bool get isUnlocked => _isUnlocked;

  void unlock() {
    _isUnlocked = true;
    notifyListeners();
  }

  void lock() {
    _isUnlocked = false;
    notifyListeners();
  }
}


//  Future<bool> hasPin() async {
//     return await _storage.hasPin();
//   }

//   // ✅ Crear o validar PIN
//   Future<bool> handlePin(String inputPin) async {
//     final savedPin = await _storage.getPin();

//     // Si NO hay PIN guardado → Crear nuevo
//     if (savedPin == null) {
//       await _storage.savePin(inputPin);
//       _isUnlocked = true;
//       notifyListeners();
//       return true; // ✅ PIN creado
//     }

//     // Si SÍ hay PIN → Validar
//     if (inputPin == savedPin) {
//       _isUnlocked = true;
//       notifyListeners();
//       return true; // ✅ PIN correcto
//     }

//     return false; // ❌ PIN incorrecto
//   }