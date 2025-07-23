import 'dart:convert';
import 'package:gamingworkdo_fe/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static Future<void> addToCart(
    Map<String, dynamic> product,
    ProductVariant variant,
    int quantity,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    final cartItem = {
      'product_id': product['product_id'],
      'product_name': product['product_name'],
      'variants': [
        {
          'product_image_main': variant.productImageMain,
          'variant_price': variant.variantPrice,
          'attributes': variant.attributes,
        },
      ],
      'quantity': quantity,
    };

    bool exists = false;
    List<Map<String, dynamic>> cartItems = cart
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
    for (var item in cartItems) {
      if (item['product_id'] == product['product_id'] &&
          item['variants'][0]['attributes'].toString() ==
              variant.attributes.toString()) {
        item['quantity'] += quantity;
        exists = true;
        break;
      }
    }

    if (!exists) {
      cartItems.add(cartItem);
    }

    await prefs.setStringList(
      'cart',
      cartItems.map((item) => jsonEncode(item)).toList(),
    );
  }

  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];
    return cart
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  static Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];
    List<String> updatedCart = cart.where((item) {
      final cartItem = jsonDecode(item) as Map<String, dynamic>;
      return cartItem['product_id'] != productId;
    }).toList();

    await prefs.setStringList('cart', updatedCart);
  }

  static Future<void> saveCartItems(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = items.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('cart', encoded);
  }
}
