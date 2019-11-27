import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String _name;
  User(this._name);
  void updata(name) {
    _name = name;
    notifyListeners();
  }

  get name => _name;
}