import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vdosecshare/model/user_model.dart';
import 'package:vdosecshare/utils/button_widget.dart';
import 'package:vdosecshare/utils/color_utils.dart';

class Upload extends StatefulWidget {
  final String? userId;
  const Upload({Key? key, this.userId}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}


class _UploadState extends State<Upload> {
  // initializing some values
  File? _video;
  final imagePicker = ImagePicker();
  String? downloadURL;
  UploadTask? task;
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText ;

  TextEditingController videoNameController = TextEditingController();
  // picking the video

  Future selectFile() async {
    final pick = await imagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _video = File(pick.path);
      } else {
        showSnackBar("No File selected", Duration(milliseconds: 400));
      }
    });
  }



    @override
    Widget build(BuildContext context) {
    //video name
      //first name field
      final videoNameField = TextFormField(
          autofocus: false,
          controller: videoNameController,
          keyboardType: TextInputType.name,

          onSaved: (value) {
            videoNameController.text = value!;
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.video_library_sharp,color: Colors.yellowAccent,),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Video Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));

      final UploadVideoButton =Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        color: Colors.green,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
                if (_video != null) {
                  uploadVideo(_video!);
                } else {
                  showSnackBar("Select Video first",
                      Duration(milliseconds: 400));
                }

              },

            child: Text(
              "Upload Video",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            )),
      );


      final fileName = _video != null ? _video!.path: 'No File Selected';
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Upload Video",
            style: TextStyle(
                fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 120, 30, 10),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  videoNameField,
                  SizedBox(height: 20),
                  ButtonWidget(
                    icon: Icons.attach_file,
                    text: 'Select Video',
                    onClicked: selectFile,
                  ),
                  SizedBox(height: 8),
                  Text( fileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 48),
                  UploadVideoButton,

                  SizedBox(height: 20),
                  task != null ? buildUploadStatus(task!) : Container(),


                ],
              ),
            ),
          ),
        ),
      );
    }

    // show snack bar

    showSnackBar(String snackText, Duration d) {
      final snackBar = SnackBar(content: Text(snackText), duration: d);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  // uploading the image to firebase cloudstore
  Future uploadVideo(File _video) async {
    final videoId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${widget.userId}/video')
        .child("post_$videoId");

    await reference.putFile(_video);
    downloadURL = await reference.getDownloadURL();

    // cloud firestore
    await firebaseFirestore
        .collection("users")
        .doc(widget.userId)
        .collection("video")
        .add({'downloadURL': downloadURL}).whenComplete(
            () => showSnackBar("Video Uploaded", Duration(seconds: 2)));
  }

    Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return Text(
            '$percentage %',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );

        } else {
          return Container();
        }


      },
    );

}

