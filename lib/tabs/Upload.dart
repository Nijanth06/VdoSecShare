import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vdosecshare/Dashboard/homeScreen.dart';
import 'package:vdosecshare/api/firebase_api.dart';
import 'package:vdosecshare/reusable_text_field/text_field.dart';
import 'package:vdosecshare/utils/button_widget.dart';
import 'package:vdosecshare/utils/color_utils.dart';
import 'package:path/path.dart';



class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  UploadTask? task;
  File? file;
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText ;
  TextEditingController _videoNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path): 'No File Selected';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Upload Video",
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
            child: Column(
              children: <Widget>[
                reusableTextField("Enter VideoName", Icons.video_library_sharp, false,
                    _videoNameTextController),
                const SizedBox(
                  height: 45,
                ),
                ButtonWidget(
                  icon: Icons.attach_file,
                  text: 'Select File',
                  onClicked: selectFile,
                ),
                SizedBox(height: 8),
                Text( fileName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 48),
                ButtonWidget(
                  icon: Icons.cloud_upload_outlined,
                  text: 'Upload File',
                  onClicked: uploadFile,
                ),

                SizedBox(height: 20),
                task != null ? buildUploadStatus(task!) : Container(),

              ],
            ),
          ),
        ),
      ),
    );

  }
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(()  => file = File(path));
  }

  Future uploadFile() async {
    if (file ==null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
     plainText = 'files/$fileName';
    setState(() {
      encryptedText = MyEncryptionDecryption.encryptAES(plainText);
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

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

class MyEncryptionDecryption {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted;
  }

  static decryptAES(text) {
    final decrypted = encrypter.decrypt(text, iv: iv);
    print(decrypted);
    return decrypted;
  }
}