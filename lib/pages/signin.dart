import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email;
  String? password;

  signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user?.emailVerified == false) {
        Navigator.pushReplacementNamed(context, '/verifyemail');
      } else if (userCredential.user?.displayName == null) {
        Navigator.pushReplacementNamed(context, '/adduserinfo');
      } else {
        final snackBar = SnackBar(
            content: Text('Successfully signed in',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
            content: Text('No user found for that email.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
            content: Text('Wrong password for that email.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'user-disabled') {
        final snackBar = SnackBar(
            content: Text('This user has been disabled.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'invalid-email') {
        final snackBar = SnackBar(
            content: Text('Email needs to be valid.',
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
                  padding: const EdgeInsets.only(top: 16, bottom: 0),
                  child: Text(
                    'Welcome to Pubcoasters!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, decoration: TextDecoration.underline),
                  ),
              ),
              const Divider(thickness: 0.001, color: Colors.white),
              Text(
                  'Sign in or sign up and start posting!',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              const Divider(thickness: 0.5, color: Colors.white),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Go to Sign Up Page',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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
              const Divider(thickness: 1.0, color: Colors.white),
              Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
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
              const Divider(thickness: 0.5, color: Colors.white),
              Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    onChanged: (value) => {
                      if (mounted)
                        {
                          setState(() => {password = value})
                        }
                    },
                    obscureText: true,
                  ),
              ),
              const Divider(thickness: 1.0, color: Colors.white),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/forgot');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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
                    ElevatedButton(
                      onPressed: () {
                        signIn(email!, password!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)))),
                    )
                  ],
              ),
              const Divider(color: Colors.white, thickness: 10),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Image(
                  image: AssetImage('assets/img/sign_in.jpg')
                ),
              ),
              const SizedBox(
                  height: 100,
              ),
            ]),
          ),
      ),
      //resizeToAvoidBottomInset: false,
    );
  }
}
