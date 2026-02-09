import 'dart:convert';
import 'package:app/models/wordspace_model.dart';
import 'package:app/shared/helpers/global_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WordspaceStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<WordspaceModel?> getUserSpaceData() async {
    // final versionAppStorage = await Userstorage().getVersionApp();
    // if (VersionApp.versionApp != versionAppStorage) return null;
    final data = await storage.read(key: 'userData');
    if (data != null) {
      WordspaceModel response = wordspaceModelFromJson(data);
      GlobalHelper.logger.w('Datos leídos de secure storage: $data');
      return response;
    }
    return null;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  setUserSpaceData(WordspaceModel wordspaceModel) async {
    // setVersionApp(VersionApp.versionApp);
    final data = jsonEncode(wordspaceModel);
    GlobalHelper.logger.w('Guardando datos en secure storage: $data');
    await storage.write(key: 'userData', value: data);
  }

  // removeDataLogin() async {
  //   await storage.delete(key: 'userData');
  // }

  // setVersionApp(String versionApp) async {
  //   await storage.write(key: 'versionApp', value: versionApp);
  // }

  // Future<String?> getVersionApp() async {
  //   final versionApp = await storage.read(key: 'versionApp');
  //   GlobalHelper.logger.w('versionApp: $versionApp');
  //   return versionApp;
  // }
  // ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // setDataName(WordspaceModel wordspaceModel) async {
  //   setVersionApp(VersionApp.versionApp);
  //   final data = jsonEncode(wordspaceModel);
  //   GlobalHelper.logger.w('Guardando datos en secure storage: $data');
  //   await storage.write(key: 'userData', value: data);
  // }

  // removeDataLogin() async {
  //   await storage.delete(key: 'userData');
  // }

  // setVersionApp(String versionApp) async {
  //   await storage.write(key: 'versionApp', value: versionApp);
  // }

  // Future<String?> getVersionApp() async {
  //   final versionApp = await storage.read(key: 'versionApp');
  //   GlobalHelper.logger.w('versionApp: $versionApp');
  //   return versionApp;
  // }
}
