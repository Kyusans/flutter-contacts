import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to my contact app! practice ra bitaw ni sa flutter hehehehe",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              "Developer:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Mel Macario"),
            Text("Email: xmelmacario@gmail.com"),
            SizedBox(height: 16),
            Text(
              "Features",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('• Add, edit, and delete contacts'),
            Text('• Search for contacts by name or phone number'),
            SizedBox(height: 16),
            Text(
              "Contact u̶s̶ me",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('If you have any questions, feedback, or support requests,'),
            Text('please email u̶s̶ me at xmelmacario@gmail.com'),
          ],
        ),
      ),
    );
  }
}
