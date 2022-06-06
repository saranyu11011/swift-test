import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift/Problem4/provider.dart';

import 'model.dart';

class Problem4 extends StatelessWidget {
  const Problem4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
                            "STEPPER FORM",
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
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: (RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    //side: BorderSide(color: Colors.red)
                  )),
                  padding: const EdgeInsets.all(20),
                  primary: Colors.blueAccent, // <-- Button color
                  onPrimary: Colors.white, // <-- Splash color
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/fifth');
                },
                child: const Text('Add information'),
              ),
              // // Text('${context.watch<ShoppingCart>().count}'),
              // Text('${context.watch<ShoppingCart>().cart}'),
              // Text('${context.watch<ShoppingCart>().list}'),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 500,
          child: Center(child:
              Consumer<ShoppingCart>(builder: (context, provider, child) {
            return ListView.builder(
                itemCount: provider.list.length,
                itemBuilder: (context, int index) {
                  StepperModel data = provider.list[index];
                  return ListTile(
                    title: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.only(top: 15, left: 10),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name : ${data.name}"),
                          Text("Age : ${data.age.toString()}"),
                          Text("Phone : ${data.phone}"),
                          Text("ID Card number : ${data.Id}"),
                          Text("Address : ${data.address}"),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                    // trailing: Text(data.Id),
                  );
                });
          })),
        ),
      ),
    );
  }
}
