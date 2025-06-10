import 'package:flutter/material.dart';

class ScrollToTop extends StatelessWidget {
  final ScrollController controller;

  const ScrollToTop({super.key, required this.controller});

  void _scrollToTop() {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _scrollToTop,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: CircleBorder(side: BorderSide(color: Colors.blue, width: 2)),
      child: const Icon(Icons.arrow_upward, color: Colors.white),
    );
  }
}
