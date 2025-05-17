// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

class LocationDisplayWidget extends StatefulWidget {
  final Function(String)? onLocationChanged;

  const LocationDisplayWidget({
    super.key,
    this.onLocationChanged,
  });

  @override
  _LocationDisplayWidgetState createState() => _LocationDisplayWidgetState();
}

class _LocationDisplayWidgetState extends State<LocationDisplayWidget> {
  String _location = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // للحصول على الموقع باستخدام Geolocator وتحويله إلى اسم المدينة باستخدام Geocoding
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق من تفعيل خدمات الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _location = "Location services are disabled. Please enable them.";
        });
      }
      return;
    }

    // تحقق من الأذونات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _location = "Location permissions are denied. Please enable them.";
          });
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _location =
              "Location permissions are permanently denied. Please enable them in settings.";
        });
      }
      return;
    }
    try {
      // الحصول على الموقع الحالي
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.best,
      );

      // تحويل الإحداثيات إلى اسم المدينة باستخدام Geocoding
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // إذا كانت القائمة تحتوي على بيانات، اختر المدينة الأولى
      Placemark place = placemarks.first;

      if (mounted) {
        setState(() {
          _location = place.locality ?? "City not found";
        });
        if (widget.onLocationChanged != null) {
          widget.onLocationChanged!(_location);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _location = "$e";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: AppColors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.blue),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: AppColors.blue,
            size: 20,
          ),
          Expanded(
            child: Text(
              _location,
              style: TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
