
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/pharmacies_model.dart';
import '../data/repos/pharmacy_repo.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyRepo pharmacyRepo;

  PharmacyCubit({required this.pharmacyRepo}) : super(PharmacyInitial());

  Future<void> fetchPharmacies() async {
    emit(PharmacyLoading());
    final result = await pharmacyRepo.fetchPharmacies();

    result.fold(
          (failure) {
        emit(PharmacyError(failure.message));
      },
          (pharmacies) {
        emit(PharmacyLoaded(pharmacies));
      },
    );
  }
}


abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacyLoaded extends PharmacyState {
  final List<Pharmacy> pharmacies;

  PharmacyLoaded(this.pharmacies);
}

class PharmacyError extends PharmacyState {
  final String message;

  PharmacyError(this.message);
}
