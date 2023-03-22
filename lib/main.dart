import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Signup(),
  ));
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

var data = [];

class _SignupState extends State<Signup> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Register Here'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter User Name',
                  filled: true,
                ),
                controller: namecontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  filled: true,
                ),
                controller: emailcontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  filled: true,
                ),
                controller: passwordcontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Gender',
                  filled: true,
                ),
                controller: gendercontroller,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter contact ',
                  filled: true,
                ),
                controller: contactcontroller,
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _Savedata();
              },
              child: Text(
                'REGISTER',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
              },
              child: Text(
                "Otp Verification",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            ),
          ],
        ),
      ),
    );
  }

  _Savedata() async {
    String name = namecontroller.text;
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    String gender = gendercontroller.text;
    String contact = contactcontroller.text;
    var url = Uri.http('akashsir.in', 'myapi/crud/student-add-api.php');
    var response = await http.post(url, body: {
      'st_name': '$name',
      'st_gender': '$gender',
      'st_email': '$email',
      'st_mobileno': '$contact',
      'st_password': '$password',
    });

    print('Response Statuscode: ${response.statusCode}');
    print('Response body: ${response.body}');
    Fluttertoast.showToast(
        msg: 'Your Student Added Successfully', textColor: Colors.blue);

    var data = json.decode(response.body);
    print(response.body);

    var value = data['flag'];
    var value1 = data['user_id'];
    int flag = int.parse(value);

    print('flag = ${flag}');
    print('user_id = ${value1}');

    setState(() {
      if (flag == 1) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Homepage(),
          ),
        );
      } else {
        print('something went wrong');
      }
    });
  }
}
