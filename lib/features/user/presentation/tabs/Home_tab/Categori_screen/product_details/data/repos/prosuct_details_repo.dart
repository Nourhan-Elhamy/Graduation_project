import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models.dart';

class ProductDetailsService {
  static Future<ProductDetails> fetchProductById(String id) async {
    final url = Uri.parse('http://20.19.80.46/api/v1/medicines/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return ProductDetails.fromJson(data);
    } else {
      throw Exception('فشل تحميل المنتج');
    }
  }
}
