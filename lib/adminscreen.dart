import 'package:flutter/material.dart';

class Adminscreen extends StatefulWidget {
  const Adminscreen({Key? key}) : super(key: key);

  @override
  State<Adminscreen> createState() => _AdminscreenState();
}

class _AdminscreenState extends State<Adminscreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  String id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Admin Page'),
      ),
    );
  }
}
