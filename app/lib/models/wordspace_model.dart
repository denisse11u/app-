import 'dart:convert';

WordspaceModel wordspaceModelFromJson(String str) =>
    WordspaceModel.fromJson(json.decode(str));

String wordspaceModelToJson(WordspaceModel data) => json.encode(data.toJson());

class WordspaceModel {
  final int id;

  final String name;
  final String description;
  final List<Credential> credentials;

  WordspaceModel({
    required this.name,
    required this.description,
    required this.credentials,
    required this.id,
  });

  factory WordspaceModel.fromJson(Map<String, dynamic> json) => WordspaceModel(
    name: json["name"],
    description: json["description"],
    credentials: List<Credential>.from(
      json["credentials"].map((x) => Credential.fromJson(x)),
    ),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "credentials": List<dynamic>.from(credentials.map((x) => x.toJson())),
    "id": id,
  };
}

class Credential {
  final String name;
  final String user;
  final String password;
  final String url;
  final String notes;
  final String? imageBase64;

  Credential({
    required this.name,
    required this.user,
    required this.password,
    required this.url,
    required this.notes,
    this.imageBase64,
  });

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
    name: json["name"],
    user: json["user"],
    password: json["password"],
    url: json["url"],
    notes: json["notes"],
    imageBase64: json["imageBase64"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "user": user,
    "password": password,
    "url": url,
    "notes": notes,
    "imageBase64": imageBase64,
  };
}
