// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:login_provider/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkSaveData = false;
  //controllers
  TextEditingController emailController = TextEditingController();

  Map<String, String> formData = {'email': '', 'password': ''};
  var formKey = GlobalKey<FormState>();
  LoginProvider loginProvider = LoginProvider();
  TextEditingController passwordController = TextEditingController();
  SharedPreferences? pref;
  UserProvider userProvider = UserProvider();

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
    if (pref != null) {
      //emailController.text = pref!.getString("email").toString();
      //passwordController.text = pref!.getString("password").toString();
      //formData['email'] = emailController.text;
      //formData['password'] = passwordController.text;
      setState(() {});
    }
  }

  formLogin() async {
    if (formKey.currentState!.validate()) {
      var usuario = await loginProvider.loignUser(formData);
      if (usuario != null) {
        userProvider.setUser(usuario);
        //guerdar
        if (checkSaveData && pref != null) {
          pref!.setString("email", usuario.email!);
          pref!.setString("password", formData['password']!);
        }
        AppDialogs.showDialog2(
          context,
          'Usuario validado con exito!!',
          [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'home');
                },
                child: const Text('Ok!'))
          ],
        );
      } else {
        AppDialogs.showDialog1(context, 'No se pudo iniciar sesión');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar');
    }
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height.round() * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color.fromRGBO(13, 162, 255, 1.0),
                Color.fromRGBO(172, 86, 155, 1.0),
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 35),
              Icon(Icons.supervised_user_circle, size: 100),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          AppTitle('Iniciar Sesión'),
                          SizedBox(height: 25),
                          AppFormField(
                            'email',
                            'Correo electrónico:',
                            controller: emailController,
                            obscureText: false,
                            TextInputType.emailAddress,
                            TextInputAction.next,
                            formData: formData,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return "correo no valido";
                              }
                              return null;
                            },
                            icon: Icons.email_outlined,
                          ),
                          AppFormField(
                            'password',
                            'Contraseña:',
                            controller: passwordController,
                            obscureText: true,
                            TextInputType.visiblePassword,
                            TextInputAction.go,
                            formData: formData,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.length < 5 ||
                                  !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])")
                                      .hasMatch(value)) {
                                return "contraseña no valida";
                              }
                              return null;
                            },
                            icon: Icons.password_outlined,
                          ),
                          SizedBox(height: 10),
                          CheckboxListTile(
                              value: checkSaveData,
                              title: const Text(
                                'Recordarme',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              onChanged: (value) {
                                checkSaveData = value!;
                              }),
                          ElevatedButton(
                              onPressed: formLogin,
                              child: Text('Iniciar Sesión'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: Text(
                    'Registrar nueva cuenta',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
