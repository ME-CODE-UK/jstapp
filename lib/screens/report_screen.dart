//Import packages
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jstapp/screens/home_screen.dart';
import 'package:jstapp/screens/summary_screen.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
 // Import for MasonryGridView

//Create stateful ReportScreen class
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() {
    return _ReportScreenState();
  }
}

//Creates state class _ReportScreenState for ReportScreen
class _ReportScreenState extends State<ReportScreen> {
  //Set variables
  String _dropValue = 'Unknown';

  final _idController = TextEditingController();
  final _driverController = TextEditingController();
  final _faultController = TextEditingController();
  final _detailsController = TextEditingController();
  final _busEmailController = TextEditingController(); 

  //Creates dispose function to empty form on submission. CURRENTLY UNUSED
  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  //Defines list of common faults. MUST BE UPDATED WITH CORRECT VALUES
  final _commonFaults = [
    'Unknown',
    'Fault one',
    'Fault two',
    'Fault three',
    'Fault four',
    'Fault five',
  ];

  final picker = ImagePicker();
  
  List<File> attachments = [];
  final List<XFile> _imageFiles = [];

  // Function to pick multiple images and display them in a grid
  Future<void> pickImages() async {
    final List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
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

  //Defines _submitReport function to send form data to JST email
  void _submitReport() {
    //Sets user and password variables for the app email
    String email = 'mecodeuk@gmail.com';
    String password = 'zgaw ftnd xphv vtuh';
    //sets controller variables for each input on the form
    String rID = _idController.text;
    String rDriver = _driverController.text;
    String rDetails = _detailsController.text;
    String rBusEmail = _busEmailController.text;

    final smtpServer = gmail(email, password);

    //Checks if any fields have been left empty and tells user to complete them if so
    if (rID == "" || rDriver == "" || rDetails == "" || rBusEmail == ""){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all the fields")));
        return;
    }

    //Sets recipients and sender email address
    final message = Message()
      ..from = Address(email, 'ME CODE UK')
      ..recipients.add('mecodeuk@gmail.com')
      ..ccRecipients.add(rBusEmail)
      ..subject = 'Forklift App Report'
      //Sets text that should be sent in the email. Option to use text is below
      //..text = 'Forklift ID: $rID \nDriver name: $rDriver \nFault type: $_dropValue \n Report information: $rDetails';
      ..html = '<h1>Report</h1><p><b>Forklift ID:</b> $rID<br><b>Driver name:</b> $rDriver<br><b>Fault type:</b> $_dropValue<br><b>Issue:</b> $rDetails</p>';
    
    //Attaches selected images to email message
    for (File imageFile in attachments) {
      message.attachments.add(FileAttachment(imageFile));
    }

    //Sends email
    send(message, smtpServer);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mail Sent Successfully")));

    //Pushes new route onto route stack to send user to summary_screen page
    Navigator.push(
      context, 
      MaterialPageRoute(
        //Passes input variables so they can be used in SummaryScreen
        builder: (context) => SummaryScreen(
          sumID: rID, 
          sumDriver: rDriver, 
          sumDetails: rDetails, 
          sumFault: _dropValue, 
          sumEmail: rBusEmail,
        ),
      ),
    );
  }

  //Builds ReportScreen widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        //Creates appbar with back button
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            //Pops route off navigator stack to return user to home_screen
            onPressed: () => Navigator.of(context).pop(false),
          ),
          backgroundColor: Colors.black,
          //Sets text for back button
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
        //Creates container with gradient for background colour
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            // Background Colour
            gradient: LinearGradient(
              colors: [
                Color(0xffffffff),
                Color(0xffc0c0c0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // Sets padding for scroll view
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
              bottom: 15
            ),
            // Creates a scroll view to contain the entire form
            child: SingleChildScrollView(
              //Creates column widget to display all elements in a vertical column
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
                            Text(textAlign: TextAlign.left, 'Suspected fault'),
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
                              //Maps each value from the _commonFaults list onto the items list and adds each value as an option on the dropdown menu
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
                        //Creates a scrollable text field for details input
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
                                  'Please describe the issue',
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
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: pickImages,
                    icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
                    label: const Text(
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        'Select Images',
                      ),
                  ),
                  // Image grid with delete functionality
                  _imageFiles.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MasonryGridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
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
                      : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                        ),
                        'No Images Selected',
                      ),
                      ),
                  
                  // Submit Button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: _submitReport,
                      child: const Text(
                        style: TextStyle(
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
      ),
    );
  }
}