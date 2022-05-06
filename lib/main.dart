import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vdosecshare/Dashboard/homeScreen.dart';
import 'package:vdosecshare/screen/signInScreen.dart';
import 'package:vdosecshare/screen/signUpScreen.dart';
import 'package:vdosecshare/tabs/Profile.dart';
import 'package:vdosecshare/tabs/Upload.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login UI',
      home: SigninScreen(),
    );
  }
}
