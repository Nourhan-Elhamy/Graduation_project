import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/pharmacies_model.dart';
import '../data/repos/pharmacy_repo.dart';


class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  final PharmacyRepo pharmacyRepo;

  PharmacyDetailsCubit({required this.pharmacyRepo}) : super(PharmacyDetailsInitial());

  Future<void> getPharmacyDetails(int id) async {
    emit(PharmacyDetailsLoading());
    final result = await pharmacyRepo.fetchPharmacyById(id); // تأكد من أن هذه الدالة تقوم بإرجاع بيانات صيدلية واحدة

    result.fold(
          (failure) {
        emit(PharmacyDetailsError(failure.message));
      },
          (pharmacy) {
        emit(PharmacyDetailsLoaded(pharmacy));  // التأكد من استخدام كائن Pharmacy وليس قائمة
      },
    );
  }
}

abstract class PharmacyDetailsState {}

class PharmacyDetailsInitial extends PharmacyDetailsState {}

class PharmacyDetailsLoading extends PharmacyDetailsState {}

class PharmacyDetailsLoaded extends PharmacyDetailsState {
  final Pharmacy pharmacy; // تأكد من أن هنا إشارة إلى كائن واحد من Pharmacy

  PharmacyDetailsLoaded(this.pharmacy);
}

class PharmacyDetailsError extends PharmacyDetailsState {
  final String message;

  PharmacyDetailsError(this.message);
}

