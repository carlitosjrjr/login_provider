import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userQuestion = '';
  var userAnswer = '';

  UserProvider userProvider = UserProvider();
  final List<String> buttons = [
    'C',
    '/',
    '*',
    'DEL',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '%',
    '0',
    '.',
    'ANS',
    '=',
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
              backgroundColor: Colors.white,
              body: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                userQuestion,
                                style: const TextStyle(fontSize: 20),
                              )),
                          Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.centerRight,
                              child: Text(
                                userAnswer,
                                style: const TextStyle(fontSize: 20),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: GridView.builder(
                            itemCount: buttons.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 1,
                                    childAspectRatio: 1.3),
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return MyButtons(
                                  buttonTapped: () {
                                    setState(() {
                                      userQuestion = '';
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: Colors.orange,
                                  textColor: Colors.white,
                                );
                              } else if (index == 3) {
                                return MyButtons(
                                  buttonTapped: () {
                                    setState(() {
                                      if (userQuestion.length>0) {
                                        userQuestion = userQuestion.substring(
                                          0, userQuestion.length - 1);
                                      }
                                      else
                                      {
                                        userQuestion='';
                                      }
                                      
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: const Color.fromARGB(255, 125, 33, 27),
                                  textColor: Colors.white,
                                );
                              } else if (index == buttons.length - 1) {
                                return MyButtons(
                                  buttonTapped: () {
                                    setState(() {
                                      equalPressed();
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: isOperador(buttons[index])
                                      ? Colors.black
                                      : Colors.teal,
                                  textColor: isOperador(buttons[index])
                                      ? Colors.white
                                      : Colors.black,
                                );
                              } else {
                                return MyButtons(
                                  buttonTapped: () {
                                    setState(() {
                                      userQuestion += buttons[index];
                                    });
                                  },
                                  buttonText: buttons[index],
                                  color: isOperador(buttons[index])
                                      ? Colors.black
                                      : Colors.teal,
                                  textColor: isOperador(buttons[index])
                                      ? Colors.white
                                      : Colors.black,
                                );
                              }
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

  bool isOperador(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
  
  void equalPressed() {
    String finalQuestion=userQuestion;
    finalQuestion= finalQuestion.replaceAll('x', '*');

  
    Parser parser=Parser();
    Expression expression=parser.parse(finalQuestion);
    ContextModel contModel=ContextModel();
    double eval=expression.evaluate(EvaluationType.REAL, contModel);
    userAnswer=eval.toString();
    userQuestion='';
  }
}
