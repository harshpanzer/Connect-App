import 'package:flutter/material.dart';
import 'package:hierr/data.dart';
import 'package:hierr/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hierr/user_model.dart';
import 'package:flutter/services.dart';

class Userscreen extends StatefulWidget {
  const Userscreen({super.key});

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color.fromARGB(255, 93, 213, 127),
        ),
        drawer: Drawer(
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
                title: Text('Explore'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Homepage())));
                },
              ),
              ListTile(
                title: Text('Me'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Userscreen())));
                },
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
              height: scheight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/profile.webp"), fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  height: scheight * 0.25,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      Container(
                        height: scheight * 0.25,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 188, 64)),
                        child: Container(
                          height: scheight * 0.25,
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('asset/hand.jpg'),
                                  fit: BoxFit.cover)),
                          child: CircleAvatar(
                            radius: scwidth * 0.1,
                            backgroundImage: NetworkImage(
                              "${loggedInUser.imageurl}",
                            ),
                          ),
                        ),

                        /* ClipOval(
              child: Image.network(
                ("${loggedInUser.imageurl}"),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),*/
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: scheight * 0.05,
                ),
                Container(
                  child: Text(
                    "${loggedInUser.userName}",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 248, 248, 248)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "(${loggedInUser.organisation})",
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 241, 242, 243),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Bio",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 30,
                        color: Color.fromARGB(255, 4, 53, 102),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "${loggedInUser.bio}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 254, 255, 249),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Contact Me",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 30,
                        color: Color.fromARGB(255, 4, 53, 102),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Email:-${loggedInUser.email}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 241, 242, 243),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Phone No.:-${loggedInUser.phoneno}",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 241, 242, 243),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                    child: IconButton(
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Data())));
                  }),
                  icon: Text(
                    "EditProfile",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 241, 242, 243),
                        fontWeight: FontWeight.w900),
                  ),
                ))
              ]))),
        ));
  }

  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
}
