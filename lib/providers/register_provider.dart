import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_provider/models/user.dart';

class RegisterProvider extends ChangeNotifier {
  String endpoint = 'https://identitytoolkit.googleapis.com/v1/';
  Future<bool> registerUser(Map<String, String> formData) async {
    var url = Uri.parse(endpoint +
        'accounts:signUp?key=AIzaSyAlO2aOWeaR5pbADVswJn5c3FG5lMabY4A');

    var response = await http.post(url, body: jsonEncode(formData));
    if (response.statusCode == 200) {
      var usuario = User.fromJson(jsonDecode(response.body));
      print(usuario.localId);

      var urlDb = Uri.parse(
          'https://login-provider-46fdd-default-rtdb.firebaseio.com/users/' +
              usuario.localId! +
              '.json');
      var responseDb = await http.put(urlDb,
          body: jsonEncode({
            'name': formData['name'],
            'lastname': formData['lastname'],
            'phone': formData['phone'],
            'image': ''
          }));
      return true;
    }
    return false;
  }
}
