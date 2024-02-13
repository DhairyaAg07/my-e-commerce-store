import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/home_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class RegistrationTabPage extends StatefulWidget {
  @override
  State<RegistrationTabPage> createState() => _RegistrationTabPageState();
}

class _RegistrationTabPageState extends State<RegistrationTabPage> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
  TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = "";

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  formValidation() async {
    if (imgXFile == null) {
      Fluttertoast.showToast(msg: "Please select an image.");
    } else {
      if (passwordEditingController.text ==
          confirmPasswordEditingController.text) {
        if (nameEditingController.text.isNotEmpty &&
            emailEditingController.text.isNotEmpty &&
            passwordEditingController.text.isNotEmpty &&
            confirmPasswordEditingController.text.isNotEmpty) {
          
          
          // upload the image to storage
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
              .ref()
              .child("usersImages")
              .child(fileName);

          fStorage.UploadTask uploadImageTask =
          storageRef.putFile(File(imgXFile!.path));

          fStorage.TaskSnapshot taskSnapshot =
          await uploadImageTask.whenComplete(() {});

          taskSnapshot.ref.getDownloadURL().then((urlImage) {
            downloadUrlImage = urlImage;
          });

          
          // save the user info to the firestore database
          saveInformationToDatabase();
        } else {
          Fluttertoast.showToast(
              msg: "Please complete the form. Do not leave any text field empty");
        }
      } else {
        Fluttertoast.showToast(msg: "Passwords do not match");
      }
    }
  }

  saveInformationToDatabase() async {
    User? currentUser;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailEditingController.text.trim(),
      password: passwordEditingController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Fluttertoast.showToast(msg: "Error Occured: \n $errorMessage ");
    });

    if (currentUser != null) {
      saveInfoToFirestoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set(
      {
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": nameEditingController.text.trim(),
        "photoUrl": downloadUrlImage,
        "status": "approved",
        "userCart": ["initialValue"],
      },
    );

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", nameEditingController.text.trim());
    await sharedPreferences!.setString("photoUrl", downloadUrlImage);
    await sharedPreferences!.setStringList("status", ["initialValue"]);
    
    Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage:
                imgXFile == null ? null : FileImage(File(imgXFile!.path)),
                child: imgXFile == null
                    ? Icon(
                  Icons.add_photo_alternate,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.20,
                )
                    : null,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    textEditingController: nameEditingController,
                    iconData: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: emailEditingController,
                    iconData: Icons.mail,
                    hintText: "Email",
                    isObsecure: false,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: passwordEditingController,
                    iconData: Icons.lock,
                    hintText: "Password",
                    isObsecure: true,
                    enabled: true,
                  ),
                  CustomTextField(
                    textEditingController: confirmPasswordEditingController,
                    iconData: Icons.password,
                    hintText: "Confirm Password",
                    isObsecure: true,
                    enabled: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              onPressed: () {
                formValidation();
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
