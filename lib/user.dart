import 'package:flutter/material.dart';
import 'package:hierr/homepage.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                    context, MaterialPageRoute(builder: ((context) => User())));
              },
            )
          ],
        ),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
