import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/user/presentation/tabs/pharmacie_tab/pharmacy_list/data/repos/pharmacy_repo.dart';
import 'package:http/http.dart' as http;

import '../models/pharmacies_model.dart';

class PharmacyRepoImplementationFromApi implements PharmacyRepo {
  @override
  Future<Either<Failure, List<Pharmacy>>> fetchPharmacies() async {
    try {
      final response = await http
          .get(Uri.parse('http://carecapsole.runasp.net/api/Pharmacies'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final pharmacies = data.map((json) => Pharmacy.fromJson(json)).toList();
        return right(pharmacies);
      } else {
        return left(ApiFailure(message: 'Failed to load pharmacies'));
      }
    } catch (e) {
      return left(ApiFailure(message: 'Oops, an error occurred!'));
    }
  }

  @override
  Future<Either<Failure, Pharmacy>> fetchPharmacyById(int id) async {
    try {
      final response = await http
          .get(Uri.parse('http://carecapsole.runasp.net/api/Pharmacies/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pharmacy = Pharmacy.fromJson(data);
        return right(pharmacy);
      } else {
        return left(ApiFailure(message: 'Failed to load pharmacy details'));
      }
    } catch (e) {
      return left(ApiFailure(message: 'Oops, an error occurred!'));
    }
  }
}
