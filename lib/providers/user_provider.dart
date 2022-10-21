import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_provider/models/user.dart';

class UserProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  User user = User();

  setUser(User _user) {
    user = _user;
    notifyListeners();
  }

  Future<bool> updateUser(Map<String, String> formData) async {
    var urlDb = Uri.parse(
        'https://login-provider-46fdd-default-rtdb.firebaseio.com/users/' +
            formData['localId']! +
            '.json');
    var responseDb = await http.put(urlDb, body: jsonEncode(formData));
    if (responseDb.statusCode == 200) {
      user.setUserData(jsonDecode(responseDb.body));
      notifyListeners();
      return true;
    }
    return false;
  }
}
