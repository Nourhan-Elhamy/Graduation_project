import 'data.dart';

class Search {
  final String? status;
  final int? code;
  final String? message;
  final Data? data;

  const Search({this.status, this.code, this.message, this.data});

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        status: json['status'] as String?,
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.toJson(),
      };
}
