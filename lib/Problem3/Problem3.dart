import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'detail_problem3.dart';

class Problem3 extends StatefulWidget {
  const Problem3({Key? key}) : super(key: key);

  @override
  _Problem3State createState() => _Problem3State();
}

class _Problem3State extends State<Problem3> {
  late String inputName;
  late String inputId;
  late String inputAge;
  late String inputEmail;
  late String inputPhone;
  late String inputImg;

  //final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final Stream<QuerySnapshot> information =
      FirebaseFirestore.instance.collection('information').snapshots();
  final CollectionReference _information =
      FirebaseFirestore.instance.collection("information");
  final _formKey = GlobalKey<FormState>();
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Your information',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 460,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name correctly.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (String value) {
                            inputName = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 13) {
                              return 'Please enter Id card correctly.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.badge),
                              labelText: 'ID Card Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (String value) {
                            inputId = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 3) {
                              return 'Please enter your age correctly.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.face),
                              labelText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (String value) {
                            inputAge = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) => val!.isEmpty || !val.contains("@")
                              ? "Please enter your email correctly."
                              : null,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (String value) {
                            inputEmail = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'Please enter your age correctly.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.call),
                              labelText: 'Phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          onChanged: (String value) {
                            inputPhone = value;
                          },
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              //side: BorderSide(color: Colors.red)
                            )),
                            padding: const EdgeInsets.all(20),
                            primary: Colors.blue, // <-- Button color
                            onPrimary: Colors.white, // <-- Splash color
                          ),
                          child: const Text('Select An Image'),
                          onPressed: _openImagePicker,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                                  padding: const EdgeInsets.all(20),
                                  primary: Colors.blue, // <-- Button color
                                  onPrimary: Colors.white, // <-- Splash color
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                                padding: const EdgeInsets.all(20),
                                primary: Colors.blue, // <-- Button color
                                onPrimary: Colors.white, // <-- Splash color
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Processing data please wait a moment.')),
                                  );
                                  DateTime now = DateTime.now();
                                  String formattedDate =
                                      DateFormat('kk:mm:ss').format(now);
                                  Reference ref = FirebaseStorage.instance
                                      .ref()
                                      .child('test/imageName$formattedDate');
                                  await ref.putFile(File(_image!.path));
                                  String imageUrl = await ref.getDownloadURL();

                                  _information.doc(inputId).set({
                                    'name': inputName,
                                    'Id': inputId,
                                    'age': inputAge,
                                    'email': inputEmail,
                                    'phone': inputPhone,
                                    'img': imageUrl
                                  });

                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: const <Widget>[],
        );
      },
    );
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
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0, top: 30),
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

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 5, left: 20, right: 20),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            title: Text("Name : ${data.docs[index]['name']}"),
                            leading: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detail(index: index)),
                                );
                              },
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _information
                                    .doc("${data.docs[index]['Id']}")
                                    .delete();
                              },
                            )),
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
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
                  onPressed: () {
                    //print("tap");
                    _showMyDialog();
                    // _todo.add({'todo': 'work 8 hr'});
                  },
                  child: const Text("Add new information?")),
            )
          ],
        ),
      ),
    );
  }
}
