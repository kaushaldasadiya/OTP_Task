import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_21/main.dart';
import 'package:flutter_application_21/otp.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController mobilecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ));
                },
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.cyan,
            title: Text('Enter Mobile number'),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Enter Mobile Number', filled: true),
                  controller: mobilecontroller,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _sendotp();
                },
                child: Text("Send OTP",
                    style: TextStyle(fontStyle: FontStyle.italic)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              )
            ]),
          )),
    );
  }

  void _sendotp() async {
    var url = Uri.parse('https://akashsir.in/myapi/crud/login-with-otp.php');
    var response = await http.post(url, body: {
      'st_mobileno': mobilecontroller.text,
      'st_name': 'kaushal',
    });

    print("Response Statuscode: ${response.statusCode}");
    print("Response body: ${response.body}");

    var data = json.decode(response.body);
    var value = data['flag'];
    var value1 = data['user_id'];
    int flag = int.parse(value);
    print('user_id = ${value1}');
    print('flag = ${flag}');

    setState(() {
      if (flag == 1) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const otp(),
          ),
        );
      } else {
        print('something went wrong');
      }
    });
  }
}
