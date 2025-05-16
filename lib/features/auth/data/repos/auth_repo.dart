import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String baseUrl = 'http://20.19.80.46/api/v1/auth';

  Future<Either<String, String>> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final url = Uri.parse('$baseUrl/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "name": fullName,
        }),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseBody['status'] == 'success') {
        final tokens = responseBody['data']['tokens'];
        final accessToken = tokens['access'];
        final refreshToken = tokens['refresh'];

        final user = responseBody['data']['user'];
        final userId = user['id'];
        final userName = user['name'];
        final userEmail = user['email'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access', accessToken);
        await prefs.setString('refresh', refreshToken);
        await prefs.setString('userId', userId);
        await prefs.setString('userName', userName);
        await prefs.setString('userEmail', userEmail);

        final message = responseBody['message'] ?? 'Registration successful';
        return Right(message);
      } else {
        // ✅ نعرض الرسالة زي ما هي من الباك
        if (responseBody['exception']?['response']?['message'] is List) {
          final List messages = responseBody['exception']['response']['message'];
          final fullMessage = messages.join('\n');
          return Left(fullMessage);
        } else if (responseBody['message'] != null) {
          return Left(responseBody['message']);
        } else {
          return Left('Unexpected error ');
        }
      }
    } catch (e) {
      return Left('Oops error  $e');
    }
  }



  Future<Either<String, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://20.19.80.46/api/v1/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == 'success') {
        final data = responseBody['data'];
        final tokens = data['tokens'];
        final user = data['user'];

        final prefs = await SharedPreferences.getInstance();
        await Future.wait([
          prefs.setString('access', tokens['access']),
          prefs.setString('refresh', tokens['refresh']),
          prefs.setString('id', user['id']),
          prefs.setString('name', user['name']),
          prefs.setString('email', user['email']),
          prefs.setString('role', user['role']),
          prefs.setString('image', user['image'] ?? ''),
          prefs.setString('gender', user['gender'] ?? ''),
          prefs.setString('phone', user['phone'] ?? ''),
          prefs.setString('address', user['address'] ?? ''),
          prefs.setString('user_refresh', user['refresh'] ?? ''),
          prefs.setString('createdAt', user['createdAt']),
          prefs.setString('updatedAt', user['updatedAt']),
        ]);

        return Right(data);
      } else {
        // التعامل مع الأخطاء القادمة من السيرفر
        if (responseBody['exception']?['response']?['message'] is List) {
          final List messages = responseBody['exception']['response']['message'];
          final fullMessage = messages.join('\n');
          return Left(fullMessage);
        } else if (responseBody['message'] != null) {
          return Left(responseBody['message']);
        } else {
          return Left('Login failed: \n${response.body}');
        }
      }
    } catch (e) {
      return Left('An Error Occurred during the login process$e');
    }
  }


  Future<Either<String, Map<String, String>>> forgetPassword({
    required String email,
  }) async {
    final url = Uri.parse('http://20.19.80.46/api/v1/auth/forgot');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'success' && data.containsKey('data')) {
        final message = data['message'] ?? 'Code requested successfully';
        final code = data['data']['code'] ?? '';
        return Right({
          'message': message,
          'code': code,
        });
      } else {
        return Left('Unexpected response structure');
      }
    } else {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // التعامل مع خطأ 400 الخاص بالإيميل الغلط
      if (responseBody.containsKey('exception')) {
        final exception = responseBody['exception'] as Map<String, dynamic>;
        if (exception.containsKey('response')) {
          final resp = exception['response'] as Map<String, dynamic>;
          if (resp.containsKey('message')) {
            final messageData = resp['message'];
            if (messageData is List && messageData.isNotEmpty) {
              // نجمع كل رسائل الخطأ في رسالة واحدة
              final errorMessages = messageData.join('\n');
              return Left(errorMessages);
            } else if (messageData is String) {
              return Left(messageData);
            }
          }
        }
        // لو مش لقينا رسالة واضحة نرجع رسالة عامة
        return Left(exception['message'] ?? 'Unknown error occurred');
      }

      // حالات أخرى
      if (responseBody.containsKey('errors')) {
        final errors = responseBody['errors'] as Map<String, dynamic>;
        String errorMessages = '';
        errors.forEach((field, messages) {
          for (var message in messages) {
            errorMessages += '- $message\n';
          }
        });
        return Left(errorMessages.trim());
      } else if (responseBody.containsKey('title')) {
        return Left(responseBody['title']);
      } else {
        return Left('Forgot password failed: \n${response.body}');
      }
    }
  }



  Future<Either<String, String>> verifyCode({
    required String email,
    required String code,
  }) async {
    final url = Uri.parse('http://20.19.80.46/api/v1/auth/verify');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "code": code}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Right(data['message'] ?? 'Code Verified successfully');
    } else {
      final data = jsonDecode(response.body);
      String errorMessage = 'Verification failed';
      if (data['exception']?['response']?['message'] != null) {
        var msg = data['exception']['response']['message'];
        if (msg is List) {
          errorMessage = msg.join('\n');
        } else if (msg is String) {
          errorMessage = msg;
        }
      } else if (data['message'] != null) {
        errorMessage = data['message'];
      }
      return Left(errorMessage);
    }
  }


  Future<Either<String, String>> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    final url = Uri.parse('http://20.19.80.46/api/v1/auth/reset');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "code": code,
        "password": password,
      }),
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    // حالة النجاح: status = success & code 200 أو 201
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        responseBody['status'] == 'success') {
      final message = responseBody['message'] ?? 'Password reset successful';
      return Right(message);
    }

    // حالة الخطأ:
    if (responseBody['status'] == 'fail') {
      final exception = responseBody['exception'];
      if (exception != null && exception is Map) {
        final resp = exception['response'];
        if (resp != null && resp is Map) {
          final errorMessages = resp['message'];
          if (errorMessages is List) {
            return Left(errorMessages.join('\n'));
          } else if (errorMessages is String) {
            return Left(errorMessages);
          }
        }
        if (exception['message'] != null) {
          return Left(exception['message']);
        }
      }

      if (responseBody['message'] != null) {
        if (responseBody['message'] is List) {
          return Left((responseBody['message'] as List).join('\n'));
        } else if (responseBody['message'] is String) {
          return Left(responseBody['message']);
        }
      }
    }

    return Left('Reset password failed: \n${response.body}');
  }

  Future<Either<String, Map<String, dynamic>>> getProfile() async {
    final url = Uri.parse('http://20.19.80.46/api/v1/me');
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access');
      
      if (accessToken == null) {
        return Left('No access token found');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == 'success') {
        return Right(responseBody);
      } else {
        if (responseBody['exception']?['response']?['message'] is List) {
          final List messages = responseBody['exception']['response']['message'];
          final fullMessage = messages.join('\n');
          return Left(fullMessage);
        } else if (responseBody['message'] != null) {
          return Left(responseBody['message']);
        } else {
          return Left('Failed to fetch profile: \n${response.body}');
        }
      }
    } catch (e) {
      return Left('An error occurred while fetching profile: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> updateProfile({
    required String name,
    required String gender,
    required String phone,
    required String address,
  }) async {
    final url = Uri.parse('http://20.19.80.46/api/v1/me');
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access');
      
      if (accessToken == null) {
        return Left('No access token found');
      }

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          "name": name,
          "gender": gender,
          "phone": phone,
          "address": address,
        }),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == 'success') {
        final userData = responseBody['data'];
        
        // Update local storage with the same keys used in login/register
        await Future.wait([
          prefs.setString('id', userData['id']),
          prefs.setString('name', userData['name']),
          prefs.setString('email', userData['email']),
          prefs.setString('role', userData['role']),
          prefs.setString('image', userData['image'] ?? ''),
          prefs.setString('gender', userData['gender'] ?? ''),
          prefs.setString('phone', userData['phone'] ?? ''),
          prefs.setString('address', userData['address'] ?? ''),
          prefs.setString('createdAt', userData['createdAt']),
          prefs.setString('updatedAt', userData['updatedAt']),
        ]);

        return Right(responseBody);
      } else {
        if (responseBody['exception']?['response']?['message'] is List) {
          final List messages = responseBody['exception']['response']['message'];
          final fullMessage = messages.join('\n');
          return Left(fullMessage);
        } else if (responseBody['message'] != null) {
          return Left(responseBody['message']);
        } else {
          return Left('Profile update failed: \n${response.body}');
        }
      }
    } catch (e) {
      return Left('An error occurred while updating profile: $e');
    }
  }
}
