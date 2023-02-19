// ignore_for_file: file_names
import 'package:bujo_v0/currentUser.dart';
import 'package:bujo_v0/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'successful_register.dart' show SuccessfulRegister;

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

Users? loggeduser;

class _RegisterState extends State<Register> {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _username = '';
  static String _password = '';
  String? _repassword = '';
  final formkey = GlobalKey<FormState>();

  void signUpUser(String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if (await currentUser.signUpUser(email, password)) {
        firestore.doc(_auth.currentUser?.uid.toString()).set({
          'email':_email,
          'username':_username,
          'password':_password,
          'location': const GeoPoint(0,0),
        },);
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => SuccessfulRegister())));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0.0,
          foregroundColor: Colors.blueGrey,
          title: const Text(
            "Register",
          ),
        ),
        body: Form(
            key: formkey,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(
                  child: Center(
                      child: Image.asset(
                    'assets/images/handwriting.jpeg',
                    height: 100,
                  )),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TextFormField(
                      validator: emailValidator,
                      onChanged: (value) {
                        _email = value.toString();
                      },
                      decoration: (const InputDecoration(
                        labelText: ("Email"),
                        helperText: "Enter your email here",
                      )),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TextFormField(
                      validator: usernameValidator,
                      onChanged: (value) {
                        _username = value.toString();
                      },
                      decoration: (const InputDecoration(
                        labelText: ("Username"),
                        helperText: "Enter your Username here",
                      )),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TextFormField(
                      validator: passwordValidator,
                      onChanged: (value) {
                        _password = value.toString();
                      },
                      decoration: (const InputDecoration(
                        labelText: ("Password"),
                        helperText: "Enter your Password here",
                      )),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TextFormField(
                      validator: repasswordValidator,
                      onSaved: (value) {
                        _repassword = value.toString();
                      },
                      decoration: (const InputDecoration(
                        labelText: ("Confirm your Password"),
                        helperText: "Enter your Password again",
                      )),
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(160, 40))),
                    child: const Text('Create Account!'),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        signUpUser(_email, _password, context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                  ),
                ),
              ],
            ))));
  }
}

String? emailValidator(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return '*Required';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid email.';
  }
  return null;
}

String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '*Required';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '*Required';
  } else if (value.length < 8) {
    return 'Password can\'t be shorter than 8 character.';
  }
  return null;
}

String? repasswordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return '*Required';
  } else if (value != _RegisterState._password) {
    return 'Password do not match.';
  }
  return null;
}
