import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/presentation/screens/cart_page.dart';
import 'package:gamingworkdo_fe/presentation/screens/home_page.dart';
import 'package:gamingworkdo_fe/presentation/screens/login.dart';
import 'package:gamingworkdo_fe/presentation/screens/shop_page.dart';
import 'package:gamingworkdo_fe/presentation/screens/wishlist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/shop_page': (context) => const LoginPage(),
        '/login_page': (context) => const LoginPage(),
        '/wishlist_page': (context) => const LoginPage(),
        '/cart_page': (context) => const LoginPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var indexPage = 0;
  List<Widget> get lstPage => [
    HomePage(),
    ShopPage(),
    LoginPage(
      onChangePage: (int index) {
        setState(() {
          indexPage = index;
        });
      },
    ),
    WishlistPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstPage[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.store, color: Colors.white),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user, color: Colors.white),
            label: 'Log in',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart, color: Colors.white),
            label: 'Wish list',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bagShopping, color: Colors.white),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
