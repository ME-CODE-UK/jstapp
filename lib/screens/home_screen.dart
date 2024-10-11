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
            //mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200, bottom: 40),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/jst-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'JST Forklift Report',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 150),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(    
                  style: ElevatedButton.styleFrom(
                    
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
                  },
                  child: const Text(
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    'SEND REPORT',
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