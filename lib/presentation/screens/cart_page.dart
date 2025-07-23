import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/menu.dart';
import 'package:gamingworkdo_fe/services/cart_service.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';

class CartPage extends StatefulWidget {
  final void Function(int)? onChangePage;
  const CartPage({super.key, this.onChangePage});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];
  List<Map<String, dynamic>> cartItems = [];

  int get totalItems =>
      cartItems.fold(0, (sum, item) => sum + ((item['quantity'] ?? 0)) as int);

  double get subtotal => cartItems.fold(0.0, (sum, item) {
    final price = (item['variants']?[0]['variant_price'] ?? 0) as num;
    final quantity = item['quantity'] ?? 0;
    return sum + (price * quantity);
  });

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final items = await CartService.getCartItems();
    setState(() {
      cartItems = items;
    });
  }

  Future<void> updateQuantity(int index, int newQuantity) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];
    List<Map<String, dynamic>> items = cart
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
    items[index]['quantity'] = newQuantity;
    await prefs.setStringList('cart', items.map((e) => jsonEncode(e)).toList());
    await loadCart();
  }

  void _handleSearch(String keyword) async {
    final lowerKeyword = keyword.toLowerCase();
    final data = await ProductService.getAllProducts();
    setState(() {
      allProducts = List<Map<String, dynamic>>.from(data);
      filteredProducts = allProducts.where((product) {
        final name = product['product_name']?.toLowerCase() ?? '';
        return name.contains(lowerKeyword);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Menu(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 160),
            child: CustomScrollView(
              slivers: [
                AppbarWidget(
                  scaffoldKey: scaffoldKey,
                  onSearchChanged: _handleSearch,
                ),

                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          IconButton.outlined(
                            iconSize: 16,
                            color: Colors.white,
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white, width: 1),
                              ),
                            ),
                            onPressed: () {
                              if (widget.onChangePage != null) {
                                widget.onChangePage!(0);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.arrowLeftLong),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Back To Home",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: cartItems.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.remove_shopping_cart,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Your cart is empty',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                if (cartItems.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = cartItems[index];
                      final variant = item["variants"]?[0];
                      final imageUrl = variant?["product_image_main"] ?? '';
                      final price = variant?["variant_price"] ?? 0;
                      final quantity = item['quantity'] ?? 1;

                      return Container(
                        height: 140,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.blue),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 120,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(imageUrl, fit: BoxFit.fill)
                                  : const Icon(Icons.image, size: 40),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    item['product_name'] ?? 'Unknown',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (variant?['attributes'] != null) ...[
                                    ...variant!['attributes'].entries
                                        .map<Widget>((entry) {
                                          return Text(
                                            "${entry.key}: ${entry.value}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          );
                                        })
                                        .toList(),
                                  ],
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${price.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove),
                                              onPressed: () {
                                                if (quantity > 1) {
                                                  updateQuantity(
                                                    index,
                                                    quantity - 1,
                                                  );
                                                }
                                              },
                                              iconSize: 16,
                                              padding: EdgeInsets.zero,
                                            ),
                                            Text("$quantity"),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              onPressed: () {
                                                updateQuantity(
                                                  index,
                                                  quantity + 1,
                                                );
                                              },
                                              iconSize: 16,
                                              padding: EdgeInsets.zero,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.trash,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () async {
                                await CartService.removeFromCart(
                                  item['product_id'],
                                );
                                await loadCart();
                              },
                            ),
                          ],
                        ),
                      );
                    }, childCount: cartItems.length),
                  ),
              ],
            ),
          ),

          // Thanh tổng tiền và nút Checkout (ẩn nếu trống)
          if (cartItems.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Item',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '$totalItems',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Ship', style: TextStyle(fontSize: 16)),
                        Text(
                          'Free',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal', style: TextStyle(fontSize: 16)),
                        Text(
                          '\$${subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "CHECKOUT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
