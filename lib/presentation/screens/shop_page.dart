import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/presentation/screens/all_collection.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //Appbar
        buildCustomAppBar(context),

        //decription page
        DecriptionPage(
          backTo: "Back to home",
          title: "Collections",
          subtitle:
              "Step into the future of gaming with our newest releases! Whether you're a fan of heart-pounding action, intricate strategy, or immersive storytelling, our collection has something for everyone.",
          onBack: () {},
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20)),

        //all colecttion
        SliverList(
          delegate: SliverChildListDelegate([
            shopItems("assets/imgs/all_collection.png", "All Collections"),
            shopItems("assets/imgs/game_console.png", "Gaming Consoles"),
            shopItems("assets/imgs/game_card.png", "Gaming Cards"),
            shopItems("assets/imgs/game_chair.png", "Gaming Chairs"),
            shopItems("assets/imgs/game_monitor.png", "Gaming Monitors"),
            shopItems("assets/imgs/game_PC.png", "Gaming PCs"),
          ]),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 40)),
        //footer
        FooterWidget(),
      ],
    );
  }

  Widget shopItems(String image, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllCollectionPage()),
          );
        },
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
