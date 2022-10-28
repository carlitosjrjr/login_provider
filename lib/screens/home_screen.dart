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
  final List<String> buttons=[
    'C','/','*','DEL',
    '7','8','9','-',
    '4','5','6','+',
    '1','2','3','%',
    '0','.','ANS','=',
    
  ];
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
            child: Scaffold(
              backgroundColor: Color.fromARGB(75, 145, 130, 160),
              body: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 10,
                    
                    child: Container(
                      child:GridView.builder(itemCount: buttons.length,physics: const NeverScrollableScrollPhysics(), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), itemBuilder: (BuildContext context, int index) {
                        return MyButtons(buttonText: buttons[index],
                        color: Colors.blueGrey,
                        textColor: Colors.white,);
                      })),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
