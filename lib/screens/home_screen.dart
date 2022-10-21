import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    userProvider = Provider.of<UserProvider>(context);
    String name = userProvider.user.name!;

    return Scaffold(
      appBar: getAppBar(context, 'Inicio', userProvider.user),
      drawer: media.width < 600 ? const AppDrawer() : null,
      body: Row(
        children: <Widget>[
          media.width > 600
              ? const Flexible(flex: 1, child: AppDrawer())
              : Container(),
          Flexible(
            flex: 3,
            child: Center(
              // ignore: prefer_interpolation_to_compose_strings
              child: Text('Bienvenido ' + name + ' a la aplicacion'),
            ),
          ),
        ],
      ),
    );
  }
}
