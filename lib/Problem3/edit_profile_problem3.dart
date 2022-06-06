import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final Stream<QuerySnapshot> information =
      FirebaseFirestore.instance.collection('information').snapshots();
  File? _image;
  final CollectionReference _information =
      FirebaseFirestore.instance.collection("information"); //อันนอ
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
                          "EDIT PROFILE",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius: 180.0,
                            backgroundImage: NetworkImage(
                                "${data.docs[widget.index]['img']}"),
                            backgroundColor: Colors.transparent,
                          ),
                          margin: const EdgeInsets.only(top: 20, bottom: 40),
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
                            onPressed: _openImagePicker,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              //_openImagePicker();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Processing data please wait a moment')),
                              );
                              DateTime now = DateTime.now();
                              String formattedDate =
                                  DateFormat('kk:mm:ss').format(now);
                              Reference ref = FirebaseStorage.instance
                                  .ref()
                                  .child('test/imageName$formattedDate');
                              await ref.putFile(File(_image!.path));
                              String imageUrl = await ref.getDownloadURL();

                              await _information
                                  .doc(data.docs[widget.index]['Id'])
                                  .update({'img': imageUrl});

                              Navigator.of(context).pop();
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
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
