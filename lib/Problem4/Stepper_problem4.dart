import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift/Problem4/provider.dart';

import 'model.dart';

class StepperProblem4 extends StatefulWidget {
  StepperProblem4({Key? key}) : super(key: key);

  @override
  State<StepperProblem4> createState() => _StepperProblem4State();
}

class _StepperProblem4State extends State<StepperProblem4> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final _formKey = GlobalKey<FormState>();
  late String inputName = '';
  late String inputId = '';
  late String inputPhone = '';
  //late int inputAge = 0;
  late String inputAddress = '';
  TextEditingController inputAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 0),
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
                SizedBox(
                  height: 600,
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: Stepper(
                            controlsBuilder: (BuildContext context,
                                ControlsDetails controls) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  _currentStep == 2
                                      ? ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              int value =
                                                  int.parse(inputAge.text);

                                              StepperModel statement =
                                                  StepperModel(
                                                      name: inputName,
                                                      Id: inputId,
                                                      phone: inputPhone,
                                                      address: inputAddress,
                                                      age: value);
                                              // context
                                              //     .read<StepperProvider>()
                                              //     .addStepper(statement);

                                              var provider =
                                                  Provider.of<ShoppingCart>(
                                                      context,
                                                      listen: false);
                                              provider.addStepper(statement);
                                              Navigator.pop(context);
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text("Warning"),
                                                    content: const Text(
                                                        " Please enter correct information."),
                                                    actions: [
                                                      TextButton(
                                                          child:
                                                              const Text("OK"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },

                                          // onPressed: () => context
                                          //     .read<ShoppingCart>()
                                          //     .addItem(inputName),
                                          child: const Text('CONFIRM'),
                                        )
                                      : Container(),
                                  _currentStep == 2
                                      ? Container()
                                      : ElevatedButton(
                                          onPressed: controls.onStepContinue,
                                          child: const Text('NEXT'),
                                        ),
                                  ElevatedButton(
                                    onPressed: controls.onStepCancel,
                                    child: const Text('BACK'),
                                  ),
                                ],
                              );
                            },
                            type: stepperType,
                            physics: const ScrollPhysics(),
                            currentStep: _currentStep,
                            onStepTapped: (step) => tapped(step),
                            onStepContinue: continued,
                            onStepCancel: cancel,
                            steps: <Step>[
                              Step(
                                title: const Text('Personal information'),
                                content: Column(
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      onChanged: (String value) {
                                        inputName = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your age correctly.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.face),
                                          labelText: 'Age',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      controller: inputAge,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length != 10) {
                                          return 'Please enter your phone correctly.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.phone),
                                          labelText: 'Phone',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      onChanged: (String value) {
                                        inputPhone = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    // TextFormField(
                                    //   decoration: InputDecoration(labelText: 'Password'),
                                    // ),
                                  ],
                                ),
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 0
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),
                              Step(
                                title: const Text('Address information'),
                                content: Column(
                                  children: <Widget>[
                                    // TextFormField(
                                    //   decoration:
                                    //       InputDecoration(labelText: 'Home Address'),
                                    // ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length != 13) {
                                          return 'Please enter your Id correctly.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.contact_mail),
                                          labelText: 'ID Card number',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      onChanged: (String value) {
                                        inputId = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your address correctly.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.home),
                                          labelText: 'Address',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      onChanged: (String value) {
                                        inputAddress = value;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 1
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),
                              Step(
                                title: Text('Your information'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Name : $inputName",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Age : ${inputAge.text}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Phone : $inputPhone",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ID Card Number : $inputId",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Address : $inputAddress",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                                isActive: _currentStep >= 0,
                                state: _currentStep >= 2
                                    ? StepState.complete
                                    : StepState.disabled,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
