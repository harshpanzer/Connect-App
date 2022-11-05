import 'package:flutter/material.dart';
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
