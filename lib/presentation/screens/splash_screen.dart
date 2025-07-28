import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gamingworkdo_fe/presentation/screens/start_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 10, 45),
      body: Center(
        child: Image.asset(
          'assets/imgs/logo.png',
          width: 400,
          height: 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
