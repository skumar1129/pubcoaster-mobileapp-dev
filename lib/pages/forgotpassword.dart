import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? username;
  bool submittedUser = false;
  String? code;
  String? newPassword;
  String? confirm;

  sendUsername() async {}

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
                  border: OutlineInputBorder(), labelText: 'Username'),
              onChanged: (value) => {
                if (mounted)
                  {
                    setState(() => {username = value})
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
                ElevatedButton(
                  onPressed: () {
                    sendUsername();
                  },
                  child: submittedUser == true
                      ? Text(
                          'Resend code',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
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
            if (submittedUser) ...[
              Text(
                'Fill in the code and new password or hit submit above to resend the code',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Verification code',
                ),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {code = value})
                    }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New password',
                ),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {newPassword = value})
                    }
                },
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm password',
                ),
                onChanged: (value) => {
                  if (mounted)
                    {
                      setState(() => {confirm = value})
                    }
                },
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  changePassword();
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
            ]
          ],
        ),
      ),
    );
  }
}
