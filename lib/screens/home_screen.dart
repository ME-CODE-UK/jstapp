import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Title here"),
        ElevatedButton(
          onPressed: () {}, 
          child: const Text("Send report"),
        ),
      ],
    );
  }
}//comment added to test new repo