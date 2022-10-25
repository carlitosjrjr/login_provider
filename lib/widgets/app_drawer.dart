import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    super.key,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("Inicio"),
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
            selected: true,
          ),
          ListTile(
            title: const Text("Perfil"),
            onTap: () {
              Navigator.pushNamed(context, 'perfil');
            },
          ),
          ListTile(
            title: const Text("Acerca"),
            onTap: () {
              Navigator.pushNamed(context, 'Acerca');
            },
          ),
        ],
      ),
    );
  }
}
