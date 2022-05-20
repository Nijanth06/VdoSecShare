import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vdosecshare/Dashboard/ImageRetrive.dart';
import 'package:vdosecshare/model/user_model.dart';
import 'package:vdosecshare/screen/signInScreen.dart';
import 'package:vdosecshare/tabs/Profile.dart';
import 'package:vdosecshare/tabs/Shared.dart';
import 'package:vdosecshare/tabs/Upload.dart';
import 'package:vdosecshare/utils/color_utils.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

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
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Profile(

                            )));
              },
              child: const Text("Profile"),
            ),),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Upload(
                              userId: loggedInUser.uid,
                            )));
              },
              child: const Text("Upload Video"),
            ),),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageRetrive(userId: loggedInUser.uid)));
              },
              child: const Text("Show Videos"),
            ),),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(bottom: 160, right: 20),
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 15),
                  primary: Colors.deepOrange,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(),
                  fixedSize: const Size(150, 150)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Shared()));
              },
              child: const Text("Share Videos"),
            ),),
        ],
      ),
    );
  }

  _appBar() {
    final appBarHeight = AppBar(

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
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SigninScreen()));
  }
}
