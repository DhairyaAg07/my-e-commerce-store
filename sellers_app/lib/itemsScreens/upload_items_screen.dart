import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/brandsScreens/home_screen.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/models/brands.dart';
import 'package:sellers_app/splashScreen/my_splash_screen.dart';
import 'package:sellers_app/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class UploadItemsScreen extends StatefulWidget {
  Brands? model;

  UploadItemsScreen({this.model,});

  @override
  State<UploadItemsScreen> createState() => _UploadItemsScreenState();
}

class _UploadItemsScreenState extends State<UploadItemsScreen> {
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  TextEditingController itemInfoTextEditingController = TextEditingController();
  TextEditingController itemTitleTextEditingController = TextEditingController();
  TextEditingController itemDescriptionTextEditingController = TextEditingController();
  TextEditingController itemPriceTextEditingController = TextEditingController();

  bool uploading = false;
  String downloadUrlImage = "";
  String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  // Save item info to Firestore
  saveItemInfo() {
    final sellerUid = sharedPreferences!.getString("uid");
    final brandId = widget.model!.brandID;

    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerUid)
        .collection("brands")
        .doc(brandId)
        .collection("items")
        .doc(itemUniqueId)
        .set({
      "itemID": itemUniqueId,
      "brandID": brandId,
      "sellerUID": sellerUid,
      "sellerName": sharedPreferences!.getString("name"),
      "itemInfo": itemInfoTextEditingController.text.trim(),
      "itemTitle": itemTitleTextEditingController.text.trim(),
      "longDescription": itemDescriptionTextEditingController.text.trim(),
      "price": itemPriceTextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrlImage,
    }).then((_) {
      Fluttertoast.showToast(msg: "Item has been added successfully.");
      setState(() {
        uploading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
    });
  }

  // Validate the form and upload item info
  validateUploadForm() async {
    if (imgXFile != null) {
      if (itemInfoTextEditingController.text.isNotEmpty &&
          itemTitleTextEditingController.text.isNotEmpty &&
          itemDescriptionTextEditingController.text.isNotEmpty &&
          itemPriceTextEditingController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
            .ref()
            .child("sellersItemsImages")
            .child(fileName);

        fStorage.UploadTask uploadImageTask = storageRef.putFile(File(imgXFile!.path));
        fStorage.TaskSnapshot taskSnapshot = await uploadImageTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((urlImage) {
          downloadUrlImage = urlImage;
        });

        saveItemInfo();
      } else {
        Fluttertoast.showToast(msg: "Please fill complete form.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please choose image.");
    }
  }

  // Screen for uploading items
  uploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                uploading ? null : validateUploadForm();
              },
              icon: const Icon(Icons.cloud_upload),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text("Upload New Item"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          uploading ? linearProgressBar() : Container(),

          // Image display
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imgXFile!.path)),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Divider(color: Colors.pinkAccent, thickness: 1),

          // Item info input field
          ListTile(
            leading: const Icon(Icons.perm_device_information, color: Colors.deepPurple),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemInfoTextEditingController,
                decoration: const InputDecoration(
                  hintText: "item info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.pinkAccent, thickness: 1),

          // Item title input field
          ListTile(
            leading: const Icon(Icons.title, color: Colors.deepPurple),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemTitleTextEditingController,
                decoration: const InputDecoration(
                  hintText: "item title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.pinkAccent, thickness: 1),

          // Item description input field
          ListTile(
            leading: const Icon(Icons.description, color: Colors.deepPurple),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemDescriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: "item description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.pinkAccent, thickness: 1),

          // Item price input field
          ListTile(
            leading: const Icon(Icons.camera, color: Colors.deepPurple),
            title: SizedBox(
              width: 250,
              child: TextField(
                controller: itemPriceTextEditingController,
                decoration: const InputDecoration(
                  hintText: "item price",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.pinkAccent, thickness: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imgXFile == null ? defaultScreen() : uploadFormScreen();
  }

  // Default screen with option to add new item
  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text("Add New Item"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.purpleAccent],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_photo_alternate, color: Colors.white, size: 200),

              ElevatedButton(
                onPressed: () {
                  obtainImageDialogBox();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Add New Item",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog box for selecting image source
  obtainImageDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Item Image",
            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureImagewithPhoneCamera();
              },
              child: const Text(
                "Capture image with Camera",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                getImageFromGallery();
              },
              child: const Text(
                "Select image from Gallery",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Capture image with phone camera
  captureImagewithPhoneCamera() async {
    Navigator.pop(context);
    imgXFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgXFile;
    });
  }

  // Select image from gallery
  getImageFromGallery() async {
    Navigator.pop(context);
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }
}
