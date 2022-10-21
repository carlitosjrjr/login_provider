import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({Key? key}) : super(key: key);

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: getAppBar(context, 'Acerca', userProvider.user),
      drawer: media.width < 600 ? const AppDrawer() : null,
      body: Row(
        children: <Widget>[
          media.width > 600
              ? const Flexible(flex: 1, child: AppDrawer())
              : Container(),
          const Flexible(
            flex: 3,
            child: Center(
              child: Text('App v1.0'),
            ),
          ),
        ],
      ),
    );
  }
}
