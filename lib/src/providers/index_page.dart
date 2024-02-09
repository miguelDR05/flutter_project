import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  Person({required this.name, required this.age});

  final String name;
  int age;

  void increaseAge() {
    age++;
    notifyListeners();
  }
}

class IndexPage extends ChangeNotifier {
  int _initialPageIndex = 0;

  int get initialPageIndex => _initialPageIndex;

  void setInitialPageIndex(int index) {
    _initialPageIndex = index;
    notifyListeners(); // Notificar a los oyentes que el estado ha cambiado
  }
}