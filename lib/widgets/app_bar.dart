import 'package:flutter/material.dart';
import 'package:login_provider/models/user.dart';

getAppBar(BuildContext context, String title, User user) {
  String initials = user.name!.substring(0, 1) + user.lastname!.substring(0, 1);
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(initials),
        ),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'perfil');
        },
      ),
      const SizedBox(
        width: 5,
      ),
    ],
  );
}
