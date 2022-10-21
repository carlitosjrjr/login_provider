import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_provider/models/user.dart';

class LoginProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1';
  Future<User?> loignUser(Map<String, String> formData) async {
    var url = Uri.parse(endpoint +
        '/accounts:signInWithPassword?key=AIzaSyAlO2aOWeaR5pbADVswJn5c3FG5lMabY4A');

    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      var urlDb = Uri.parse(
          'https://login-provider-46fdd-default-rtdb.firebaseio.com/users/' +
              usuario.localId! +
              '.json');

      var responseDb = await http.get(urlDb);

      if (responseDb.statusCode == 200) {
        usuario.setUserData(jsonDecode(responseDb.body));
        return usuario;
      }
    }
    return null;
  }
}
