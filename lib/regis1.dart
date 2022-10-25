import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  @override
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
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
                      radius: 40,
                      child: IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email.text, password:pass).then((value) {
                                Navigator.push(context, Homepage)
                              })
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
}
