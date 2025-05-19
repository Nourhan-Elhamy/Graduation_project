import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

import 'package:graduation_project/core/utils/services/Api_service.dart';

class CustomIconCamera extends StatefulWidget {
  final Function(String? imagePath)? onImageSelected;

  const CustomIconCamera({super.key, this.onImageSelected});

  @override
  State<CustomIconCamera> createState() => _CustomIconCameraState();
}

class _CustomIconCameraState extends State<CustomIconCamera> {
  String? _pickedImagePath;
  String? _processResult;
  bool _isLoading = false;

  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(Dio());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt),
              color: AppColors.white,
              onPressed: () async {
                await _checkPermissions();
                await _pickImageAndProcess();
              },
            ),
          ),
        ),
        if (_pickedImagePath != null)
          Image.file(
            File(_pickedImagePath!),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        if (_isLoading) const CircularProgressIndicator(),
        if (_processResult != null && !_isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _processResult!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (!cameraStatus.isGranted || !storageStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Camera and Storage permissions are required."),
        ),
      );
    }
  }

  Future<void> _pickImageAndProcess() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _pickedImagePath = pickedFile.path;
        _processResult = null;
        _isLoading = true;
      });

      final result = await apiService.processImage(pickedFile.path);

      if (!mounted) return;

      setState(() {
        _processResult = result;
        _isLoading = false;
      });
    }
  }
}
