import 'package:flutter/material.dart';
import 'package:hierr/user.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final title = TextEditingController();
  final detail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
    final title = TextEditingController();
    final detail = TextEditingController();
    return (Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    //fillColor: Color.fromARGB(243, 255, 150, 232),
                    filled: true,
                    labelText: "Job Title",
                    prefixText: '+91',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),

                    prefixIcon: Icon(Icons.corporate_fare),
                  ),
                  keyboardType: TextInputType.number),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextField(
                  controller: detail,
                  decoration: InputDecoration(
                    //fillColor: Color.fromARGB(243, 217, 197, 226),
                    filled: true,
                    labelText: "Job Details",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(Icons.school),
                  ),
                  keyboardType: TextInputType.name),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  // side: BorderSide(color: Colors.yellow, width: 5),
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontStyle: FontStyle.normal),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  shadowColor: Colors.lightBlue,
                ),
                onPressed: () {
                  saveToDatabase();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Userscreen())));
                },
                child: Text('Submit'))
          ],
        ),
      )),
    ));
  }

  void saveToDatabase() async {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    User? user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var data = {
      "title": title.text,
      "detail": detail.text,
      "date": date,
      "time": time,
    };
    await firebaseFirestore.collection("post").doc(user!.uid).set(data);
  }
}
