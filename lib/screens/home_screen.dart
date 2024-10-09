import 'package:flutter/material.dart';
import 'package:jstapp/screens/report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Title here"),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
          }, 
          child: const Text("Send report"),
        ),
      ],
    );
  }
}//comment added to test new repo