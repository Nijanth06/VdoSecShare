import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vdosecshare/Dashboard/homeScreen.dart';
import 'package:vdosecshare/model/user_model.dart';
import 'package:vdosecshare/utils/AppIcon.dart';
import 'package:vdosecshare/utils/account_widget.dart';
import 'package:vdosecshare/utils/color_utils.dart';
import 'package:vdosecshare/utils/main_text.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    // upload
    final UploadButton =Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen()));
          },
          child: Text(
            "Upload",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 120, 30, 10),
            child: Column(
              children: <Widget>[
                //Profile Icon
                AppIcon(icon: Icons.person,
                  backgroundColor: Colors.lightBlueAccent,
                  iconColor: Colors.white,
                  iconSize: 100,
                  size: 125,
                ),

                //Name
                //Name
                SizedBox(height: 50,),
                AccountWidget(appIcon: AppIcon(
                  icon: Icons.person,
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  iconSize: 25,
                  size: 40,
                ),
                  mainText: MainText( text: "${loggedInUser.name} ",),

                ),

                //Email
                SizedBox(height: 20,),
                AccountWidget(appIcon: AppIcon(
                  icon: Icons.email,
                  backgroundColor: Colors.yellow,
                  iconColor: Colors.white,
                  iconSize: 25,
                  size: 40,
                ),
                  mainText: MainText( text: "${loggedInUser.email}",
                  ),
                ),

                //phone number
                SizedBox(height: 20,),
                AccountWidget(appIcon: AppIcon(
                  icon: Icons.phone,
                  backgroundColor: Colors.amber,
                  iconColor: Colors.white,
                  iconSize: 25,
                  size: 40,
                ),
                  mainText: MainText( text: "${loggedInUser.phoneNumber}",
                  ),
                ),
                SizedBox(height: 50),
                UploadButton,


              ],
            ),
          ),
        ),
      ),
    );
  }
}