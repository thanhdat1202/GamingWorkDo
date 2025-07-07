import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  final List<String> imageUrls = [
    'assets/imgs/product3_monitor.png',
    'assets/imgs/banner_allpro.png',
    'assets/imgs/all_collection.png',
    'assets/imgs/screen1st.jpg',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //appbar
        buildCustomAppBar(context),

        //back to home
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                IconButton.outlined(
                  iconSize: 16,
                  color: Colors.white,
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.arrowLeftLong,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  "Back to home",
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

        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 500,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 20)),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _selectedIndex = index;
                      });
                    }
                  },
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width / 3 -
                        16, // luôn 3 cái
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(imageUrls[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
