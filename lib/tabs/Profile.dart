
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider
                  .of(context)
                  .auth
                  .getCurrentUser().uid,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(8.0),
          child: Text("User Name: ${user.userName}",style: TextStyle(fontSize: 20),),)
      ],
    );

  }

}



