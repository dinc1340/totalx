import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalx/model/userdetails.dart';

class UserProvider extends ChangeNotifier {
  List<UserData> _userData = [];
  int selectedSort = -1;

  void setSort(int value) {
    selectedSort = value;
    notifyListeners();
  }

  void resetSort() {
    selectedSort = -1;
    notifyListeners();
  }

  List<UserData> get userData => _userData;

  Future<void> addTask(UserData data) async {
    final imagePath = await _saveImageToStorage(data.image);

    final newUser = UserData(
      image: data.image,
      imagePath: imagePath,
      name: data.name,
      age: data.age,
    );
    _userData.add(newUser);
    notifyListeners();
    saveTask();
  }

  Future<String> _saveImageToStorage(XFile imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName.png');
    return savedImage.path;
  }

  void saveTask() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> save = _userData
        .map((item) =>
            '${item.image},${item.imagePath},${item.name},${item.age.toString()}')
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
          image: XFile(parts[0]),
          imagePath: parts[1],
          name: parts[2],
          age: int.parse(parts[3]),
        );
      }).toList();
    }
    notifyListeners();
  }

  void clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('details');
    pref.remove('login');
    _userData.clear();
    notifyListeners();
  }
}
