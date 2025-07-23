import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamingworkdo_fe/presentation/screens/cart_page.dart';
import 'package:gamingworkdo_fe/presentation/screens/user_profile.dart';
import 'package:gamingworkdo_fe/presentation/widgets/search_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(String)? onSearchChanged;
  const AppbarWidget({
    super.key,
    required this.scaffoldKey,
    this.onSearchChanged,
  });

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    loadCartCount();
  }

  Future<void> loadCartCount() async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];

    int count = 0;
    for (final item in cart) {
      final decoded = jsonDecode(item);
      if (decoded is Map<String, dynamic>) {
        final quantity = decoded['quantity'];
        if (quantity is int) {
          count += quantity;
        } else if (quantity is String) {
          count += int.tryParse(quantity) ?? 0;
        }
      }
    }

    setState(() {
      cartCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      title: Text(
        "Gaming",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
          onPressed: () {
            showSearchOverlay(context);
          },
        ),

        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile()),
            );
          },
          icon: Icon(FontAwesomeIcons.solidUser, color: Colors.white),
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.cartShopping, color: Colors.white),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
                // Cập nhật lại số lượng khi quay lại
                await loadCartCount();
              },
            ),
            if (cartCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                  child: Center(
                    child: Text(
                      '$cartCount',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),

        IconButton(
          onPressed: () {
            widget.scaffoldKey.currentState?.openEndDrawer();
          },
          icon: Icon(FontAwesomeIcons.bars, color: Colors.white, size: 30),
        ),
      ],
    );
  }

  void showSearchOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Search",
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              padding: EdgeInsets.all(10),
              child: SearchContent(),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, -1),
            end: Offset(0, 0),
          ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }
}
