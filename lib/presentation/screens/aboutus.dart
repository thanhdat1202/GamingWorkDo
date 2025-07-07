import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/presentation/widgets/appbar.dart';
import 'package:gamingworkdo_fe/presentation/widgets/decription_page.dart';

class AboutusPage extends StatefulWidget {
  const AboutusPage({super.key});

  @override
  State<AboutusPage> createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //appbar
          buildCustomAppBar(context),

          //description page
          DecriptionPage(
            title: "About Us",
            subtitle:
                "The gaming industry continues to push the boundaries of innovation, offering virtual reality experiences that blur the lines between the real and the digital.",
            backTo: "Back to home",
            onBack: () {
              Navigator.pop(context);
            },
          ),

          // content
        ],
      ),
    );
  }
}
