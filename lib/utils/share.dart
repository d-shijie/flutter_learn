import 'package:shared_preferences/shared_preferences.dart';

var pref = SharedPreferences.getInstance();

class Share {
  set(key, val) async {
    await pref.then((value) => value.setString(key, val));
  }

  Future get(key) async {
    var res;
    res = await pref.then((value) => value.getString(key));
    return res;
  }

  remove(key) async {
    await pref.then((value) => value.remove(key));
  }
}
