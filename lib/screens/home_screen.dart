import 'package:flutter/material.dart';
import 'package:jstapp/screens/report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 197, 197, 197),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'JST Forklift Report',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 200),
              Container(
                width: 220,
                height: 50,
                child: ElevatedButton(    
                  style: ElevatedButton.styleFrom(
                    
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
                  },
                  child: const Text(
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    'Send report',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}//comment added to test new repo