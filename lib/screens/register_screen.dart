// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:login_provider/providers/providers.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map<String, String> formData = {
    'email': '',
    'password': '',
    'name': '',
    'lastname': '',
    'phone': ''
  };

  var formKey = GlobalKey<FormState>();
  RegisterProvider registerProvider = RegisterProvider();

  formRegister() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await registerProvider.registerUser(formData);
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Usuario registrado con exito');
      } else {
        AppDialogs.showDialog1(context, 'No se pudo registrar al usuario');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar.');
    }
  }

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context);

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
              Icon(Icons.app_registration_outlined, size: 100),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 16.0,
                  shadowColor: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          AppTitle('Registrarse'),
                          SizedBox(height: 25),
                          AppFormField(
                            'name',
                            'Nombre:',
                            obscureText: false,
                            TextInputType.name,
                            TextInputAction.next,
                            formData: formData,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"(^[a-zA-Z ]*$)").hasMatch(value)) {
                                return "El nombre no es valido";
                              }
                              return null;
                            },
                            icon: Icons.person_outlined,
                          ),
                          AppFormField(
                            'lastname',
                            'Apellido:',
                            obscureText: false,
                            TextInputType.emailAddress,
                            TextInputAction.next,
                            formData: formData,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"(^[a-zA-Z ]*$)").hasMatch(value)) {
                                return "El apellido no es valido";
                              }
                              return null;
                            },
                            icon: Icons.email_outlined,
                          ),
                          AppFormField(
                            'phone',
                            'Telefono:',
                            obscureText: false,
                            TextInputType.phone,
                            TextInputAction.next,
                            formData: formData,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.length <= 7 ||
                                  !RegExp(r"(^[0-9]*$)").hasMatch(value)) {
                                return "El telefono no es valido";
                              }
                              return null;
                            },
                            icon: Icons.call,
                          ),
                          AppFormField(
                            'email',
                            'Correo electrónico:',
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
                          ElevatedButton(
                              onPressed: formRegister,
                              child: Text('Registrarse'))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
