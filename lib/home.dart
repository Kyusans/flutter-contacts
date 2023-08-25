import 'package:flutter/material.dart';
import 'package:flutter_contact/add_contact.dart';
import 'package:flutter_contact/contact_table.dart';
import 'package:flutter_contact/navbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _openAddContactScreen() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddContact()),
    );
    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Column(children: [
        const SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: _openAddContactScreen,
            child: const Text("Add contact"),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Your contacts",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ContactTable(),
      ]),
      drawer: const Navbar(),
    );
  }
}
