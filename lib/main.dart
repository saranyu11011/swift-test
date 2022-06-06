import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift/Problem1/problem1.dart';
import 'package:swift/Problem2/Problem2.dart';
import 'package:swift/Problem3/Problem3.dart';
import 'package:swift/Problem4/Problem4.dart';
import 'package:swift/Problem4/Stepper_problem4.dart';
import 'package:swift/homepage.dart';

import 'Problem4/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ShoppingCart()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _user =
      FirebaseFirestore.instance.collection("user");
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/first': (context) => const Problem1(),
        '/second': (context) => const Problem2(),
        '/third': (context) => const Problem3(),
        '/forth': (context) => const Problem4(),
        '/fifth': (context) => StepperProblem4(),
      },
    );
  }
}
