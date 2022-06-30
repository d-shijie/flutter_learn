import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

class Modal with ChangeNotifier {
  // 定义
  int _count;
  // 接收 可有可无
  Modal(this._count);
  // 操作
  void add() {
    _count++;
    // 通知用到Modal对象的widget刷新 必须加
    notifyListeners();
  }

  // 取
  get count => _count;
}
