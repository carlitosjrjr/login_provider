import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_provider/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider userProvider = UserProvider();
  Map<String, String> formData = {
    'email': '',
    'password': '',
    'name': '',
    'lastname': '',
    'phone': '',
    'image': ''
  };
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  XFile? image;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    userProvider = Provider.of<UserProvider>(context);

    nameController.text = userProvider.user.name!;
    lastnameController.text = userProvider.user.lastname!;
    phoneController.text = userProvider.user.phone!;

    if (formData['name'] == "") {
      formData['name'] = nameController.text;
      formData['lastname'] = lastnameController.text;
      formData['phone'] = phoneController.text;
      formData['localId'] = userProvider.user.localId!;
      formData['image'] = userProvider.user.image!;
    }

    return Scaffold(
      appBar: getAppBar(context, 'Perfil', userProvider.user),
      drawer: media.width < 600 ? const AppDrawer() : null,
      body: Row(
        children: <Widget>[
          media.width > 600
              ? const Flexible(flex: 1, child: AppDrawer())
              : Container(),
          Flexible(
            flex: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (image != null) {
                              final bytes = File(image!.path).readAsBytesSync();
                              formData['image'] = base64Encode(bytes);
                            }
                            setState(() {});
                          },
                          child: userProvider.user.image == ""
                              ? const Image(
                                  image: AssetImage('assets/profile.png'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(600),
                                  child: Image.memory(
                                    base64Decode(formData['image']!),
                                    fit: BoxFit.cover,
                                    height: 400,
                                    width: 400,
                                  ))),
                      AppFormField(
                        'name',
                        'Nombre:',
                        controller: nameController,
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
                        controller: lastnameController,
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
                        controller: phoneController,
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
                      const SizedBox(
                        height: 20,
                      ),
                      (loading == false)
                          ? ElevatedButton(
                              onPressed: formUpdate,
                              child: const Text('Actualizar'))
                          : const Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  formUpdate() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      bool respuesta = await userProvider.updateUser(formData);
      loading = false;
      setState(() {});
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Datos actualizados.');
      } else {
        AppDialogs.showDialog1(context, 'No se pudo actualizar el usuario.');
      }
    } else {
      AppDialogs.showDialog1(context, 'Validación no exitosa.');
    }
  }
}
