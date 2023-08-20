import 'dart:convert';
import 'package:flutter_contact/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_contact/session_storage.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _fullNametxt = TextEditingController();
  final TextEditingController _mobileNumbertxt = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _email = TextEditingController();

  void addContact() async {
    Map<String, String> jsonData = {
      "fullName": _fullNametxt.text,
      "mobileNumber": _mobileNumbertxt.text,
      "address": _address.text,
      "email": _email.text,
      "userId": SessionStorage.userId,
    };
    Map<String, String> requestBody = {
      "json": jsonEncode(jsonData),
      "operation": "addContact",
    };

    var response = await http.post(
      Uri.parse("${ApiConstant.baseUrl}users.php"),
      body: requestBody,
    );

    if (response.body == "1") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Success!"),
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Failed!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add contact'),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: _fullNametxt,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Full Name",
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
              controller: _mobileNumbertxt,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mobile Number",
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
              controller: _address,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Address",
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
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                }),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  addContact();
                },
                child: const Text("Save"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
