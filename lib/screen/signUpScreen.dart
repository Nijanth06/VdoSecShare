import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vdosecshare/Dashboard/homeScreen.dart';
import 'package:vdosecshare/model/user_model.dart';
import 'package:vdosecshare/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  bool isHiddenPassword= true;


  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final passwordController = new TextEditingController();
  final emailController = new TextEditingController();
  final nameController = new TextEditingController();
  final phoneNumberController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //first name field
     final nameField = TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return (" Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle,color: Colors.green,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

     //email field
      final emailField = TextFormField(
         autofocus: false,
         controller: emailController,
         keyboardType: TextInputType.emailAddress,
         validator: (value) {
           if (value!.isEmpty) {
             return ("Please Enter Your Email");
           }
           // reg expression for email validation
           if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
               .hasMatch(value)) {
             return ("Please Enter a valid email");
           }
           return null;
         },
         onSaved: (value) {
           emailController.text = value!;
         },
         textInputAction: TextInputAction.next,
         decoration: InputDecoration(
           prefixIcon: Icon(Icons.email,color: Colors.yellowAccent,),
           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
           hintText: "Email",
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
         ));

     //phone number field
     final phoneNumberField =TextFormField(
         autofocus: false,
         controller: phoneNumberController,
         keyboardType: TextInputType.name,
         validator: (value) {
           if (value!.isEmpty) {
             return (" phone number cannot be Empty");
           }

           return null;
         },
         onSaved: (value) {
           phoneNumberController.text = value!;
         },
         textInputAction: TextInputAction.next,
         decoration: InputDecoration(
           prefixIcon: Icon(Icons.phone,color: Colors.amber,),
           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
           hintText: "Phone Number",
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
         ));

     //password field
     final passwordField =TextFormField(

         autofocus: false,
         controller: passwordController,
         obscureText: isHiddenPassword,
         validator: (value) {
           RegExp regex = new RegExp(r'^.{6,}$');
           if (value!.isEmpty) {
             return ("Password is required for login");
           }
           if (!regex.hasMatch(value)) {
             return ("Enter Valid Password(Min. 6 Character)");
           }
         },
         onSaved: (value) {
           passwordController.text = value!;
         },
         textInputAction: TextInputAction.next,
         decoration: InputDecoration(
           prefixIcon: Icon(Icons.vpn_key,color: Colors.white60,),
           suffixIcon: InkWell(
             onTap: togglePasswordView,
             child: Icon(Icons.visibility,color: Colors.white60,),
           ),
           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
           hintText: "Password",
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
         ));

     //confirm password field
     final confirmPasswordField =TextFormField(
         autofocus: false,
         controller: confirmPasswordController,
         obscureText: isHiddenPassword,
         validator: (value) {
           if (confirmPasswordController.text !=
               passwordController.text) {
             return "Password don't match";
           }
           return null;
         },
         onSaved: (value) {
           confirmPasswordController.text = value!;
         },
         textInputAction: TextInputAction.done,
         decoration: InputDecoration(
           prefixIcon: Icon(Icons.vpn_key,color: Colors.white60,),
           suffixIcon: InkWell(
           onTap: togglePasswordView,
           child: Icon(Icons.visibility,color: Colors.white60,
           ),
         ),

           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
           hintText: "Confirm Password",
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
         ));


     final signUpButton =Material(
       elevation: 5,
       borderRadius: BorderRadius.circular(30),
       color: Colors.green,
       child: MaterialButton(
           padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
           minWidth: MediaQuery.of(context).size.width,
           onPressed: () {
             signUp(emailController.text, passwordController.text);
           },
           child: Text(
             "SignUp",
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          "Sign Up",
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 45),
                      nameField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      phoneNumberField,
                      SizedBox(height: 20),
                      passwordField,
                      SizedBox(height: 20),
                      confirmPasswordField,
                      SizedBox(height: 20),
                      signUpButton,
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ))),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
       _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text;
    userModel.phoneNumber = phoneNumberController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
  }

  togglePasswordView() {

    setState(() {
      isHiddenPassword =!isHiddenPassword;
    });
  }

}


