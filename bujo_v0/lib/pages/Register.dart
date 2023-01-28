// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'successful_register.dart' show SuccessfulRegister;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Center(
                child: Image.asset(
              'images/handwriting.jpeg',
              height: 100,
            )),
          ),
          Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child:
          TextFormField(
              decoration: (const InputDecoration(
                labelText: ("Email"),
                helperText: "Enter your email here",
              )),
            )
          ),
          Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child:
          TextFormField(
              decoration: (const InputDecoration(
                labelText: ("Username"),
                helperText: "Enter your Username here",
              )),
            )
          ),
          Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child:
          TextFormField(
              decoration: (const InputDecoration(
                labelText: ("Password"),
                helperText: "Enter your Password here",
              )),
            )
          ),
          Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child:
          TextFormField(
              decoration: (const InputDecoration(
                labelText: ("Confirm your Password"),
                helperText: "Enter your Password again",
              )),
            )
          ),
          Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child:ElevatedButton(
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(160, 40))),
                      child: const Text('Create Account!'),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                                 builder: ((context) => const SuccessfulRegister())));
                      },
                    ),
          ),
        ],
      )
    );
  }
}
