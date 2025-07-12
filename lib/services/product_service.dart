import 'dart:convert';
import 'package:gamingworkdo_fe/ultils/environment.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<dynamic>> getAllProducts() async {
    final response = await http.get(
      Uri.parse("$DOMAIN_API/products/get-all-products"),
    );
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      // Nếu response là object chứa list trong key "data"
      if (decoded is Map<String, dynamic> && decoded['data'] is List) {
        return decoded['data'];
      }
      // Nếu response là object chứa list trong key "products"
      if (decoded is Map<String, dynamic> && decoded['products'] is List) {
        return decoded['products'];
      }
      // Nếu response là list
      if (decoded is List) {
        return decoded;
      }
      throw Exception('Unexpected response format');
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Map<String, dynamic>> getProductById(int id) async {
    final response = await http.get(
      Uri.parse("$DOMAIN_API/products/get-product-by-id/$id"),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['data'];
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<dynamic>> getProductsByIds(List<int> ids) async {
    final response = await http.get(
      Uri.parse(
        "$DOMAIN_API/products/get-products-by-ids?ids=${ids.join(',')}",
      ),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    } else {
      throw Exception("Failed to fetch selected products");
    }
  }
}
