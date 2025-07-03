import 'dart:convert';
import 'package:gamingworkdo_fe/ultils/environment.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //Sign Up
  static Future<bool> signup({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String pass,
  }) async {
    final url = Uri.parse("$DOMAIN_API/auth/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "password": pass,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print("Đăng ký thất bại !!");
      return false;
    }
  }

  //Log in
  static Future<bool> login({
    required String email,
    required String pass,
  }) async {
    final url = Uri.parse("$DOMAIN_API/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': pass}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Nếu API trả về thành công, có thể lưu token hoặc email vào SharedPreferences nếu cần
        return true;
      } else {
        print('Lỗi đăng nhập: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Lỗi kết nối API: $e');
      return false;
    }
  }
}
