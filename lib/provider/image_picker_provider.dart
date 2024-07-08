import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firebase_storage_service.dart';

class ImagePickerProvider with ChangeNotifier {
  XFile? _image;
  XFile? _pickedFile;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  XFile? get image => _image;
  XFile? get pickedFile => _pickedFile;
  String? get imageUrl => _imageUrl;

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      //_image = XFile(pickedFile.path);
      //_imageUrl = await _firebaseStorageService.uploadProfileImage(_image!,email);
      notifyListeners();
    }else{
      print('Image is not picked');
    }
  }

  Future<void> loadProfileImage(String email) async {
    _imageUrl = await _firebaseStorageService.getProfileImageUrl(email);
    notifyListeners();
  }
}

