import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/data/repos/pharmacy_repo.dart';
import 'package:http/http.dart' as http;

import '../models/pharmacies_model.dart';

class PharmacyRepoImplementationFromApi implements PharmacyRepo {
  @override
  Future<Either<Failure, List<Pharmacy>>> fetchPharmacies() async {
    try {
      final response = await http.get(Uri.parse('http://20.19.80.46/api/v1/pharmacies'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success' && responseData['data'] != null) {
          final Map<String, dynamic> data = responseData['data'];
          if (data['data'] != null && data['data'] is List) {
            final List<dynamic> pharmaciesJson = data['data'];
            if (pharmaciesJson.isEmpty) {
              return left(ApiFailure(message: 'No pharmacies available'));
            }

            try {
              final pharmacies = pharmaciesJson.map((json) => Pharmacy.fromJson(json)).toList();
              return right(pharmacies);
            } catch (e) {
              return left(ApiFailure(message: 'Error parsing pharmacy data: $e'));
            }
          } else {
            return left(ApiFailure(message: 'Invalid data format: data.data is not a list'));
          }
        } else {
          return left(ApiFailure(message: 'Invalid response format: ${response.body}'));
        }
      } else {
        return left(ApiFailure(message: 'Failed to load pharmacies: ${response.statusCode} - ${response.body}'));
      }
    } catch (e) {
      return left(ApiFailure(message: 'Error fetching pharmacies: $e'));
    }
  }



  @override
  Future<Either<Failure, Pharmacy>> fetchPharmacyById(String id) async {
    try {
      final response = await http
          .get(Uri.parse('http://20.19.80.46/api/v1/pharmacies/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pharmacy = Pharmacy.fromJson(data['data']); // استخراج البيانات من المفتاح 'data'
        return right(pharmacy);
      } else {
        return left(ApiFailure(message: 'Failed to load pharmacy details'));
      }
    } catch (e) {
      return left(ApiFailure(message: 'Oops, an error occurred!'));
    }
  }
}
