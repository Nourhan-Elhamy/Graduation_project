import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/pharmacies_model.dart';
import '../data/repos/pharmacy_repo.dart';

class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  final PharmacyRepo pharmacyRepo;

  PharmacyDetailsCubit({required this.pharmacyRepo}) : super(PharmacyDetailsInitial());

  Future<void> getPharmacyDetails(String id) async {
    emit(PharmacyDetailsLoading());
    final result = await pharmacyRepo.fetchPharmacyById(id); // دالة جلب الصيدلية باستخدام المعرف

    result.fold(
          (failure) {
        emit(PharmacyDetailsError(failure.message));
      },
          (pharmacy) {
        emit(PharmacyDetailsLoaded(pharmacy)); // تأكد من أنك تمرر كائن Pharmacy واحد هنا
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
