import 'package:flutter/material.dart';
import 'package:flutter_contact/about.dart';
import 'package:flutter_contact/home.dart';
import 'package:flutter_contact/main.dart';
import 'package:flutter_contact/session_storage.dart';
import 'package:flutter_contact/user_profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  SessionStorage sessionStorage = SessionStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            accountName: Text(SessionStorage.username),
            accountEmail: Text(SessionStorage.userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/image/${SessionStorage.userImage}"),
            ),
          ),
          ListTile(
            title: const Text("My Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
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
          const Divider(),
          ListTile(
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              sessionStorage.setUserInformation("", "", "", "");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Index(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
