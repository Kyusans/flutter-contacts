import 'package:flutter/material.dart';
import 'package:flutter_contact/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactTable extends StatefulWidget {
  const ContactTable({Key? key}) : super(key: key);

  @override
  _ContactTableState createState() => _ContactTableState();
}

class _ContactTableState extends State<ContactTable> {
  late List<Map<String, dynamic>> contact;
  void getContact() async {
    Map<String, String> requestBody = {
      "operation": "getContact"
    };

    var response = await http.post(
      Uri.parse("${ApiConstant.baseUrl}users.php"),
      body: requestBody,
    );

    contact = response.body != "0" ? List<Map<String, dynamic>>.from(json.decode(response.body)) : [];
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Mobile number")),
        DataColumn(label: Text("Address")),
        DataColumn(label: Text("Email")),
      ],
      rows: [],
    );
  }
}
