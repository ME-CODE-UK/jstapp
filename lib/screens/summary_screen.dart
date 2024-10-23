import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key, required this.sumID, required this.sumDriver, required this.sumDetails, required this.sumFault, required this.sumEmail});
  final String sumID;
  final String sumDriver;
  final String sumFault;
  final String sumDetails;
  final String sumEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromARGB(255, 197, 197, 197),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    'Report Summary',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('Forklift ID: $sumID'),
                Text('Driver name: $sumDriver'),
                Text('Fault type: $sumFault'),
                Text('Details of issue: $sumDetails'),
                Text('Email: $sumEmail')
              ],
            ),
          ),
        ),
      ),
    );
  }
}