import 'dart:convert';
import 'package:app/models/wordspace_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WordspaceStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<List<WordspaceModel>> getAllWordspaces() async {
    final jsonString = await storage.read(key: 'userData');
    if (jsonString == null) return [];

    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.map((item) => WordspaceModel.fromJson(item)).toList();
      }
      if (decoded is Map<String, dynamic>) {
        return [WordspaceModel.fromJson(decoded)];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<WordspaceModel?> getUserSpaceData() async {
    final data = await storage.read(key: 'userData');
    if (data != null) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) {
          return WordspaceModel.fromJson(decoded);
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> saveAllWordspaces(List<WordspaceModel> wordspaces) async {
    final jsonString = jsonEncode(wordspaces);
    await storage.write(key: 'userData', value: jsonString);
  }

  Future<void> addWordspace(WordspaceModel wordspace) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();
    wordspaces.add(wordspace);
    await saveAllWordspaces(wordspaces);
  }

  Future<void> saveCredential(int wordspaceId, Credential credential) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();

    int index = wordspaces.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    wordspaces[index] = WordspaceModel(
      id: wordspaces[index].id,
      name: wordspaces[index].name,
      description: wordspaces[index].description,
      credentials: [...wordspaces[index].credentials, credential],
    );

    await saveAllWordspaces(wordspaces);
  }

  Future<void> updateCredential(
    int wordspaceId,
    int credentialIndex,
    Credential credential,
  ) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();

    int index = wordspaces.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    List<Credential> credentials = [...wordspaces[index].credentials];
    credentials[credentialIndex] = credential;

    wordspaces[index] = WordspaceModel(
      id: wordspaces[index].id,
      name: wordspaces[index].name,
      description: wordspaces[index].description,
      credentials: credentials,
    );

    await saveAllWordspaces(wordspaces);
  }

  Future<void> updateWordspace(
    int wordspaceId,
    WordspaceModel updatedWordspace,
  ) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();

    int index = wordspaces.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    wordspaces[index] = updatedWordspace;

    wordspaces[index] = WordspaceModel(
      id: wordspaces[index].id,
      name: wordspaces[index].name,
      description: wordspaces[index].description,
      credentials: [],
    );

    await saveAllWordspaces(wordspaces);
  }

  Future<void> deleteCredential(int wordspaceId, int credentialIndex) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();

    int index = wordspaces.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    List<Credential> credentials = [...wordspaces[index].credentials];
    credentials.removeAt(credentialIndex);

    wordspaces[index] = WordspaceModel(
      id: wordspaces[index].id,
      name: wordspaces[index].name,
      description: wordspaces[index].description,
      credentials: credentials,
    );

    await saveAllWordspaces(wordspaces);
  }

  Future<void> deleteWordspace(int wordspaceId) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();

    int index = wordspaces.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    wordspaces.removeAt(index);
    await saveAllWordspaces(wordspaces);
  }
}
