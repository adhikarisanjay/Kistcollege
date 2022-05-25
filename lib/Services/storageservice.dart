import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  setloginstatus(status, token) async {
    print(token);
    final pref = await SharedPreferences.getInstance();
    pref.setBool("status", status);
    pref.setString("token", token);
  }

  getLoginstatus() async {
    final pref = await SharedPreferences.getInstance();
    final status = pref.getBool("status");
    return status;
  }

  getLogintoken() async {
    final pref = await SharedPreferences.getInstance();
    final status = pref.getString("token");
    return status;
  }

  logoutdata() async {
    final pref = await SharedPreferences.getInstance();
    final status = pref.clear();
  }
}
