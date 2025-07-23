import 'package:flutter/material.dart';
import 'package:gamingworkdo_fe/main.dart';
import 'package:gamingworkdo_fe/presentation/screens/live_chat.dart';

class FloatingChatButton extends StatelessWidget {
  const FloatingChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 100,
      child: FloatingActionButton(
        heroTag: 'chat_button',
        onPressed: () {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => LiveChat()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.chat),
      ),
    );
  }
}
