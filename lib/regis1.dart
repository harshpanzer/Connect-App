import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hierr/data.dart';
import 'package:hierr/homepage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hierr/user_model.dart';
import 'package:hierr/regis.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  @override
  final email = TextEditingController();
  final pass = TextEditingController();
  final usernametextconroller = TextEditingController();
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
    //UserModel loggedInUser = UserModel();

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: scheight,
          width: scwidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/login.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    child: Text(
                      "Register",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scheight * 0.05,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(children: [
                      TextField(
                          controller: usernametextconroller,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(243, 217, 197, 226),
                            filled: true,
                            labelText: "User Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.name),
                      SizedBox(
                        height: scheight * 0.06,
                      ),
                      TextField(
                          controller: email,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(243, 217, 197, 226),
                            filled: true,
                            labelText: "E-mail",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.mail),
                          ),
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(
                        height: scheight * 0.06,
                      ),
                      TextField(
                          controller: pass,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(243, 217, 197, 226),
                            filled: true,
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.password),
                          ),
                          keyboardType: TextInputType.visiblePassword),
                      SizedBox(
                        height: scheight * 0.08,
                      )
                    ])),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 40),
                    ),
                    SizedBox(
                      width: scwidth * 0.38,
                    ),
                    CircleAvatar(
                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email.text, password: pass.text)
                              .then((value) {
                            postDetailsToFirestore();
                            print('Created New Account');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Data(
                                        //userId:loggedInUser.uid,
                                        ))));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: scheight * 0.05,
                ),
                Row(children: [
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        'Already a Existing User?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            color: Color.fromARGB(255, 211, 114, 226)),
                      ))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = usernametextconroller.text;
    print("data taken");

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }
}
