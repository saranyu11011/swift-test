import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swift/Problem3/edit_problem3.dart';
import 'package:swift/Problem3/edit_profile_problem3.dart';

class Detail extends StatefulWidget {
  Detail({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _formKey = GlobalKey<FormState>();
  late String inputName;
  late String inputId;
  late String inputAge;
  late String inputEmail;
  late String inputPhone;
  late String inputImg;
  final Stream<QuerySnapshot> information =
      FirebaseFirestore.instance.collection('information').snapshots();
  final CollectionReference _information =
      FirebaseFirestore.instance.collection("information");
  File? _image;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              height: 80,
              width: 1000,
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0, top: 25),
                        child: Text(
                          "INFORMATION",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: information,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong.');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      margin: const EdgeInsets.only(top: 200),
                      child: const CircularProgressIndicator());
                }
                final data = snapshot.requireData;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                                "${data.docs[widget.index]['img']}"),
                            backgroundColor: Colors.transparent,
                          ),
                          margin: const EdgeInsets.only(top: 20),
                        ),
                        SizedBox(
                          width: 170,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: (RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                //side: BorderSide(color: Colors.red)
                              )),
                              padding: const EdgeInsets.all(20),
                              primary: Colors.blue, // <-- Button color
                              onPrimary: Colors.white, // <-- Splash color
                            ),
                            child: const Text('Change An Image'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          index: widget.index,
                                        )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    BoxInformation(
                        text: "Name : ${data.docs[widget.index]['name']}"),
                    BoxInformation(
                        text:
                            "ID card number : ${data.docs[widget.index]['Id']}"),
                    BoxInformation(
                        text: "Age : ${data.docs[widget.index]['age']}"),
                    BoxInformation(
                        text: "Email : ${data.docs[widget.index]['email']}"),
                    BoxInformation(
                        text:
                            "Phone number : ${data.docs[widget.index]['phone']}"),
                    Container(
                      margin: const EdgeInsets.only(right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditDetail(
                                          index: widget.index,
                                        )),
                              );
                            },
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BoxInformation extends StatefulWidget {
  BoxInformation({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  _BoxInformationState createState() => _BoxInformationState();
}

class _BoxInformationState extends State<BoxInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      width: 600,
      height: 60,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 14),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Text(
        widget.text,
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      ),
    );
  }
}
