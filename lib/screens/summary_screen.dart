//Import packages
import 'package:flutter/material.dart';

//Create stateless SummaryScreen widget
class SummaryScreen extends StatelessWidget {
  const SummaryScreen(
      {super.key,
      required this.sumID,
      required this.sumDriver,
      required this.sumDetails,
      required this.sumFault,
      required this.sumEmail});
  final String sumID;
  final String sumDriver;
  final String sumFault;
  final String sumDetails;
  final String sumEmail;

  //Build widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back Button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            //Pops route stack twice to return user to home_screen
            Navigator.of(context).pop(false);
            Navigator.of(context).pop(false);
          }
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Return to Home',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //Creates container with linear gradient for the background colour
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
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  //Stacks two text widgets on top of eachother to give bordered text effect
                  /*child: Stack(
                    children: <Widget>[
                      //Border text
                      Text(
                        'Report Summary',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.black),
                      ),
                      //Inner text
                      const Text(
                        'Report Summary',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          //color: Color(0xffff004d)
                          color: Color(0xffc0c0c0),
                        ),
                      ),
                    ],
                  ),*/
                  child: Text(
                    'Report Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Creates column containing several Row widgets. Each row widget is used to hold a Label and the submitted input text
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      //Each row contains two expanded elements to allow the label and text to each take up 50% of the width
                      child: Row(
                        children: [
                          //Forklift ID label
                          const Expanded(
                            child: Text(
                              'Forklift ID:',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          //Forklift ID text
                          Expanded(
                            child: Text(sumID),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          //Driver name label
                          const Expanded(
                            child: Text(
                              'Driver name:',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          //Driver name text
                          Expanded(
                            child: Text(sumDriver),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          //Fault type label
                          const Expanded(
                            child: Text(
                              'Fault type:',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          //Fault type text
                          Expanded(
                            child: Text(sumFault),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          //Email label
                          const Expanded(
                            child: Text(
                              'Email:',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                              ),
                            ),
                          ),
                          //Email text
                          Expanded(
                            child: Text(sumEmail),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          //Details label created in a column with a spaced box to position label at top left of details text 
                          const Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Details:',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 85,
                                  ),
                                ],
                              ),
                          ),
                          //Details text created in a scroll view to allow for large amounts of text
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 100,
                                minHeight: 100
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(sumDetails),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
