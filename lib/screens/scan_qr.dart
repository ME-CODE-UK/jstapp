//Import packages
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:jstapp/screens/report_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

//Create HomeScreen class
class ScanQr extends StatelessWidget {
  const ScanQr({super.key});

//Build Scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Creates background container and sets background gradient
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            print('Barcode found! ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}