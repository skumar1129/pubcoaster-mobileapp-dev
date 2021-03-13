import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool? confirmTime;
  String? email;
  resendCode() async {
    await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email!,
        actionCodeSettings: ActionCodeSettings(
            url:
                'https://newapp-847ed.firebaseapp.com/__/auth/action?mode=action&oobCode=code',
            handleCodeInApp: true));
  }

  confirmUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (mounted) {
              setState(() => {confirmTime = false});
            }
          },
          child: Text(
            'Go back',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)))),
        ),
        Text(
          'Let us know the email you are trying to verify',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Email to Verify'),
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
                  resendCode();
                },
                child: Text(
                  'Resend code',
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
                  confirmUser();
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
              )
            ]),
      ],
    ));
  }
}
