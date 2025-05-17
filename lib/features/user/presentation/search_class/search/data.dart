import 'medicine_search.dart';
import 'pharmacy_search.dart';

class Data {
  final List<PharmacySearch>? pharmacies;
  final List<MedicineSearch>? medicines;

  const Data({this.pharmacies, this.medicines});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pharmacies: (json['pharmacies'] as List<dynamic>?)
            ?.map((e) => PharmacySearch.fromJson(e as Map<String, dynamic>))
            .toList(),
        medicines: (json['medicines'] as List<dynamic>?)
            ?.map((e) => MedicineSearch.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'pharmacies': pharmacies?.map((e) => e.toJson()).toList(),
        'medicines': medicines?.map((e) => e.toJson()).toList(),
      };
}
