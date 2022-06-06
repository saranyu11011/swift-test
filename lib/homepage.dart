import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0, top: 30),
                        child: Text(
                          "SWIFT TEST",
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
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
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
                      Navigator.pushNamed(context, '/first');
                    },
                    child: const Text('TO DO LIST'),
                  ),
                ),
                SizedBox(
                  width: 150,
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
                      Navigator.pushNamed(context, '/second');
                    },
                    child: const Text('CALCULATOR'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
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
                      Navigator.pushNamed(context, '/third');
                    },
                    child: const Text('INFORMATION'),
                  ),
                ),
                SizedBox(
                  width: 150,
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
                      Navigator.pushNamed(context, '/forth');
                    },
                    child: const Text('STEPPER FORM'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            Column(
              children: const [
                Text("Name : Saranyu Saprom"),
                Text("Email : Saranyusa@kkumail.com"),
                Text("Phone : 061-939-3334")
              ],
            )
          ],
        ),
      ),
    );
  }
}
