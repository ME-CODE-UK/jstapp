import 'package:flutter/material.dart';
import 'package:jstapp/screens/report_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Text(
                'JST Forklift Report',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 450),
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
                  child: Text(
                    style: GoogleFonts.montserrat(
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