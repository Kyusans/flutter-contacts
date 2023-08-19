import 'package:flutter/material.dart';
import 'package:flutter_contact/api_constants.dart';
import 'package:flutter_contact/session_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactTable extends StatefulWidget {
  const ContactTable({Key? key}) : super(key: key);

  @override
  _ContactTableState createState() => _ContactTableState();
}

class _ContactTableState extends State<ContactTable> {
  void updateContactList() {
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> getContact() async {
    Map<String, String> jsonData = {
      "userId": SessionStorage.userId
    };
    Map<String, String> requestBody = {
      "json": jsonEncode(jsonData),
      "operation": "getContact"
    };
    final response = await http.post(Uri.parse("${ApiConstant.baseUrl}users.php"), body: requestBody);
    return response.body != "0" ? List<Map<String, dynamic>>.from(json.decode(response.body)) : [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getContact(),
      builder: (context, snapshot) {
        final contact = snapshot.data ?? [];
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Mobile number")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: contact.isEmpty
                    ? [
                        const DataRow(cells: [
                          DataCell(Text("No data found")),
                          DataCell(Text("")),
                          DataCell(Text("")),
                          DataCell(Text("")),
                          DataCell(Text(""))
                        ])
                      ]
                    : contact.map((contacts) {
                        return DataRow(
                          cells: [
                            DataCell(Text(contacts["con_fullName"])),
                            DataCell(Text(contacts["con_mobileNumber"])),
                            DataCell(Text(contacts["con_address"])),
                            DataCell(Text(contacts["con_email"])),
                            DataCell(Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Update"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                  child: const Text("Delete"),
                                ),
                              ],
                            ))
                          ],
                        );
                      }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
