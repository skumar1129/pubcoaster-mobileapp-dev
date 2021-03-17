import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? email;
  String? newPassword;
  String? confirm;

  sendEmail() async {
    if (email == null || email == "") {
      final snackBar = SnackBar(content: Text('Please fill out the email yo', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
    } catch (e) {
      final snackBar = SnackBar(content: Text('Error: could not send password reset email :(', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    final snackBar = SnackBar(content: Text('Success! Please check your email in order to reset your password.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.green);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  changePassword() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Fill out the information to reset your password',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {email = value})
                  }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  child: Text(
                    'Back to sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                ),
                ElevatedButton(
                  onPressed: () {
                    sendEmail();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
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
            ),
          ],
        ),
      ),
    );
  }
}
