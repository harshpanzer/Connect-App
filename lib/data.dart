import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  final name = TextEditingController();
  final bio = TextEditingController();
  Widget build(BuildContext context) {
    double scheight = MediaQuery.of(context).size.height;
    double scwidth = MediaQuery.of(context).size.width;
    Future _getFromGallery() async {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Credentials'),
        backgroundColor: Color.fromARGB(255, 83, 209, 225),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/data.jpg'), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextField(
                controller: name,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(243, 217, 197, 226),
                  filled: true,
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.name),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: bio,
              decoration: InputDecoration(
                fillColor: Color.fromARGB(243, 217, 197, 226),
                filled: true,
                labelText: "Bio",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: Icon(Icons.monitor_heart),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
