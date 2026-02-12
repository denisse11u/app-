import 'dart:convert';
import 'dart:io';
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

  Future<void> saveWordspace(WordspaceModel wordspace) async {
    final jsonString = wordspaceModelToJson(wordspace);
    await storage.write(key: 'userData', value: jsonString);
  }

  Future<void> saveCredential(Credential credential, File? image) async {
    try {
      // Get existing wordspace data
      WordspaceModel? currentWordspace = await getWordspace();

      // If no wordspace exists, create a new one
      if (currentWordspace == null) {
        currentWordspace = WordspaceModel(
          name: 'Mi Baúl',
          description: 'Mis conexiones seguras',
          credentials: [],
          id: 0,
        );
      }

      // Add the new credential to the list
      final updatedCredentials = [...currentWordspace.credentials, credential];

      // Create updated wordspace
      final updatedWordspace = WordspaceModel(
        name: currentWordspace.name,
        description: currentWordspace.description,
        credentials: updatedCredentials,
        id: currentWordspace.id,
      );

      // Save to storage
      await saveWordspace(updatedWordspace);
    } catch (e) {
      throw Exception('Error guardando credencial: $e');
    }
  }

  Future<WordspaceModel?> getWordspace() async {
    final jsonString = await storage.read(key: 'userData');

    if (jsonString == null) {
      return null;
    }

    return wordspaceModelFromJson(jsonString);
  }

  Future<void> deleteWordspace() async {
    await storage.delete(key: 'userData');
  }

  Future<bool> hasWordspace() async {
    final data = await getWordspace();
    return data != null;
  }

  //actualizar
  Future<WordspaceModel?> updateWordspace(
    int id,
    WordspaceModel wordspace,
  ) async {
    try {
      final jsonString = await storage.read(key: 'userData');

      if (jsonString == null) return null;
      final List<WordspaceModel> list = wordspaceModelListFromJson(jsonString);
      int index = list.indexWhere((item) => item.id == id);
      if (index == -1) return null;
      list[index] = wordspace;
      final updatedJsonString = jsonEncode(list);
      await storage.write(key: 'userData', value: updatedJsonString);
      return wordspace;
    } catch (e) {
      throw Exception('Error de conexión');
    }
  }

  List<WordspaceModel> wordspaceModelListFromJson(String id) {
    final jsonData = jsonDecode(id) as List;
    return jsonData
        .map((item) => WordspaceModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}



  // final jsonString = await storage.read(key: 'wordspace_data');

    // if (jsonString == null) {
    //   return null;
    // }

    // return wordspaceModelFromJson(jsonString);