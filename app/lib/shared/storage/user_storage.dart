import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Userstorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
  ); //para que este cifrada en android donde se guarda, lee y borra el pin

  Future<void> savePin(String pin) async {
    await storage.write(
      key: 'user_pin',
      value: pin,
    ); // se pone key userpin para indentificar ese dato en la memoria, y en value llama a la funcion del paramenteo
  }

  Future<String?> getPin() async {
    //ver cual pin fue el guardado
    return await storage.read(key: 'user_pin');
  }

  //para saber si existe un pin
  Future<bool> hasPin() async {
    final pin = await getPin();
    return pin != null;
  }

  Future<void> deletePin() async {
    //borrar
    await storage.delete(key: 'user_pin');
  }

  //para saber si existe una palabra
  Future<bool> hasWord() async {
    final word = await getWord();
    return word != null;
  }

  Future<void> saveWord(String word) async {
    await storage.write(
      key: 'user_word',
      value: word,
    ); // se pone key userpin para indentificar ese dato en la memoria, y en value llama a la funcion del paramenteo
  }

  Future<String?> getWord() async {
    //ver cual palabra fue el guardado
    return await storage.read(key: 'user_word');
  }
}
