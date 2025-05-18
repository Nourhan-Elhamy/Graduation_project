import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';
import '../models/getcart_model.dart';

class CartRepo {
  Future<CartItemModel> addToCart({
    required String medicineId,
    required int quantity,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse('http://20.19.80.46/api/v1/cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'medicineId': medicineId,
        'quantity': quantity,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final message = responseData['message'];

      // ✅ استخرج data ومرر message داخل fromJson
      return CartItemModel.fromJson(
        responseData['data'],
        message: message,
      );

    } else {
      throw Exception(responseData['message'] ?? 'Failed to add item');
    }
  }
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse('http://20.19.80.46/api/v1/cart/clear'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(responseData['message'] ?? 'Failed to clear cart');
    }
  }


  Future<CartModel> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    final response = await http.get(
      Uri.parse('http://20.19.80.46/api/v1/cart'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['status'] == 'success') {
      return CartModel.fromJson(data['data']);
    } else {
      throw Exception(data['message'] ?? 'Failed to load cart');
    }
  }
  Future<void> deleteCartItem(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse('http://20.19.80.46/api/v1/cart/$itemId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      return;
    } else {
      throw Exception(data['message'] ?? 'Failed to delete item');
    }
  }

}