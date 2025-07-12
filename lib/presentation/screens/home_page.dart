import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/model/product_model.dart';
import 'package:gamingworkdo_fe/presentation/screens/all_collection.dart';
import 'package:gamingworkdo_fe/presentation/screens/detail_product.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/presentation/widgets/menu.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final void Function(int)? onChangePage;
  const HomePage({super.key, this.onChangePage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> lstProducts;
  Map<int, String> selectedDropdown = {}; // dropdown
  bool isLoading = true;

  Set<int> wishlistIds = {};
  List<Map<String, dynamic>> wishlistProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    lstProducts = ProductService.getAllProducts();

    loadWishlist();
  }

  int currentProductIndex = 0;

  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Menu(),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
          buildCustomAppBar(context, _scaffoldKey),

          //body
          SliverToBoxAdapter(
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/imgs/background_home_ps.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 310,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(63, 180, 234, 1),
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue, // Màu xanh
                                  Colors.black, // Màu đen
                                ],
                                begin: Alignment
                                    .centerLeft, // Điểm bắt đầu gradient
                                end: Alignment
                                    .centerRight, // Điểm kết thúc gradient
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  "Featured",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "New Featured Collection",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 0,
                              ), // Thêm padding ngang
                              minimumSize: Size(
                                0,
                                0,
                              ), // Đảm bảo không bị giới hạn bởi min width mặc định
                              tapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // Thu nhỏ vùng chạm
                            ),
                            child: Text(
                              "/ Gaming Collection",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Best ',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Pro Gaming ',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        TextSpan(
                          text: ' Accessories',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Gaming accessories include gear such as headsets, extra controllers, charging  stations, memory devices, carrying cases  and much more.",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          minimumSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllCollectionPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              "SHOW PRODUCTS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Symbols.stadia_controller,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          minimumSize: Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (widget.onChangePage != null) {
                            widget.onChangePage!(1);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "SHOW COLLECTIONS",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Symbols.stadia_controller,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              // height: 850,
              decoration: BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Best ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          TextSpan(
                            text: 'Seller ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          TextSpan(
                            text: 'Of The Week',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        fixedSize: Size(160, 50),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "SHOW PRODUCTS",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          SizedBox(width: 10),
                          Icon(Symbols.stadia_controller, color: Colors.grey),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    //Products list
                    SizedBox(
                      height: 700,
                      child: FutureBuilder<List<dynamic>>(
                        future: lstProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No products found.'),
                            );
                          }
                          final lstProducts = snapshot.data!;
                          final displayProducts = lstProducts
                              .where(
                                (item) =>
                                    item != null &&
                                    item is Map<String, dynamic>,
                              )
                              .take(10)
                              .toList();

                          if (displayProducts.isEmpty) {
                            return const Center(
                              child: Text('No valid products found.'),
                            );
                          }

                          return Column(
                            children: [
                              SizedBox(
                                height: 650,
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: displayProducts.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      currentProductIndex = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    final product = displayProducts[index];
                                    return _productItem(product);
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  displayProducts.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      _pageController.animateToPage(
                                        index,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      width: currentProductIndex == index
                                          ? 24
                                          : 16,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: currentProductIndex == index
                                            ? Colors.blueAccent
                                            : Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Loop (Gaming)
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  ScrollLoopAutoScroll(
                    scrollDirection: Axis.horizontal,
                    reverseScroll: true,
                    child: Text(
                      "Gaming Work Do",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),

          //Subscribe Us
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  border: Border.all(width: 2, color: Colors.blue),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(0, 30),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Subscribe Us",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Subscribe newsletter and get -20% off",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Almost three-quarters of dedicated PC gamers say their main motivation to upgrade is improving gaming experiences.",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter email address...',
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.paperPlane,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Story
          SliverToBoxAdapter(
            child: Container(
              height: 700,
              decoration: BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        minimumSize: Size(0, 30),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Here We Do",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Text(
                      "From Pixels To Play: Sharing Our Story",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "With hardware, tools are what enable a person to install, remove, or perform other actions on the components within their computer.",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    ...[
                          "our gaming offerings cater to your every desire.",
                          "forge lasting friendships with like-minded gamers who share your passion and enthusiasm.",
                          "join us in fostering a vibrant and inclusive gaming culture that celebrates diversity and empowers players to connect, compete, and grow.",
                        ]
                        .map(
                          (text) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " *",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.indigo,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    text,
                                    style: TextStyle(color: Colors.white),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/imgs/img_aboutus.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //about our shop
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'About ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Our ',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        TextSpan(
                          text: 'Shop',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Gaming can help to improve cognitive skills such as problem-solving, memory, and attention.",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  _aboutOurShopItem(
                    "01",
                    "Gift Boxes",
                    "Finished products products and gift wrapping",
                  ),
                  SizedBox(height: 10),
                  _aboutOurShopItem(
                    "02",
                    "Promotions",
                    "Large and frequent promotions with numerous discounts",
                  ),
                  SizedBox(height: 10),

                  _aboutOurShopItem(
                    "03",
                    "Shipping",
                    "Free shipping on any order from \$ 150",
                  ),
                  SizedBox(height: 10),

                  _aboutOurShopItem(
                    "04",
                    "Quality",
                    "All products are made by engineers and designers from India",
                  ),
                ],
              ),
            ),
          ),

          //Footer
          FooterWidget(),
        ],
      ),
    );
  }

  //about our shop items
  Widget _aboutOurShopItem(String stt, String title, String description) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue.withOpacity(0.1),
            Colors.white.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$stt",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              "$title",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "$description",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
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
        .map<String>(
          (v) =>
              (v as Map<String, dynamic>)["attributes"]?["Inches"]
                  ?.toString() ??
              "Unknown",
        )
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
                        top: 8,
                        right: 8,
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
                                : Colors.white,
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
                  color: Colors.white,
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
                          color: Colors.white,
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
