import 'dart:convert';
import 'package:flutter_contact/api_constants.dart';
import 'package:flutter_contact/home.dart';
import 'package:flutter_contact/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_contact/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final SessionStorage sessionStorage = SessionStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String txtUsername = "";
  String txtPassword = "";
  void login() async {
    Map<String, String> jsonData = {
      "username": txtUsername,
      "password": txtPassword
    };
    Map<String, String> requestBody = {
      "json": jsonEncode(jsonData),
      "operation": "login"
    };
    var response = await http.post(
      Uri.parse("${ApiConstant.baseUrl}users.php"),
      body: requestBody,
    );
    if (response.body != "0" || response.body.isEmpty) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      dynamic userId = responseBody["user_id"].toString();
      dynamic username = responseBody["user_username"].toString();
      dynamic userEmail = responseBody["user_email"].toString();
      dynamic userImage = responseBody["user_image"].toString();
      sessionStorage.setUserInformation(userId, username, userEmail, userImage);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid username or password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  txtUsername = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              onChanged: (value) {
                txtPassword = value;
              },
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                  child: const Text("Login")),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: screenHeight * 0.055,
              width: screenWidth * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("Sign up"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
