//final prefs = await SharedPreferences.getInstance();

//final token = prefs.getString('access');

import 'package:shared_preferences/shared_preferences.dart';

Future<void> someFunction() async {
  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('access');
}
