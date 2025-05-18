// lib/repositories/order_repo.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/orders_models.dart';
class OrderRepo {
  OrderRepo();

  Future<void> createOrder(CreateOrderRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    final url = Uri.parse('http://20.19.80.46/api/v1/orders');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Order creation failed: ${response.body}');
    }
  }

  Future<List<Order>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    final url = Uri.parse('http://20.19.80.46/api/v1/orders');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final ordersList = (data['data'] as List)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();
      return ordersList;
    } else {
      throw Exception('Failed to load orders: ${response.body}');
    }
  }


  Future<OrderDetail> getOrderById(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access');

    final url = Uri.parse('http://20.19.80.46/api/v1/orders/$orderId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return OrderDetail.fromJson(data);
    } else {
      throw Exception('Failed to load order details: ${response.body}');
    }
  }

// باقي الدوال زي createOrder و getOrders ...

}

