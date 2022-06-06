import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Problem1 extends StatefulWidget {
  const Problem1({Key? key}) : super(key: key);

  @override
  _Problem1State createState() => _Problem1State();
}

class _Problem1State extends State<Problem1> {
  late DateTime _myDateTime;
  String time = '?';
  final todoo = TextEditingController();
  late String input;
  late String inputDescription = '';

  //final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final Stream<QuerySnapshot> todolist =
      FirebaseFirestore.instance.collection('todolist').snapshots();
  final CollectionReference _todo =
      FirebaseFirestore.instance.collection("todolist");
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new?'),
          content: SizedBox(
            height: 220,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.event_available),
                        labelText: 'Do something?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.border_color),
                        labelText: 'Description?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    onChanged: (String value) {
                      inputDescription = value;
                    },
                    initialValue: ' ',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 220,
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
                          _myDateTime = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2025)))!;
                          setState(() {
                            //final now = DateTime.now();
                            time = DateFormat('dd-MM-yy').format(_myDateTime);
                            //time = _myDateTime.toString();
                          });
                        },
                        child: const Text("Pick a date")),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    _todo.doc(time + input).set({
                      'todo': input,
                      'time': time,
                      'description': inputDescription,
                      'extra': time + input
                    });
                    inputDescription = '';
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
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
                          "TO DO LIST",
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
            // Text("$time"),
            StreamBuilder<QuerySnapshot>(
              stream: todolist,
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
                            top: 15, bottom: 5, left: 20, right: 20),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            title: Text(index != 0
                                ? data.docs[index]['time'] ==
                                        data.docs[index - 1]['time']
                                    ? "To do :${data.docs[index]['todo']}"
                                    : "Date : ${data.docs[index]['time']}\nTo do : ${data.docs[index]['todo']}"
                                : "Date : ${data.docs[index]['time']}\nTo do : ${data.docs[index]['todo']}"),
                            subtitle: Text(
                                "Description : ${data.docs[index]['description']}"),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("todolist")
                                    .doc("${data.docs[index]['extra']}")
                                    .delete();
                                // _todo
                                //     .doc("${data.docs[index]['time']}")
                                //     .delete();
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
                  child: const Text("Add new to do list?")),
            ),
          ],
        ),
      ),
    );
  }
}
