import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomIconCamera extends StatefulWidget {
  const CustomIconCamera({super.key});

  @override
  State<CustomIconCamera> createState() => _CustomIconCameraState();
}

class _CustomIconCameraState extends State<CustomIconCamera> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.blue,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: IconButton(
          icon: const Icon(Icons.camera_alt),
          color: AppColors.white,
          onPressed: () async {
            await checkPermissions();
            pickImage();
          },
        ),
      ),
    );
  }

  Future<void> checkPermissions() async {
    final cameraStatus = await Permission.camera.request();

    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
    } else {}
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {});
    }
  }
}
