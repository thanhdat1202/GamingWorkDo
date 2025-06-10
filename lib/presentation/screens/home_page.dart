import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/footer.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productList = [
    {
      "id": 1,
      "name": "Nintendo Switch Lite Turquoise",
      "image": "assets/imgs/product1_switch.png",
      "discount": "37%",
      "cond": "New",
      "price": "543.00",
      "oldPrice": "700.00",
      "dropDown": ["Blue", "White", "Grey"],
    },
    {
      "id": 2,
      "name": "Rubber Keycaps",
      "image": "assets/imgs/product2_keyboard.png",
      "discount": "25%",
      "price": "499.00",
      "oldPrice": "669.00",
      "dropDown": ["Green", "Red"],
    },
    {
      "id": 3,
      "name": "Alen Ware Monitor T46",
      "image": "assets/imgs/product3_monitor.png",
      "discount": "30%",
      "price": "470.00",
      "oldPrice": "650.00",
      "dropDown": ["28 inch", "32 inch"],
    },
  ];

  int currentProductIndex = 0;

  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Map<int, String> selectedColors = {};

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar
        buildCustomAppBar(),

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
                              begin:
                                  Alignment.centerLeft, // Điểm bắt đầu gradient
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
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "SHOW PRODUCTS",
                            style: TextStyle(color: Colors.white, fontSize: 10),
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
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "SHOW COLLECTIONS",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
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
                    height: 600,
                    child: Column(
                      children: [
                        // Hiển thị sản phẩm hiện tại
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: productList.length,
                            onPageChanged: (index) {
                              setState(() {
                                currentProductIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return _productItem(productList[index]);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        // Hàng dot chọn sản phẩm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            productList.length,
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
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                width: currentProductIndex == index ? 24 : 16,
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
                    ),
                  ),
                ],
              ),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

        //About Us
        SliverToBoxAdapter(
          child: Container(
            height: 700,
            decoration: BoxDecoration(color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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

        //Footer
        FooterWidget(),
      ],
    );
  }

  Widget _productItem(Map<String, dynamic> product) {
    int id = product["id"];
    // List<String> selected = selectedColors[id] ?? product["dropDown"];

    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue.withOpacity(0.2), // Màu xanh
            Colors.black.withOpacity(0.1), // Màu đen
          ],
          begin: Alignment.topCenter, // Điểm bắt đầu gradient
          end: Alignment.bottomCenter, // Điểm kết thúc gradient
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
          children: [
            product["cond"] != null
                ? _decriptionPro("${product["cond"]}")
                : SizedBox(height: 20),
            SizedBox(height: 10),
            _decriptionPro("${product["discount"]}"),
            SizedBox(height: 10),
            Image.asset(
              "${product["image"]}",
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text(
              "${product["name"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(FontAwesomeIcons.solidStar, color: Colors.white, size: 16),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.solidStar, color: Colors.white, size: 16),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.solidStar, color: Colors.white, size: 16),
                SizedBox(width: 5),
                Icon(
                  FontAwesomeIcons.starHalfStroke,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.star, color: Colors.white, size: 16),
              ],
            ),
            SizedBox(height: 10),
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
              value: selectedColors[id] ?? (product["dropDown"] as List).first,
              items: (product["dropDown"] as List)
                  .map<DropdownMenuItem<String>>(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedColors[id] = value!;
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${product["price"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${product["oldPrice"]}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    minimumSize: Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Text(
                    "UNAVAILABLE",
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
    );
  }
}

Widget _decriptionPro(title) {
  return Container(
    height: 20,
    width: 40,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.lightBlue, // Màu xanh
          Colors.black, // Màu đen
        ],
        begin: Alignment.centerLeft, // Điểm bắt đầu gradient
        end: Alignment.centerRight, // Điểm kết thúc gradient
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        "$title",
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
