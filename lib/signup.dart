import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String txtUsername = "";
  String txtPassword = "";
  String txtEmail = "";
  String url = "http://localhost/contact/users.php";
  void signup() async {
    Map<String, String> jsonData = {
      "username": txtUsername,
      "password": txtPassword,
      "email": txtEmail,
    };
    Map<String, String> requestBody = {
      "json": jsonEncode(jsonData),
      "operation": "signup",
    };

    var response = await http.post(
      Uri.parse(url),
      body: requestBody,
    );
    print("Response body" + response.body);
    if (response.body == "1") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success!"),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(children: [
            TextFormField(
              onChanged: (value) {
                txtUsername = value;
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
              obscureText: _isObscure,
              onChanged: (value) {
                txtPassword = value;
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
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
                txtEmail = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signup();
                    }
                  },
                  child: const Text("Signup")),
            ),
          ]),
        ),
      ),
    );
  }
}
