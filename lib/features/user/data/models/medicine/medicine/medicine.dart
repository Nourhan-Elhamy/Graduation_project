import 'datum.dart';

class Medicine {
  final String? status;
  final int? code;
  final String? message;
  final List<Datum>? data;

  const Medicine({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        status: json['status'] as String?,
        code: json['code'] is int
            ? json['code'] as int
            : int.tryParse(json['code']?.toString() ?? ''),
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
