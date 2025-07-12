import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';

class GamingChair extends StatefulWidget {
  const GamingChair({super.key});

  @override
  State<GamingChair> createState() => _GamingChairState();
}

class _GamingChairState extends State<GamingChair> {
  late Future<List<dynamic>> lstProducts;
  List<dynamic> fullProductList = [];
  List<dynamic> visibleProductList = [];
  int loadCount = 5;
  Map<int, String> selectedDropdown = {};
  bool isLoading = true;

  Future<void> fetchProducts() async {
    try {
      final products = await ProductService.getProductsByIds([8, 9, 10, 11]);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildCustomAppBar(context, GlobalKey<ScaffoldState>()),

          DecriptionPage(
            title: "Game Chairs",
            subtitle:
                "A gaming chair is a type of chair designed for the comfort of gamers. They differ from most office chairs in having high backrests intended to support the upper back and shoulders.",
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
      onPressed: () {},
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
