import 'dart:convert';
import 'package:gamingworkdo_fe/model/user_model.dart';
import 'package:gamingworkdo_fe/ultils/environment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //token
  static const String tokenKey = 'access_token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

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
      print("Đăng ký thất bại: ${response.body}");
      return false;
    }
  }

  //Log in + save token
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
        final jsonData = jsonDecode(response.body);
        final token = jsonData['data']?['accessToken'];
        if (token != null) {
          await saveToken(token);
          return true;
        } else {
          print('Không tìm thấy accessToken trong phản hồi');
        }
      }

      print('Lỗi đăng nhập: ${response.statusCode} - ${response.body}');
      return false;
    } catch (e) {
      print('Lỗi kết nối API: $e');
      return false;
    }
  }

  //profile
  static Future<UserModel?> fetchUserProfile() async {
    final token = await getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$DOMAIN_API/users/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData['data']); // vì có data: {...}
    } else {
      print('Failed to fetch user: ${response.body}');
      return null;
    }
  }

  //update profile
  static Future<bool> updateUserProfile(UserModel user) async {
    final token = await getToken();
    if (token == null) return false;

    final response = await http.patch(
      Uri.parse("$DOMAIN_API/users/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update profile: ${response.body}');
      return false;
    }
  }
}
