import 'package:attendance_app/homescreen.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/model/user.dart';
import 'adminscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required AuthCheck child}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  String name = "";

  Color primary = const Color(0xffeef444c);

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // isKeyboardVisible ? SizedBox(height: screenHeight / 16,) : Container(
          //   height: screenHeight / 2.5,
          //   width: screenWidth,
          //   decoration: BoxDecoration(
          //     color: primary,
          //     borderRadius: BorderRadius.only(
          //       bottomRight: Radius.circular(70),
          //     ),
          //   ),
          //   child:
          Center(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: screenWidth / 5,
            ),
          ),
          // ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
              bottom: screenHeight / 20,
            ),
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontFamily: "NexaBold",
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fieldTitle("Employee ID"),
                customField("Enter your employee id", idController, false),
                fieldTitle("Password"),
                customField("Enter your password", passController, true),
                GestureDetector(
                  onTap: () async {
                    String id = idController.text.trim();
                    String password = passController.text.trim();

                    if (id.isEmpty) {
                      Fluttertoast.showToast(msg: "Employee ID is empty!");
                    } else if (password.isEmpty) {
                      Fluttertoast.showToast(msg: "Password is empty!");
                    } else if (id == 'admin' && password == 'admin') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Adminscreen()));
                    } else {
                      QuerySnapshot snap = await FirebaseFirestore.instance
                          .collection("Employee")
                          .where('id', isEqualTo: id)
                          .where('password', isEqualTo: password)
                          .get();

                      try {
                        if (password == snap.docs[0]['password']) {
                          id == snap.docs[0]['id'];
                          Fluttertoast.showToast(msg: "Welcome employee $id");
                          // ignore: avoid_print
                          print("continue");

                          User.employeeId = id;
                          User.name = snap.docs[0]['Name'];
                          sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences
                              .setString('employeeId', id)
                              .then((_) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Homescreen()));
                          });
                        } else {
                          Fluttertoast.showToast(msg: "Password is wrong!");
                        }
                      } catch (e) {
                        // ignore: avoid_print
                        print(e.toString());
                        String error = " ";
                        if (e.toString() ==
                            "RangeError (index): Invalid value: Valid value range is empty: 0") {
                          setState(() {
                            error = "Employee id does not exist!";
                          });
                        } else {
                          setState(() {
                            error = "Error occured!";
                          });
                        }

                        Fluttertoast.showToast(msg: error);
                      }
                    }
                  },
                  child: Container(
                    height: 60,
                    width: screenWidth,
                    margin: EdgeInsets.only(top: screenHeight / 40),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 26,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "NexaBold",
        ),
      ),
    );
  }

  Widget customField(
      String hint, TextEditingController controller, bool obscureText) {
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 8,
            child: Icon(
              Icons.person,
              color: primary,
              size: screenWidth / 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
