import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/image_screan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/core/utils/services/Api_service.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
    return Container(
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
          await _pickCompressAndProcess();
        },
      ),
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

  Future<void> _pickCompressAndProcess() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _processResult = null;
        _isLoading = true;
      });

      // ضغط الصورة
      final compressedPath = await compressImage(pickedFile.path, quality: 70);

      if (compressedPath != null) {
        setState(() {
          _pickedImagePath = compressedPath;
        });

        // ابعت الصورة المضغوطة للسيرفر
        final result = await apiService.processImage(compressedPath);
        print('Process result: $result');

        if (!mounted) return;

        setState(() {
          _processResult = result;
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageResultScreen(
              imagePath: compressedPath,
              resultText: result ?? 'No result',
            ),
          ),
        );
      } else {
        setState(() {
          _processResult = 'Failed to compress image';
          _isLoading = false;
        });
      }
    }
  }

  Future<String?> compressImage(String originalPath, {int quality = 80}) async {
    try {
      final originalFile = File(originalPath);
      if (!await originalFile.exists()) return null;

      final bytes = await originalFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) return null;

      List<int> compressedBytes = img.encodeJpg(image, quality: quality);

      final directory = await getTemporaryDirectory();
      final targetPath = path.join(
          directory.path, 'compressed_${path.basename(originalPath)}');
      final compressedFile =
          await File(targetPath).writeAsBytes(compressedBytes);

      return compressedFile.path;
    } catch (e) {
      return null;
    }
  }
}
