import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool confirmTime = false;
  String? email;
  String? password;
  String? confirm;
  String? code;

  signUp() async {}

  resendCode() async {}

  confirmUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if (!confirmTime) ...[
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password'),
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
            ] else ...[
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red)))),
              ),
              Text(
                'Confirm your email with confirmation code',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmation Code'),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {code = value})
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
                  ])
            ]
          ],
        ),
      ),
    );
  }
}
