import 'package:graduation_project/features/user/presentation/tabs/wish_tab/data/repo/wishlist_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistRepository {

  Future<void> addToWishlist(String medicineId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    if (token == null) {
      throw Exception('Missing token');
    }

    final response = await http.post(
      Uri.parse('http://20.19.80.46/api/v1/wishlist'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'medicineId': medicineId,
      }),
    );

    if (response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to add to wishlist');
    }
  }
  Future<void> removeFromWishlist(String medicineId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    if (token == null) {
      throw Exception('Missing token');
    }

    final url = Uri.parse('http://20.19.80.46/api/v1/wishlist/$medicineId');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to remove from wishlist');
    }
  }
  Future<List<WishlistItem>> fetchWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    if (token == null) {
      throw Exception('Missing token');
    }

    final url = Uri.parse('http://20.19.80.46/api/v1/wishlist');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> list = data['data'];
      return list.map<WishlistItem>((e) => WishlistItem.fromJson(e)).toList();
    } else {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to fetch wishlist');
    }
  }


}
