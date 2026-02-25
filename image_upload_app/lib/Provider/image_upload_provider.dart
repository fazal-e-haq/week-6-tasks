import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadProvider extends ChangeNotifier {
  File? imageFile;
  String? error;
  String? imageUrl;
  double progress = 0;
  bool isUploading = false;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    var pickedImage = await picker.pickImage(source: .gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future<File> compressImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.path,
      quality: 70,
    );
    final compressedFile = File('${file.path}_compressed.jpg')
      ..writeAsBytesSync(result!);
    return compressedFile;
  }

  Future<void> uploadImage() async {
    if (imageFile == null) {
      error = 'No image selected';
      notifyListeners();
      return;
    }

    try {
      isUploading = true;
      error = null;
      progress = 0;
      notifyListeners();
      File compressed = await compressImage(imageFile!);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://httpbin.org/post'),
      );
      var multiPartFile = await http.MultipartFile.fromBytes(
        'file',
        await compressed.readAsBytes(),
        filename: 'image.jpg',
      );
      request.files.add(multiPartFile);
      var streamedResponce = await request.send();
      final totalBytes = compressed.lengthSync();
      int uploadedBytes = 0;
      streamedResponce.stream.listen((chunk) {
        uploadedBytes += chunk.length;
        progress = uploadedBytes / totalBytes;
        notifyListeners();
      });
      final responceData = await streamedResponce.stream.bytesToString();
      final data = jsonDecode(responceData);
      imageUrl = 'https://via.placeholder.com/300.png';
    } catch (errors) {
      error = errors.toString();
    }
    isUploading = true;
    notifyListeners();
  }
}
