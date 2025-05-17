// ignore_for_file: file_names

import 'package:dio/dio.dart';

import 'package:graduation_project/features/user/data/models/article/article.dart';
import 'package:graduation_project/features/user/data/models/care/care/datum.dart';
import 'package:graduation_project/features/user/data/models/medicine/medicine/datum.dart';
import 'package:graduation_project/features/user/presentation/search_class/search/pharmacy_search.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/data/models/pharmacies_model.dart';

class ApiService {
  final Dio dio;
  String API_URL = "http://20.19.80.46";
  String API_PREFIX = "/api/v1";

  ApiService(this.dio);
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
        throw Exception('Failed to loadaing data');
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

  Future<Map<String, dynamic>> search(String query) async {
    try {
      final response = await dio.get(
        '$API_URL$API_PREFIX/search?q=$query',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        List<PharmacySearch> pharmacies = (data['pharmacies'] as List)
            .map((e) => PharmacySearch.fromJson(e))
            .toList();

        List<Medicine> medicines = (data['medicines'] as List)
            .map((e) => Medicine.fromJson(e))
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
