import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        title: Text('Admin Page'),
      ),
    );
  }
}
