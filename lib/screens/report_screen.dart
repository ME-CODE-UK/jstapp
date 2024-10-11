import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() {
    return _ReportScreenState();
  }
}

class _ReportScreenState extends State<ReportScreen> {
  String _dropValue = 'Fault one';

  final _commonFaults = [
    'Fault one',
    'Fault two',
    'Fault three',
    'Fault four',
    'Fault five',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        backgroundColor: Colors.black,
        title: Text(
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
          padding: EdgeInsets.all(50),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: 310,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: DropdownButton(
                      items: _commonFaults.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropValue = newValue!;
                        });
                      },
                      value: _dropValue,
                    ),
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

                    final smtpServer = gmail(email, password);

                    final message = Message()
                    ..from = Address(email, 'ME CODE UK')
                    ..recipients.add('mecodeuk@gmail.com')
                    ..subject = 'Test Mail'
                    ..text = 'This is a test email to see if this email sends from correct sender and is received to correct receiver'
                    ;

                    final sendReport = send(message, smtpServer);
                    print('Message sent: ' + sendReport.toString());
                    ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Mail Sent Successfully")));

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
    );
  }
}


sendEmail (BuildContext context) async {
    String email = 'mecodeuk@gmail.com';
    String password = 'xxxxxxxxxxx';
    print('InSendEmailFunction');

    final smtpServer = gmail(email, password);

    final message = Message()
    ..from = Address(email, 'ME CODE UK')
    ..recipients.add('mecodeuk@gmail.com')
    ..subject = 'Test Mail'
    ..text = 'This is a test email to see if this email sends from correct sender and is received to correct receiver'
    ;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Mail Sent Successfully")));
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }