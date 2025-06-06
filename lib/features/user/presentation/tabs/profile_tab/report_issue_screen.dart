// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/shared_widgets/custom_button.dart';

class ReportIssueScreen extends StatefulWidget {
  @override
  _ReportIssueScreenState createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedIssueType;

  final List<String> issueTypes = [
    'App Crash',
    'Wrong Medication Info',
    'Order Issue',
    'Other',
  ];

  void _submitIssue() {
    final type = selectedIssueType;
    final description = _descriptionController.text;

    if (type == null || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Please Report an Issue",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        backgroundColor: Colors.red.withOpacity(0.9),
        behavior: SnackBarBehavior.floating,
        margin:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        duration: const Duration(seconds: 3),
      ));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Issue Reported Successfully",
        style:  TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
      backgroundColor: Colors.red.withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
      margin:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      duration: const Duration(seconds: 3),
    ));

    _descriptionController.clear();
    setState(() {
      selectedIssueType = null;
    });

    // Navigate back to profile page after showing the success message

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Report an Issue',
          style: TextStyle(color: AppColors.blue),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Issue Type'),
                items: issueTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                value: selectedIssueType,
                onChanged: (val) => setState(() => selectedIssueType = val),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Describe the issue',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              CustomButton(
                title: 'Send',
                color: AppColors.blue,
                textcolor: AppColors.white,
                onPressed: _submitIssue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
