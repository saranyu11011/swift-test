import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDetail extends StatefulWidget {
  EditDetail({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
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

  final _formKey = GlobalKey<FormState>();

  final Stream<QuerySnapshot> information = FirebaseFirestore.instance
      .collection('information')
      .snapshots(); //เข้าไปข้างใน หา index ทีละอัน
  final CollectionReference _information =
      FirebaseFirestore.instance.collection("information"); //อันนอกสุด
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                            "EDIT INFORMATION",
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
                  // set initial value
                  final data = snapshot.requireData;
                  late String inputName = "${data.docs[widget.index]['name']}";
                  late String inputId = "${data.docs[widget.index]['Id']}";
                  late String inputAge = "${data.docs[widget.index]['age']}";
                  late String inputEmail =
                      "${data.docs[widget.index]['email']}";
                  late String inputPhone =
                      "${data.docs[widget.index]['phone']}";
                  late String inputImg = "${data.docs[widget.index]['img']}";

                  return Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: Form(
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
                                initialValue:
                                    "${data.docs[widget.index]['name']}",
                              ),
                              const SizedBox(
                                height: 20,
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
                                initialValue:
                                    "${data.docs[widget.index]['Id']}",
                              ),
                              const SizedBox(
                                height: 20,
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
                                initialValue:
                                    "${data.docs[widget.index]['age']}",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (val) =>
                                    val!.isEmpty || !val.contains("@")
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
                                initialValue:
                                    "${data.docs[widget.index]['email']}",
                              ),
                              const SizedBox(
                                height: 20,
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
                                initialValue:
                                    "${data.docs[widget.index]['phone']}",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            //side: BorderSide(color: Colors.red)
                                          )),
                                          padding: const EdgeInsets.all(20),
                                          primary:
                                              Colors.blue, // <-- Button color
                                          onPrimary:
                                              Colors.white, // <-- Splash color
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: (RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          //side: BorderSide(color: Colors.red)
                                        )),
                                        padding: const EdgeInsets.all(20),
                                        primary:
                                            Colors.blue, // <-- Button color
                                        onPrimary:
                                            Colors.white, // <-- Splash color
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Processing data please wait a moment')),
                                          );

                                          _information.doc(inputId).update({
                                            'name': inputName,
                                            'Id': inputId,
                                            'age': inputAge,
                                            'email': inputEmail,
                                            'phone': inputPhone,
                                            //'img': imageUrl
                                          });

                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
