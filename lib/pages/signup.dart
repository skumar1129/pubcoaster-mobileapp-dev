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
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();
      } else {
        final snackBar = SnackBar(content: Text('Error with email verfication: please check the inputted email and submit the form again.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      final snackBar = SnackBar(content: Text('Account created!! WooT', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.green);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacementNamed(context, '/verifyemail');
    } else {
      final snackBar = SnackBar(content: Text('Passwords no matchy', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)), backgroundColor: Colors.red);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              'Sign Up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text(
                'Back to Sign In Page',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))),
            ),
            const Divider(thickness: 0.05, color: Colors.white),
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
            const Divider(thickness: 0.05, color: Colors.white),
            TextField(
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
            const Divider(thickness: 0.05, color: Colors.white),
            TextField(
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
            ElevatedButton(
              onPressed: () {
                signUp();
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))),
            ),
            Expanded(
              child: Image(
                image: AssetImage('assets/img/sign_up.jpg'),
              ),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
