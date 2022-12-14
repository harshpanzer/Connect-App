import 'package:flutter/material.dart';
import 'package:hierr/data.dart';
import 'package:hierr/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hierr/regis.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(),
          ),
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
                  style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Homepage())));
                },
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 254)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Userscreen())));
                },
              ),
              ListTile(
                title: Text('Sign Out',
                    style:
                        TextStyle(color: Color.fromARGB(255, 251, 251, 251))),
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
                        child: loggedInUser.imageurl1 == " "
                            ? Container(
                                height: scheight * 0.25,
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("asset/hand.jpg"),
                                        fit: BoxFit.cover)),
                                child: ClipOval(
                                  child: loggedInUser.imageurl == " "
                                      ? Icon(
                                          Icons.person,
                                          size: 200,
                                        )
                                      : Image.network(
                                          "${loggedInUser.imageurl}",
                                          width: 200,
                                          height: 200,
                                          
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              )
                            : Container(
                                height: scheight * 0.25,
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${loggedInUser.imageurl1}"),
                                        fit: BoxFit.cover)),
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    child: ClipOval(
                                      child: loggedInUser.imageurl == " "
                                          ? Icon(
                                              Icons.person,
                                              size: 200,
                                            )
                                          : Image.network(
                                              "${loggedInUser.imageurl}",
                                              width: 2,
                                              height: 2,
                                              fit: BoxFit.cover,
                                            ),
                                    ))

                                /* ClipOval(
              child: Image.network(
                ("${loggedInUser.imageurl}"),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),*/
                                ),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: scwidth,
                    child: IconButton(
                      onPressed: (() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => Data())));
                      }),
                      icon: Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 142, 222, 242),
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

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
