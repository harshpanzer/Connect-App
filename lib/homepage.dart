import 'package:flutter/material.dart';
import 'package:hierr/regis.dart';
import 'package:hierr/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomePageFetch homePageFetch = new HomePageFetch();
  late QuerySnapshot adSnapshot;

  @override
  void Fetchdatasnap() {
    homePageFetch.getData().then((result) {
      adSnapshot = result;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
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
          children: [],
        ),
      )),
    );
  }
}

class HomePageFetch {
  Future<void> addData(homeData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(homeData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }
}
