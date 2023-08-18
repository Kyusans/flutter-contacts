import 'package:flutter/material.dart';
import 'package:flutter_contact/main.dart';
import 'login.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Text("Sidebar"),
        ),
        ListTile(
          title: const Text("Home"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Index()));
          },
        )
      ]),
    );
  }
}
