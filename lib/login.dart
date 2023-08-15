import 'dart:convert';
import 'package:flutter_contact/mainhome.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_contact/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String txtUsername = "";
  String txtPassword = "";
  String url = "http://localhost/contact/users.php";
  void login() async {
    Map<String, String> jsonData = {
      "empId": txtUsername,
      "password": txtPassword
    };
    Map<String, String> requestBody = {
      "json": jsonEncode(jsonData)
    };
    var response = await http.post(
      Uri.parse(url),
      body: requestBody,
    );
    if (response.body != "0") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const Mainhome();
      }));
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
