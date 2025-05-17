import 'package:dartz/dartz.dart';

import '../models/pharmacies_model.dart';

abstract class PharmacyRepo {
  Future<Either<Failure, List<Pharmacy>>> fetchPharmacies();
  Future<Either<Failure, Pharmacy>> fetchPharmacyById(String id);
}

class Failure {
  final String message;

  Failure({required this.message});
}

class ApiFailure extends Failure {
  ApiFailure({required super.message});
}
