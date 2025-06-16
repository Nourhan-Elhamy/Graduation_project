// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
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

  Future<List<Datum>> getMedicines({int page = 1}) async {
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

  Future<List<Catum>> getCare({int page = 1}) async {
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
      final response = await dio.get('https://carecapsole.tryasp.net/article');
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

  Future<String?> processImage(String imagePath) async {
    try {
      // الحصول على mime type من المسار
      final mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imagePath,
          filename: 'image.jpg',
          contentType: MediaType.parse(mimeType),
        ),
      });

      final token = await getToken();

      final response = await dio.post(
        '$API_URL$API_PREFIX/ai/process-image',
        data: formData,
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;

        if (data != null &&
            data['code'] == 200 &&
            data['status'] == 'success') {
          return data['data']?['medicine'] ??
              data['result'] ??
              'No result found';
        } else {
          return 'API error message: ${data['message'] ?? 'Unknown error'}';
        }
      } else {
        return 'HTTP Error: ${response.statusCode}, message: ${response.data}';
      }
    } catch (e) {
      print('Exception caught: $e');
      return 'Error: $e';
    }
  }
}
