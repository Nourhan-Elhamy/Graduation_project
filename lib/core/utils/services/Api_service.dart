import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:graduation_project/features/user/data/models/article/article.dart';
import 'package:graduation_project/features/user/data/models/care/care/datum.dart';
import 'package:graduation_project/features/user/data/models/medicine/medicine/datum.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/medicine_search.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/pharmacy_search.dart';

class ApiService {
  final Dio dio;
  String API_URL = "http://20.19.80.46";
  String API_PREFIX = "/api/v1";

  ApiService(this.dio);

  // حفظ التوكن
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', token);
  }

  // جلب التوكن
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }

  Future<List<Datum>> getMedicines() async {
    try {
      final response = await dio.get(
          '$API_URL$API_PREFIX/medicines?category=medicine&page=1&limit=20');
      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final List<dynamic> data = json['data']['data'];
        return data.map((e) => Datum.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred while loading data: $e');
    }
  }

  Future<List<Catum>> getCare() async {
    try {
      final response = await dio
          .get('$API_URL$API_PREFIX/medicines?category=care&page=1&limit=20');
      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        final List<dynamic> data = json['data']['data'];
        return data.map((json) => Catum.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred while loading data: $e');
    }
  }

  Future<List<Article>> getArticles() async {
    try {
      final response =
          await dio.get('http://carecapsole.runasp.net/api/Diseases');
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

  // دالة البحث مع إضافة التوكن في الهيدر فقط هنا
  Future<Map<String, dynamic>> search(String query) async {
    try {
      final token = await getToken();

      final response = await dio.get(
        '$API_URL$API_PREFIX/search?q=$query',
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<PharmacySearch> pharmacies = (data['pharmacies'] as List)
            .map((e) => PharmacySearch.fromJson(e))
            .toList();
        List<MedicineSearch> medicines = (data['medicines'] as List)
            .map((e) => MedicineSearch.fromJson(e))
            .toList();
        return {
          'pharmacies': pharmacies,
          'medicines': medicines,
        };
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }
}
