
import 'dart:io' ;

import 'package:bujo_v0/currentUser.dart';
import 'package:bujo_v0/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(Platform.isAndroid){
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  runApp(const Bujoapp());
}
 
class Bujoapp extends StatelessWidget {
  const Bujoapp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        title: 'Bujo!',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blueGrey,
        ),
        home: const Login(),
      ),
    );
  }
}
