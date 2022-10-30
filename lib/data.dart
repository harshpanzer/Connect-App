import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hierr/user_model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Data extends StatefulWidget {
  String? userId;
  Data({
    super.key,
  });

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  File? image;
  File? image1;
  final phone = TextEditingController();
  final bio = TextEditingController();
  final occupation = TextEditingController();
  String imageurl = " ";
  String imageurl1 = " ";
  String uids = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 100,
      );
      final postID = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child("${user!.uid}/profileimage");

      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) {
        print(value);
        setState(() {
          imageurl = value;
        });
      });

      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future pickimage1() async {
    try {
      final image1 = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 100,
      );
      Reference ref1 = FirebaseStorage.instance
          .ref()
          .child("${user!.uid}/profilecoverimage");
      await ref1.putFile(File(image1!.path));
      ref1.getDownloadURL().then((value1) {
        print(value1);
        setState(() {
          imageurl1 = value1;
        });
      });

      if (image1 == null) return;
      final imageTemporary = File(image1.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text('Profile Credentials'),
        backgroundColor: Color.fromARGB(255, 83, 209, 225),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/data.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              GestureDetector(
                  onTap: () {
                    pickimage1();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    foregroundDecoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/hand.jpg'),
                            fit: BoxFit.cover)),
                  )),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickimage();
                    },
                    child: ClipOval(
                      child: imageurl == " "
                          ? Icon(
                              Icons.person,
                              size: 200,
                            )
                          : Image.network(
                              imageurl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Text(
                    'Edit Photo',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: scheight * 0.06,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                        controller: phone,
                        decoration: InputDecoration(
                          //fillColor: Color.fromARGB(243, 255, 150, 232),
                          filled: true,
                          labelText: "Phone Number",
                          prefixText: '+91',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),

                          prefixIcon: Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                        controller: occupation,
                        decoration: InputDecoration(
                          //fillColor: Color.fromARGB(243, 217, 197, 226),
                          filled: true,
                          labelText: "Organisation Name and Year",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          prefixIcon: Icon(Icons.school),
                        ),
                        keyboardType: TextInputType.name),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: bio,
                      maxLines: 5,
                      decoration: InputDecoration(
                        // fillColor: Color.fromARGB(243, 217, 197, 226),
                        filled: true,
                        labelText: "Bio",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: Icon(Icons.monitor_heart),
                      ),
                    ),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        shadowColor: Colors.lightBlue,
                      ),
                      onPressed: () {
                        postDetailsToFirestore();
                      },
                      child: Text('Submit'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
        (value) => setState(
            () => this.loggedInUser = UserModel.fromMap(value.data())));
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.phoneno = phone.text;
    userModel.organisation = occupation.text;
    userModel.bio = bio.text;
    userModel.uid = user!.uid;
    print("data taken");

    await firebaseFirestore.collection("users").doc(user.uid).update({
      'phoneno': phone.text,
      'organisation': occupation.text,
      'bio': bio.text,
      'imageurl': imageurl,
      'imageurl1': imageurl1,
    });
  }
}
