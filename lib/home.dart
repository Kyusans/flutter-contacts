import 'package:flutter/material.dart';
import 'package:flutter_contact/contact_table.dart';
import 'package:flutter_contact/navbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          child: ElevatedButton(onPressed: () {}, child: const Text("Add contact")),
        ),
        const SizedBox(
          height: 16,
        ),
        const ContactTable(),
      ]),
      drawer: const Navbar(),
    );
  }
}
