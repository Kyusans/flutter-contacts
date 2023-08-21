import 'package:flutter/material.dart';
import 'package:flutter_contact/about.dart';
import 'package:flutter_contact/home.dart';
import 'package:flutter_contact/main.dart';
import 'package:flutter_contact/session_storage.dart';

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
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          accountName: Text(SessionStorage.userFullName),
          accountEmail: Text(SessionStorage.userEmail),
          currentAccountPicture: const CircleAvatar(
            backgroundImage: AssetImage("assets/image/myImage.jpg"),
          ),
        ),
        ListTile(
          title: const Text("Home"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text("About"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const About(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
