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
        final snackBar = SnackBar(content: Text('Successfully signed in yo', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(content: Text('Ope, no user found for that email.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(content: Text('Ope, wrong password for that email.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Text(
                'Welcome to Barz BRO!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Divider(thickness: 0.5, color: Colors.white),
              Text(
                'Sign in or sign up and start posting!',
                style: TextStyle(fontSize: 20),
              ),
              const Divider(thickness: 0.5, color: Colors.white),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text(
                  'Go to Sign Up Page',
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
              const Divider(thickness: 0.5, color: Colors.white),
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
              const Divider(thickness: 0.5, color: Colors.white),
              TextField(
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
              const Divider(thickness: 0.5, color: Colors.white),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/forgot');
                    },
                    child: Text(
                      'Forgot Password',
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
                      signIn(email!, password!);
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
                ],
              ),
              Expanded(
                child: Image(
                  image: AssetImage('assets/img/sign_in.jpg'),
                ),
                flex: 1,
              )
            ]),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
