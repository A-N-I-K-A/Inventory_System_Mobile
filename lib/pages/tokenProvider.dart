import 'package:flutter/material.dart';

class Tokenprovider extends ChangeNotifier {
  String? token;

  void setToken(String token) {
    this.token = token;
    notifyListeners();
  }

  String? getToken() {
    return token;
  }
}
