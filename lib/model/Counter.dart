import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int _count;
  Counter(this._count);
  void add() {
    _count++;
    notifyListeners();
  }

  void setCount(int index) {
    _count = index;
    notifyListeners();
  }

  get count => _count;
}
