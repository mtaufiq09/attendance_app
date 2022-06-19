import 'package:attendance_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = 0;
    double screenWidth = 0;

    Color primary = const Color(0xffeef444c);

    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              "My Attendance",
              style: TextStyle(
                fontFamily: "NexaBold",
                fontSize: screenWidth / 18,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  DateFormat('MMMM').format(DateTime.now()),
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Pick a Month",
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight / 1.45,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Employee")
                  .doc(User.id)
                  .collection("Record")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 12,
                          left: 6,
                          right: 6,
                        ),
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Check In",
                                    style: TextStyle(
                                      fontFamily: "NexaRegular",
                                      fontSize: screenWidth / 20,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    snap[index]['checkIn'],
                                    style: TextStyle(
                                      fontFamily: "NexaBold",
                                      fontSize: screenWidth / 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Check Out",
                                      style: TextStyle(
                                        fontFamily: "NexaRegular",
                                        fontSize: screenWidth / 20,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      snap[index]['checkOut'],
                                      style: TextStyle(
                                        fontFamily: "NexaBold",
                                        fontSize: screenWidth / 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
