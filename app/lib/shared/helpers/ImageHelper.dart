import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageHelper {
  // Convertir imagen File a Base64
  static Future<String> imageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  // Convertir Base64 a Widget Image
  static Widget imageFromBase64(String base64String, {double? radius}) {
    try {
      final Uint8List bytes = base64Decode(base64String);
      return ClipOval(
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: radius != null ? radius * 2 : null,
          height: radius != null ? radius * 2 : null,
        ),
      );
    } catch (e) {
      return Icon(Icons.person, size: radius);
    }
  }
}
