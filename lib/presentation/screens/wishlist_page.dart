import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/presentation/widgets/menu.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage extends StatefulWidget {
  final void Function(int)? onChangePage;
  const WishlistPage({super.key, this.onChangePage});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Set<int> wishlistIds = {};
  List<Map<String, dynamic>> wishlistProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  Future<Set<int>> loadWishlistIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('wishlist_ids') ?? [];
    return ids.map((e) => int.tryParse(e) ?? 0).toSet();
  }

  Future<void> loadWishlist() async {
    final ids = await loadWishlistIds();
    final List<Map<String, dynamic>> products = [];

    for (final id in ids) {
      try {
        final product = await ProductService.getProductById(id);
        products.add(product);
      } catch (e) {
        print("Lỗi khi load sản phẩm ID $id: $e");
      }
    }

    setState(() {
      wishlistIds = ids;
      wishlistProducts = products;
      isLoading = false;
    });
  }

  Future<void> _clearAllWishlist() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      wishlistIds.clear();
      wishlistProducts.clear();
    });

    await prefs.remove('wishlist_ids');
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];

  Future<void> loadProducts() async {
    final data = await ProductService.getAllProducts();
    setState(() {
      allProducts = List<Map<String, dynamic>>.from(data);
      filteredProducts = List<Map<String, dynamic>>.from(data);
    });
  }

  void _handleSearch(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    setState(() {
      filteredProducts = allProducts.where((product) {
        final name = product['product_name']?.toLowerCase() ?? '';
        return name.contains(lowerKeyword);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Menu(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          //appbar
          AppbarWidget(
            scaffoldKey: scaffoldKey,
            onSearchChanged: _handleSearch,
          ),

          //desc
          DecriptionPage(
            backTo: "Back to home",
            title: "Wishlist",
            subtitle:
                "Discover epic games, exclusive gear, and must-have collectibles. Gear up for adventure with the ultimate wishlist experience! Add your favorites and be ready for the next big win!",
            onBack: () {
              if (widget.onChangePage != null) {
                widget.onChangePage!(0);
              }
            },
          ),

          SliverToBoxAdapter(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : wishlistProducts.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Your wishlist is empty !!",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                : Column(
                    children: wishlistProducts.map((product) {
                      final variant = product["product_variants"][0];
                      final price = variant["variant_price"];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 105,
                                  vertical: 10,
                                ),
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blueAccent,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.lightBlue.withOpacity(0.2),
                                      Colors.white.withOpacity(0.5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Image.network(
                                  variant["product_image_main"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                product["brands"]?["brand_name"] ?? "",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                product["product_name"] ?? "",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${price.toString()}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Size: ${variant["attributes"]?["Inches"] ?? "Unknown"}",
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    height: 50,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent[200],
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "ADD TO CART",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  setState(() {
                                    wishlistIds.remove(product["product_id"]);
                                    wishlistProducts.removeWhere(
                                      (p) =>
                                          p["product_id"] ==
                                          product["product_id"],
                                    );
                                  });
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setStringList(
                                    'wishlist_ids',
                                    wishlistIds
                                        .map((e) => e.toString())
                                        .toList(),
                                  );
                                },
                                icon: Icon(
                                  FontAwesomeIcons.trash,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: wishlistIds.isEmpty ? null : _clearAllWishlist,
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "CLEAR ALL",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //footer
          FooterWidget(),
        ],
      ),
    );
  }
}
