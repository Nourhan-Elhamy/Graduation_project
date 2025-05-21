import 'dart:io';
import 'package:flutter/material.dart';

class ImageResultScreen extends StatelessWidget {
  final String imagePath;
  final String resultText;

  const ImageResultScreen({
    Key? key,
    required this.imagePath,
    required this.resultText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.file(
              File(imagePath),
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              resultText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
