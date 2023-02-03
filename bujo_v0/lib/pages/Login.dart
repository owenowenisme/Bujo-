// ignore_for_file: file_names
import 'package:bujo_v0/pages/map.dart';
import 'package:bujo_v0/pages/register.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              decoration: (const InputDecoration(
                labelText: ("Username or Email"),
              )),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              decoration: (const InputDecoration(
                labelText: ("Pasword"),
              )),
            ),
          ),
          Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(Size(160, 40))),
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                                 builder: ((context) => const Map())));
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
                        child: const Text('Register')),
                  )
                ],
              )),
        ],
      )),
    );
  }
}
