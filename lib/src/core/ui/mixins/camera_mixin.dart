import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

mixin CameraMixin {
  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> _requestGalleryPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.photos.request();
      final storageStatus = await Permission.storage.request();
      return status.isGranted || storageStatus.isGranted;
    } else {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
  }

  Future<String?> openCamera({double? maxWidth, double? maxHeight}) async {
    final hasPermission = await _requestCameraPermission();
    if (!hasPermission) return null;

    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
    if (pickedFile == null) return null;

    final bytes = await File(pickedFile.path).readAsBytes();
    return base64Encode(bytes);
  }

  Future<String?> openGallery({double? maxWidth, double? maxHeight}) async {
    final hasPermission = await _requestGalleryPermission();
    if (!hasPermission) return null;

    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
    if (pickedFile == null) return null;

    final bytes = await File(pickedFile.path).readAsBytes();
    return base64Encode(bytes);
  }
}
