import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? password;
  String? confirm;

  signUp() async {
    if (password == confirm) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        if (userCredential.user != null) {
          await userCredential.user!.sendEmailVerification();
        } else {
          final snackBar = SnackBar(
              content: Text(
                  'Error with email verfication: please check the inputted email and submit the form again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        final snackBar = SnackBar(
            content: Text('Account created! Now verify that email.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, '/verifyemail');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          final snackBar = SnackBar(
              content: Text('Need a valid email address.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (e.code == 'email-already-in-use') {
          final snackBar = SnackBar(
              content: Text('That email is already being used.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (e.code == 'weak-password') {
          final snackBar = SnackBar(
              content: Text('Password is too weak.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
              content: Text('Unknown error occurred. Check network connection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20)),
              backgroundColor: Colors.red);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      final snackBar = SnackBar(
          content: Text('Passwords need to match',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20)),
          backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, decoration: TextDecoration.underline),
              ),
            ),
            const Divider(thickness: .003, color: Colors.white),
            ElevatedButton(
              onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Back to Sign In Page',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
              ),
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)))),
            ),
            const Divider(thickness: 1.8, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() => {email = value})
                      }
                  },
              ),
            ),
            const Divider(thickness: 0.05, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() => {password = value})
                      }
                  },
                  obscureText: true,
              ),
            ),
            const Divider(thickness: 0.05, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 2),
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Confirm Password'),
                  obscureText: true,
                  onChanged: (value) => {
                    if (mounted)
                      {
                        setState(() => {confirm = value})
                      }
                  },
              ),
            ),
            const Divider(thickness: 0.05, color: Colors.white),
            ElevatedButton(
              onPressed: () {
                  signUp();
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
              ),
              style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)))),
            ),
            const Divider(color: Colors.white, thickness: 10),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Image(
                image: AssetImage('assets/img/sign_up.jpg'),
              ),
            ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
        ),
      ),
    );
  }
}
