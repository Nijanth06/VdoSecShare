import 'package:flutter/material.dart';
import 'package:vdosecshare/utils/color_utils.dart';

class Video_List extends StatefulWidget {
  const Video_List({Key? key}) : super(key: key);

  @override
  _Video_ListState createState() => _Video_ListState();
}

class _Video_ListState extends State<Video_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Video List",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    );
  }
}