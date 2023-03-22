import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_21/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class otp extends StatefulWidget {
  const otp({super.key});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  TextEditingController mobilecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.cyan,
          title: Text("OTP Verification"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1409957041/vector/3d-vector-mobile-security-with-password-pin-code-concept-design-stock-illustration.jpg?s=612x612&w=0&k=20&c=KGT6A8lbfqN5gcFoQvU7SDtoljDH2zK8XrdXMXKFxIo="))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Enter 4 Digit Code Here'),
                  controller: mobilecontroller,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    _verifyotp();
                  },
                  child: const Text("Submit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyotp() async {
    var url = Uri.parse('https://akashsir.in/myapi/crud/verify-mobile-otp.php');
    var response = await http.post(url, body: {
      'st_mobileno': '8306180003',
      'mobile_otp': mobilecontroller.text,
    });
    var data = json.decode(response.body);

    var value = data['flag'];
    int flag = int.parse(value);

    print("Response Statuscode: ${response.statusCode}");
    print("Response Body : ${response.body}");
    print('flag = ${flag}');
    Fluttertoast.showToast(
        msg: 'Your OTP Verified Successfully', textColor: Colors.blue);
  }
}
