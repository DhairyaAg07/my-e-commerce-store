import 'dart:io';
import 'package:flutter/material.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';


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


 XFile? imgXFile;
 final ImagePicker imagePicker=ImagePicker();
  
 getImageFromGallery() async
  {
    imgXFile= await imagePicker.pickImage(source: ImageSource.gallery);
    
    setState(() {
      imgXFile;
    });
    
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

            //   get or capture image
            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imgXFile ==null? null: FileImage(File(imgXFile!.path)),
                child: imgXFile==null? 
                Icon(
                  Icons.add_photo_alternate,
                  color: Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.20,
                ) : null,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            //   input fields
            Form(
              key: formKey,
              child: Column(
                children: [
                  // name
                  CustomTextField(
                    textEditingController: nameEditingController,
                    iconData: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                    enabled: true,
                  ),

                  //   email
                  CustomTextField(
                    textEditingController: emailEditingController,
                    iconData: Icons.mail,
                    hintText: "Email",
                    isObsecure: false,
                    enabled: true,
                  ),

                  //password
                  CustomTextField(
                    textEditingController: passwordEditingController,
                    iconData: Icons.lock,
                    hintText: "Password",
                    isObsecure: true,
                    enabled: true,
                  ),

                  //   confirmPassword

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
              onPressed: () {},
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
