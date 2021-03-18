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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        print('nice!');
        // _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
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
      String fullname = '$firstname $lastname';
      var body = {
        'username': username,
        'email': email,
        'firstName': firstname,
        'lastName': lastname,
        'fullName': fullname,
        'picLink': ''
      };
      // TODO: add checks to these calls and possibly adding photo
      bool succeed = await userService.createUser(body);
      if (!succeed) {
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
      }
      try {
        await FirebaseAuth.instance.currentUser!
            .updateProfile(displayName: username);
      } catch (e) {
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
      }
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

  goToSignIn() {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const SizedBox(
          height: 35,
        ),
        Center(
          child: Text(
            'Hold up, fill out a User Profile',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.5,
        ),
        Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                goToSignIn();
              },
              child: Text(
                'Back to Sign In',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))),
            ),
            ElevatedButton(
              onPressed: () {
                submitUser();
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        const Divider(
          color: Colors.white,
          thickness: 0.5,
        ),
        Form(
            child: Expanded(
                child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Divider(
                color: Colors.white,
                thickness: 0.75,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {username = value})
                    }
                },
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {firstname = value})
                    }
                },
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name*'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {lastname = value})
                    }
                },
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.75,
              ),
              FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Profile Picture (Optional)',
                child: Icon(Icons.add_a_photo),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ))),
      ],
    ));
  }
}
