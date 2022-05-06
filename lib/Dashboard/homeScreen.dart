import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vdosecshare/model/user_model.dart';
import 'package:vdosecshare/screen/signInScreen.dart';
import 'package:vdosecshare/tabs/Profile.dart';
import 'package:vdosecshare/tabs/Shared.dart';
import 'package:vdosecshare/tabs/Upload.dart';
import 'package:vdosecshare/tabs/Video_List.dart';

import 'package:vdosecshare/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel loggedInUser = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Dashboard",
            style: TextStyle(
                fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold),
          ),
            actions: [
              IconButton(
                  onPressed: () {
                    logout(context);
                  },
                  icon: const Icon(Icons.logout)),
            ]
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor("CB2B93"),
                hexStringToColor("9546C4"),
                hexStringToColor("5E61F6")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 160, left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                    primary: Colors.blue,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(),
                    fixedSize: const Size(150, 150)),
                child: Text(
                  "PROFILE",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                    print("Profile View");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 160, left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                    primary: Colors.green,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(),
                    fixedSize: const Size(150, 150)),
                child: Text(
                  "UPLOAD",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                    print("Upload the Video");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Upload()));
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 160, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                    primary: Colors.yellowAccent,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(),
                    fixedSize: const Size(150, 150)),
                child: Text(
                  "VIDEO LIST",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                    print("Video list");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Video_List()));
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(bottom: 160, right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                    primary: Colors.deepOrange,
                    onPrimary: Colors.black,
                    shape: const CircleBorder(),
                    fixedSize: const Size(150, 150)),
                child: Text(
                  "SHARED",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                    print("Shared video");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Shared()));
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(bottom: 40, right: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15),
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    ),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  logout(context);
                },
              ),
            ),
          ],
        ));
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SigninScreen()));
  }
}
