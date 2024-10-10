
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Back',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Forklift ID'),
                    border: OutlineInputBorder(),
                    hintText: 'Please enter the ID of the vehicle',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Driver name'),
                    border: OutlineInputBorder(),
                    hintText: 'Please enter your name',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('<replace with drop down>'),
                    border: OutlineInputBorder(),
                    hintText: 'Placeholder text',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Scrollbar(
                  child: TextFormField(
                    minLines: 4,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20
                      ),
                      label: Text('Details'),
                      border: OutlineInputBorder(),
                      hintText: 'Please use this space to provide any useful details about the issue',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
