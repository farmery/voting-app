import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/services/auth.dart';

class LoginWithCredentails extends StatefulWidget {
  @override
  _LoginWithCredentailsState createState() => _LoginWithCredentailsState();
}

class _LoginWithCredentailsState extends State<LoginWithCredentails> {
  String password;
  String email;
  Future authAttempt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('E-Vote!', style: TextStyle(fontSize: 24))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Icon(
                Icons.poll,
                size: 140,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Enter your credentials'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onFieldSubmitted: (email) {
                        this.email = email;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter email address'),
                    ),
                    TextFormField(
                      obscureText: true,
                      onFieldSubmitted: (password) {
                        this.password = password;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enter your password'),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CupertinoButton(
                        borderRadius: BorderRadius.circular(45),
                        onPressed: () {
                          // AuthService().adminSignIn(email, password);
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Login successful')));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff8D99FF),
                              borderRadius: BorderRadius.circular(45)),
                          width: double.infinity,
                          height: 60,
                          child: Center(
                              child: Text('Login as Admin',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))),
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
