import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Import for MasonryGridView

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() {
    return _ReportScreenState();
  }
}

class _ReportScreenState extends State<ReportScreen> {
  String _dropValue = 'Fault one';

  final _idController = TextEditingController();
  final _driverController = TextEditingController();
  final _faultController = TextEditingController();
  final _detailsController = TextEditingController();
  final _busEmailController = TextEditingController(); 

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }


  final _commonFaults = [
    'Fault one',
    'Fault two',
    'Fault three',
    'Fault four',
    'Fault five',
  ];

  File? _image;
  final picker = ImagePicker();
  
  List<File> attachments = [];
  List<XFile> _imageFiles = [];

  // Function to pick multiple images and display them in a grid
  Future<void> pickImages() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFiles.addAll(selectedImages);
        for (var image in selectedImages) {
          attachments.add(File(image.path));
        }
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
      attachments.removeAt(index); // Also remove the image from attachments list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // Back Button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          // Background Colour
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1),
              Color.fromARGB(255, 197, 197, 197),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Scroll View Padding
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: 15
          ),
          // Scroll View
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Forklift ID Text Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Forklift ID',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      TextField(
                        controller: _idController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Please enter the ID of the vehicle',
                        ),
                      ),
                    ],
                  ),
                ),
                // Driver Name Text Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text('Driver name'),
                        ],
                      ),
                      TextField(
                        controller: _driverController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Please enter your name',
                        ),
                      ),
                    ],
                  ),
                ),
                // Type of Fault Dropdown
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(textAlign: TextAlign.left, 'Type of Fault'),
                        ],
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: const Color.fromARGB(255, 122, 122, 122),
                              width: 1,
                            )),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: _commonFaults.map((String item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item));
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropValue = newValue!;
                              });
                            },
                            value: _dropValue,
                            isExpanded: true,
                            iconSize: 36,
                            menuMaxHeight: 200,
                            isDense: true,
                          ),
                        ),
                      ),
                      //),
                    ],
                  ),
                ),
                // Details Text Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text('Details'),
                        ],
                      ),
                      Scrollbar(
                        child: TextFormField(
                          controller: _detailsController,
                          minLines: 4,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            border: OutlineInputBorder(),
                            hintText:
                                'Please use this space to provide any useful details about the issue',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Business Email Text Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Business email',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Focus(
                        child: TextField(
                          controller: _busEmailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Please enter the email through which you would like us to contact you',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add Image Picker Grid
                ElevatedButton(
                  onPressed: pickImages,
                  child: Text('Pick Images'),
                ),
                // Image grid with delete functionality
                _imageFiles.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MasonryGridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns
                          ),
                          itemCount: _imageFiles.length,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                // Display the image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    File(_imageFiles[index].path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : const Text('No images selected.'),
                
                // Submit Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      String email = 'mecodeuk@gmail.com';
                      String password = 'zgaw ftnd xphv vtuh';
                      String rID = _idController.text;
            
                      final smtpServer = gmail(email, password);
            
                      final message = Message()
                        ..from = Address(email, 'ME CODE UK')
                        ..recipients.add('mecodeuk@gmail.com')
                        ..subject = 'Forklift App Report'
                        ..text =
                            'Forklift ID: This is a test email using the word: $rID to see if this email sends from correct sender and is received to correct receiver';
                        // ..html = '<h1>Hello</h1>\n<p>Hey!</p><img src="cid:myimg">'
                        
                      for (File imageFile in attachments) {
                        message.attachments.add(FileAttachment(imageFile));
                      }
            
                      final sendReport = send(message, smtpServer);
                      print('Message sent: ' + sendReport.toString());
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Mail Sent Successfully")));
                    },
                    child: const Text(
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                      'SUBMIT',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}