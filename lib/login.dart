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
                    if (_formKey.currentState!.validate()) {}
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
