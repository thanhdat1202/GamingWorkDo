import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DecriptionPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  const DecriptionPage({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton.outlined(
                    iconSize: 16,
                    color: Colors.white,
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    onPressed: onBack,
                    icon: Icon(FontAwesomeIcons.arrowLeftLong),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Back To Home",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text("$subtitle", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
