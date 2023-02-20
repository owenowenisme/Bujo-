// ignore_for_file: file_names
import 'package:bujo_v0/pages/map.dart';
import 'package:bujo_v0/pages/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bujo_v0/currentUser.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailContriller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Stream firestore = FirebaseFirestore.instance.collection('users').snapshots();
  void _loginUser(String email, String password, BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      if (await currentUser.loginUser(email, password)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => myMap())));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Email or password might be wrong.'),
              duration: Duration(seconds: 2)),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blueGrey,
        ),
        home: myMap(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Center(
                child: Image.asset(
              'assets/images/handwriting.jpeg',
              height: 100,
            )),
          ),
          const Text.rich(TextSpan(
              text: "Welcome Back!",
              style: TextStyle(
                fontSize: 24,
                fontFamily: '',
                fontWeight: FontWeight.bold,
              ))),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              controller: _emailContriller,
              decoration: (const InputDecoration(
                labelText: ("Email"),
              )),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              controller: _passwordController,
              decoration: (const InputDecoration(
                labelText: ("Pasword"),
              )),
            ),
          ),
          Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(160, 40))),
                      child: const Text('Login'),
                      onPressed: () {
                        _loginUser(_emailContriller.text,
                            _passwordController.text, context);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: OutlinedButton(
                        style: const ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(160, 40))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Register())));
                        },
                        child: const Text('Sign Up!')),
                  )
                ],
              )),
        ],
      )),
    );
  }
}
