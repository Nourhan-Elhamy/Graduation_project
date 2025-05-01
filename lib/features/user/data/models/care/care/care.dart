import 'datum.dart';

class Care {
  final String? status;
  final int? code;
  final String? message;
  final List<Catum>? data;

  const Care({this.status, this.code, this.message, this.data});

  factory Care.fromJson(Map<String, dynamic> json) => Care(
        status: json['status'] as String?,
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Catum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
