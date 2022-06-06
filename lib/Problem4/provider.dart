import 'package:flutter/material.dart';

import 'model.dart';

class ShoppingCart with ChangeNotifier {
  final List<StepperModel> _steppermodel = [
    StepperModel(
        name: "Saranyu",
        Id: "1409902898429",
        phone: "0866308863",
        age: 53,
        address: "Khon Kaen"),
    StepperModel(
        name: "Lekky",
        Id: "1892758396048",
        phone: "0619393334",
        age: 22,
        address: "Udon"),
  ];
  List<StepperModel> get list => _steppermodel;

  void addStepper(StepperModel statement) {
    _steppermodel.add(statement);
    notifyListeners();
  }
}
