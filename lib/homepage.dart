import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hierr/jobdet.dart';
import 'package:hierr/regis.dart';
import 'package:hierr/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
    final title = TextEditingController();
    final detail = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: Color.fromARGB(255, 93, 213, 127),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 205, 163, 244),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/hand.jpg'),
                        fit: BoxFit.cover)),
                child: Text('Index')),
            ListTile(
              title: Text(
                'Explore',
                style: TextStyle(color: Color.fromARGB(255, 252, 252, 252)),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Homepage())));
              },
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Userscreen())));
              },
            ),
            ListTile(
              title: Text('Sign Out',
                  style: TextStyle(color: Color.fromARGB(255, 254, 255, 253))),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Login())));
              },
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Row(
              children: [
                ListView(),
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),

                // Text(
                //   'Sign In',
                //   style: TextStyle(fontSize: 40),
                // ),
                // SizedBox(
                //   width: scwidth * 0.38,
                // ),
                // CircleAvatar(
                //   radius: 40,
                //   child: IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: ((context) => JobDetails())));
                //     },
                //     icon: Icon(Icons.arrow_forward),
                //   ),
                // )
              ],
            )
          ],
        ),
      )),
    );
  }
}
