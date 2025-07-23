import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/model/product_model.dart';
import 'package:gamingworkdo_fe/presentation/screens/detail_product.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/presentation/widgets/menu.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamingPc extends StatefulWidget {
  const GamingPc({super.key});

  @override
  State<GamingPc> createState() => _GamingPcState();
}

class _GamingPcState extends State<GamingPc> {
  late Future<List<dynamic>> lstProducts;
  List<dynamic> fullProductList = [];
  List<dynamic> visibleProductList = [];
  int loadCount = 5;
  Map<int, String> selectedDropdown = {};
  bool isLoading = true;

  Future<void> fetchProducts() async {
    try {
      final products = await ProductService.getProductsByIds([12, 13, 14]);
      setState(() {
        fullProductList = products;
        visibleProductList =
            products; // hoặc .take(loadCount).toList() nếu bạn muốn lazy load
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching selected products: $e");
    }
  }

  Set<int> wishlistIds = {};
  List<Map<String, dynamic>> wishlistProducts = [];

  Future<void> saveWishlistIds(Set<int> wishlistIds) async {
    final prefs = await SharedPreferences.getInstance();
    final idsAsString = wishlistIds.map((id) => id.toString()).toList();
    await prefs.setStringList('wishlist_ids', idsAsString);
  }

  Future<Set<int>> loadWishlistIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('wishlist_ids') ?? [];
    return ids.map((id) => int.tryParse(id) ?? 0).toSet();
  }

  Future<void> loadWishlist() async {
    final ids = await loadWishlistIds();
    final List<Map<String, dynamic>> products = [];

    for (final id in ids) {
      try {
        final product = await ProductService.getProductById(id);
        products.add(product);
      } catch (e) {
        print("Error loading product $id: $e");
      }
    }

    setState(() {
      wishlistIds = ids;
      wishlistProducts = products;
    });
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
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchProducts();
    loadWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Menu(),
      body: CustomScrollView(
        slivers: [
          //appbar
          AppbarWidget(
            scaffoldKey: scaffoldKey,
            onSearchChanged: _handleSearch,
          ),

          // buildCustomAppBar(context, GlobalKey<ScaffoldState>()),
          DecriptionPage(
            title: "Game Consoles",
            subtitle:
                "A video game console is an electronic device that outputs a video signal or image to display a video game that can be played with a game controller.",
            backTo: "Back to shop",
            onBack: () {
              Navigator.pop(context);
            },
          ),

          //show products
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _productItem(visibleProductList[index]),
              );
            }, childCount: visibleProductList.length),
          ),

          //footer
          FooterWidget(),
        ],
      ),
    );
  }

  Widget _productItem(Map<String, dynamic> product) {
    final int id = product["product_id"] ?? 0;
    final List<dynamic> variants = product["product_variants"] ?? [];
    if (variants.isEmpty) {
      return Text("No variants found");
    }

    final dropdownItems = variants
        .map<String>((v) {
          final attrs = v["attributes"];
          if (attrs != null && attrs["Inches"] != null) {
            return attrs["Inches"].toString();
          } else if (attrs != null && attrs["Color"] != null) {
            return attrs["Color"].toString();
          } else if (attrs != null && attrs["Type"] != null) {
            return attrs["Type"].toString();
          } else if (attrs != null && attrs["GB"] != null) {
            return attrs["GB"].toString();
          } else {
            return "Unknown";
          }
        })
        .toSet()
        .toList();

    final variant = product['product_variants'][0];

    final String? selectedValue =
        (selectedDropdown[id] != null &&
            dropdownItems.contains(selectedDropdown[id]))
        ? selectedDropdown[id]
        : (dropdownItems.isNotEmpty ? dropdownItems.first : null);

    final selectedVariant = variants.firstWhere(
      (v) =>
          (v["attributes"]?["Inches"]?.toString() ?? "Unknown") ==
          selectedValue,
      orElse: () => variants[0],
    );

    final price = selectedVariant["variant_price"];

    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DetailProduct(product: ProductModel.fromJson(product)),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue.withOpacity(0.2),
              Colors.black.withOpacity(0.1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "${product["categories"]?["category_name"] ?? ""} • ${product["brands"]?["brand_name"] ?? ""}",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Image.network(
                        variant['product_image_main'],
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 220,
                          color: Colors.grey[300],
                          child: Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () async {
                            if (wishlistIds.contains(id)) {
                              // Đã có => Xóa khỏi wishlist
                              setState(() {
                                wishlistIds.remove(id);
                                wishlistProducts.removeWhere(
                                  (p) => p["product_id"] == id,
                                );
                              });
                            } else {
                              // Thêm mới => Gọi API rồi thêm
                              try {
                                final product =
                                    await ProductService.getProductById(id);
                                setState(() {
                                  wishlistIds.add(id);
                                  wishlistProducts.add(product);
                                });
                              } catch (e) {
                                print("Lỗi khi thêm sản phẩm vào wishlist: $e");
                              }
                            }
                            await saveWishlistIds(wishlistIds);
                          },
                          icon: Icon(
                            wishlistIds.contains(id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: wishlistIds.contains(id)
                                ? Colors.red
                                : Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "${product["product_name"]}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      index < 3
                          ? FontAwesomeIcons.solidStar
                          : (index == 3
                                ? FontAwesomeIcons.starHalfStroke
                                : FontAwesomeIcons.star),
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (dropdownItems.isNotEmpty && selectedValue != null)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: selectedValue,
                  items: dropdownItems
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDropdown[id] = value!;
                    });
                  },
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "\$${price}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      minimumSize: Size(80, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                    ),
                    child: Text(
                      "ADD TO CART",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
