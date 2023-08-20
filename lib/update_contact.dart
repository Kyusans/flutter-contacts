import 'dart:convert';
import 'package:flutter_contact/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({Key? key, required this.conId}) : super(key: key);
  final int conId;

  @override
  _UpdateContactState createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  @override
  void initState() {
    getSelectedContact();
    super.initState();
  }

  void _updateContact() async {
    Map<String, dynamic> jsonData = {
      "fullName": _fullNameController.text,
      "mobileNumber": _mobileNumberController.text,
      "address": _addressController.text,
      "email": _emailController.text,
      "conId": widget.conId
    };
    Map<String, String> requestBody = {
      "operation": "updateContact",
      "json": jsonEncode(jsonData),
    };
    var response = await http.post(
      Uri.parse("${ApiConstant.baseUrl}users.php"),
      body: requestBody,
    );
    if (response.body == "1") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success! Contact Updated"),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  Future<void> getSelectedContact() async {
    Map<String, dynamic> jsonData = {
      "conId": widget.conId,
    };
    Map<String, String> requestBody = {
      "operation": "selectContact",
      "json": jsonEncode(jsonData),
    };
    var response = await http.post(
      Uri.parse("${ApiConstant.baseUrl}users.php"),
      body: requestBody,
    );
    Map<String, dynamic> resData = json.decode(response.body);
    if (response.body != "0") {
      _fullNameController.text = resData["con_fullName"];
      _mobileNumberController.text = resData["con_mobileNumber"];
      _addressController.text = resData["con_address"];
      _emailController.text = resData["con_email"];
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update contact'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            child: Column(children: [
              TextFormField(
                controller: _fullNameController,
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
                controller: _mobileNumberController,
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
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "address",
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
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "email",
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
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _updateContact();
                  },
                  child: const Text("Update"),
                ),
              )
            ]),
          )),
    );
  }
}
