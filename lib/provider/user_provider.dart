import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalx/model/userdetails.dart';

class UserProvider extends ChangeNotifier {
  List<UserData> _userData = [];
  void saveTask() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> save = _userData
        .map((item) =>
            '${item.image},${item.image},${item.name},${item.age.toString()}')
        .toList();
    await pref.setStringList("details", save);
  }

  loadTask() async {
    SharedPreferences loading = await SharedPreferences.getInstance();
    List<String>? save = loading.getStringList("details");
    if (save != null && save.isNotEmpty) {
      _userData = save.map((item) {
        List<String> parts = item.split(',');
        return UserData(
          image: parts[0],
          name: parts[1],
          age: int.parse(parts[2]),
        );
      }).toList();
    }
    notifyListeners();
  }
}
