import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  setloginstatus(value) async {
    final pref = await SharedPreferences.getInstance();
  }

  getLoginstatus() async {
    final pref = await SharedPreferences.getInstance();
    final status = pref.getBool("loginstatus");
    return status;
  }
}
