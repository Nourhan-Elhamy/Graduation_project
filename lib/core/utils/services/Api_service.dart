// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:graduation_project/features/user/data/Models/medicine/medicine.dart';
import 'package:graduation_project/features/user/data/models/article/article.dart';
import '../../../features/user/data/models/care/care.dart';

class ApiService {
  final Dio dio;
  String baseUrl = 'http://carecapsole.runasp.net/api/';
  ApiService(this.dio);

  Future<List<Medicine>> getMedicines() async {
    try {
      final response = await dio.get('$baseUrl Medicine');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Medicine.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred while loading data: $e');
    }
  }

  Future<List<Care>> getCare() async {
    try {
      final response = await dio.get('$baseUrl pharmacy/Care');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Care.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred while loading data: $e');
    }
  }

  Future<List<Article>> getArticles() async {
    try {
      final response = await dio.get('$baseUrl/Diseases');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred while loading data: $e');
    }
  }
}
