import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vote_app/services/auth.dart';

class LoginWithGoogle extends StatefulWidget {
  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff021c1e),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('E-Vote!', style: TextStyle(fontSize: 24))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Icon(
                Icons.poll,
                size: 140,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Do you have a google account'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: CupertinoButton(
                  borderRadius: BorderRadius.circular(45),
                  onPressed: () {
                    AuthService().signInWithGoogle().then((e) {
                      if (e == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Error: Not a redeemer\'s university email')));
                      } else {
                        print('log in successful');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Successful')));
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffFF0000),
                        borderRadius: BorderRadius.circular(45)),
                    width: double.infinity,
                    height: 60,
                    child: Center(
                        child: Text('Login with Google',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16))),
                  )),
            )
          ],
        ));
  }
}
