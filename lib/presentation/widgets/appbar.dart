import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

SliverAppBar buildCustomAppBar() {
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
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.bars, color: Colors.white, size: 30),
      ),
    ],
  );
}
