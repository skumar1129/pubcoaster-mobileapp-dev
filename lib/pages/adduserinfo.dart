import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:NewApp/services/userservice.dart';

class AddUserInfo extends StatefulWidget {
  @override
  _AddUserInfoState createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {
  // File _image = '' as File;
  final picker = ImagePicker();
  final userService = new UserService();
  String? username;
  String? firstname;
  String? lastname;
  File? _image;
  bool filePicked = false;

  Future getImage(bool gallery) async {
    final pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    if (mounted) {
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          filePicked = true;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }
  }

  Widget alertText() {
    if (!filePicked) {
      return Text('Choose an upload method',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    } else {
      return Text(_image.toString(),
          style: TextStyle(
              fontStyle: FontStyle.italic, color: Colors.black, fontSize: 16));
    }
  }

  Widget pictureButton() {
    if (!filePicked) {
      return FloatingActionButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext content) {
              //getImage()
              return AlertDialog(
                title: Text('Choose an upload method', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 23), textAlign: TextAlign.center,),
                backgroundColor: Colors.white,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(child: Icon(Icons.file_upload),
                      onPressed: () => getImage(true),
                      tooltip: 'Upload from storage',
                      backgroundColor: Colors.red,
                    ),
                    FloatingActionButton(
                      child: Icon(Icons.camera),
                      tooltip: 'Upload from camera',
                      onPressed: () => getImage(false),
                      backgroundColor: Colors.red,
                    )
                  ]
                )
              );
            }),
        tooltip: 'Picture (Optional)',
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.red,
      );
    } else {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text('File Successfully Picked!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20)),
        ),
        FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext content) {
                //getImage()
                return AlertDialog(
                  title: Text('Choose an upload method', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 23), textAlign: TextAlign.center,),
                  backgroundColor: Colors.white,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(child: Icon(Icons.file_upload),
                        onPressed: () => getImage(true),
                        tooltip: 'Upload from storage',
                        backgroundColor: Colors.red,
                      ),
                      FloatingActionButton(
                        child: Icon(Icons.camera),
                        tooltip: 'Upload from camera',
                        onPressed: () => getImage(false),
                        backgroundColor: Colors.red,
                      )
                    ]
                  )
                );
              }),
          tooltip: 'Picture (Optional)',
          child: Icon(Icons.add_a_photo),
          backgroundColor: Colors.red,
        )
      ]);
    }
  }

  showLoadingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext content) {
        //getImage()
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(child: SizedBox(height: MediaQuery.of(context).size.height * .2, width: MediaQuery.of(context).size.height * .2, child: CircularProgressIndicator(backgroundColor: Colors.black, strokeWidth: 10,))));
    });
  }

  submitUser() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    if (username == null ||
        username == "" ||
        firstname == null ||
        firstname == "" ||
        lastname == null ||
        lastname == "") {
        Navigator.of(context).pop();
      final snackBar = SnackBar(
          content: Text(
              'Error with form: please make sure to fill out all the info before submitting.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      bool needToPop = true;
      showLoadingDialog();
      bool succeed = false;
      if (filePicked) {
        try {
          final firebase_storage.Reference storageRef = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('prof_pics/${_image!.path.split("/").last}');
          firebase_storage.UploadTask task = storageRef.putFile(_image!);
          await task.whenComplete(() async {
            storageRef.getDownloadURL().then((url) async {
              String fullname = '$firstname $lastname';
              var body = {
                'username': username,
                'email': email,
                'firstName': firstname,
                'lastName': lastname,
                'fullName': fullname,
                'picLink': url
              };
              succeed = await userService.createUser(body);
              if (!succeed) {
                Navigator.of(context).pop();
                needToPop = false;
                final snackBar = SnackBar(
                    content: Text(
                        'Error: could not create user. Check network connection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20)),
                    backgroundColor: Colors.red);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }
              try {
                await FirebaseAuth.instance.currentUser!
                    .updateProfile(displayName: username, photoURL: url);
              } catch (e) {
                if (needToPop) {
                  needToPop = false;
                  Navigator.of(context).pop();
                }
                print(e);
                final snackBar = SnackBar(
                    content: Text(
                        'Error updating profile! Check network connection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20)),
                    backgroundColor: Colors.red);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          });
        } on firebase_core.FirebaseException catch (e) {
          if (needToPop) {
            needToPop = false;
            Navigator.of(context).pop();
          }
          print(e);
          final snackBar = SnackBar(
              content: Text(
                  'Unable to upload file. Please check your network connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
        if (needToPop) {
          needToPop = false;
          Navigator.of(context).pop();
        }
        if (succeed) {
          final snackBar = SnackBar(
              content: Text('Successfully updated profile!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.green);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        String fullname = '$firstname $lastname';
        var body = {
          'username': username,
          'email': email,
          'firstName': firstname,
          'lastName': lastname,
          'fullName': fullname,
          'picLink': ''
        };
        succeed = await userService.createUser(body);
        if (!succeed) {
          Navigator.of(context).pop();
          needToPop = false;
          final snackBar = SnackBar(
              content: Text(
                  'Error: could not create user. Check network connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
        try {
          await FirebaseAuth.instance.currentUser!
              .updateProfile(displayName: username);
        } catch (e) {
          if (needToPop) {
            needToPop = false;
            Navigator.of(context).pop();
          }
          print(e);
          final snackBar = SnackBar(
              content: Text('Error updating profile! Check network connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
        if (needToPop) {
          needToPop = false;
          Navigator.of(context).pop();
        }
        if (succeed) {
          final snackBar = SnackBar(
              content: Text('Successfully updated profile!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.green);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    }
  }

  goToSignIn() {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(
              height: 200,
            ),
            Text(
              'Hold up, fill out a User Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            const Divider(
              color: Colors.white,
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {username = value})
                    }
                },
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {firstname = value})
                    }
                },
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 14),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {lastname = value})
                    }
                },
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 15,
            ),
            pictureButton(),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    goToSignIn();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Back to Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                ),
                const SizedBox(
                  width: 17,
                ),
                ElevatedButton(
                  onPressed: () {
                    submitUser();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            SizedBox(height: 200)
          ],
        ),
      )),
    );
  }
}
