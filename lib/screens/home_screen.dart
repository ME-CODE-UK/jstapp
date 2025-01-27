//Import packages
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jstapp/screens/report_screen.dart';
import 'package:jstapp/screens/scan_qr.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

//Create HomeScreen class
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

//Build Scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Creates background container and sets background gradient
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
          //Creates column widget to display all the elements on the screen
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200, bottom: 40),
                //Creates container to display JST logo
                child: Container(
                  height: 125,
                  width: 125,
                  //Creates border for images
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  //Set image path
                  child: Image.asset(
                    'assets/images/jst-logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //Creates header text
              const Text(
                'JST Forklift Report',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Creates sized box to space elements
              const SizedBox(height: 150),
              //Creates a sized box to display the report button inside
              SizedBox(
                width: 220,
                height: 50,
                //Creates the report button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  //On button press, adds a new route to the route stack, sends user to report_screen
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReportScreen()));
                  },
                  //Sets text for report button
                  child: const Text(
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    'SEND REPORT',
                  ),
                ),
              ),SizedBox(
                width: 220,
                height: 20,
              ),
              SizedBox(
                width: 220,
                height: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  //On button press, adds a new route to the route stack, sends user to report_screen
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScanQr()));
                  },
                  //Sets text for report button
                  child: const Text(
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                    'SCAN QR',
                  ),
                ),
                //Creates the report button
                // child: MobileScanner(
                //   controller: MobileScannerController(
                //     detectionSpeed: DetectionSpeed.noDuplicates,
                //     returnImage: true,
                //   ),
                //   onDetect: (capture) {
                //     final List<Barcode> barcodes = capture.barcodes;
                //     final Uint8List? image = capture.image;
                //     for (final barcode in barcodes) {
                //       print('Barcode found! ${barcode.rawValue}');
                //     }
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}