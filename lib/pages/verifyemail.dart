import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  goToSignUp() {
    Navigator.pushReplacementNamed(context, '/signup');
  }

  resendEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user.sendEmailVerification();
      } else {
        final snackBar = SnackBar(content: Text('Error: had trouble finding user in system.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text('Error: could not send verification email.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    final snackBar = SnackBar(content: Text('Successfully resent email!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.green);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  goToSignIn() {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 35,
        ),
        ElevatedButton(
          onPressed: () {
            goToSignUp();
          },
          child: Text(
            'Go back to sign up',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)))),
        ),
        const Divider(thickness: 1.0, color: Colors.white),
        Text(
          'Send a verification email to your account and sign back in once complete, or go back to sign up and register a new email',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1.0, color: Colors.white),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  resendEmail();
                },
                child: Text(
                  'Resend Email',
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
                  goToSignIn();
                },
                child: Text(
                  'Go to sign in',
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
