import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/presentation/screens/all_collection.dart';
import 'package:gamingworkdo_fe/presentation/screens/gaming_card.dart';
import 'package:gamingworkdo_fe/presentation/screens/gaming_chair.dart';
import 'package:gamingworkdo_fe/presentation/screens/gaming_consoles.dart';
import 'package:gamingworkdo_fe/presentation/screens/gaming_monitor.dart';
import 'package:gamingworkdo_fe/presentation/screens/gaming_pc.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:gamingworkdo_fe/presentation/widgets/menu.dart';
import 'package:gamingworkdo_fe/services/product_service.dart';

class ShopPage extends StatefulWidget {
  final void Function(int)? onChangePage;
  const ShopPage({super.key, this.onChangePage});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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

          //decription page
          DecriptionPage(
            backTo: "Back to home",
            title: "Collections",
            subtitle:
                "Step into the future of gaming with our newest releases! Whether you're a fan of heart-pounding action, intricate strategy, or immersive storytelling, our collection has something for everyone.",
            onBack: () {
              if (widget.onChangePage != null) {
                widget.onChangePage!(0);
              }
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),

          //all colecttion
          SliverList(
            delegate: SliverChildListDelegate([
              shopItems(
                "assets/imgs/all_collection.png",
                "All Collections",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCollectionPage(),
                    ),
                  );
                },
              ),
              shopItems("assets/imgs/game_console.png", "Game Consoles", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamingConsoles()),
                );
              }),
              shopItems("assets/imgs/game_card.png", "Game Cards", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamingCard()),
                );
              }),
              shopItems("assets/imgs/game_chair.png", "Game Chairs", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamingChair()),
                );
              }),
              shopItems("assets/imgs/game_monitor.png", "Game Monitors", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamingMonitor()),
                );
              }),
              shopItems("assets/imgs/game_PC.png", "Game PCs", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamingPc()),
                );
              }),
            ]),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 40)),
          //footer
          FooterWidget(),
        ],
      ),
    );
  }

  Widget shopItems(String image, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: TextButton(
        onPressed: onPressed,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 57, 224, 246),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                border: Border.all(width: 1, color: Colors.blue),
              ),
              child: Image.asset(image),
            ),
            Positioned(
              bottom: -25,
              left: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 40),
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                child: Text(title, style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
