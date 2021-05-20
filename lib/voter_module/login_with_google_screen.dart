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
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
                  onPressed: () {},
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
