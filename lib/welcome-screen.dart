import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/admin_module/admin_wrapper.dart';
import 'package:vote_app/voter_module/voter_wrapper.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text('E-Voting System', style: TextStyle(fontSize: 24))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Icon(
            Icons.stacked_line_chart,
            size: 140,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('What type of user are you?'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: CupertinoButton(
              borderRadius: BorderRadius.circular(45),
              onPressed: () async {
                await Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  return VoterWrapper();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff004445),
                    borderRadius: BorderRadius.circular(45)),
                width: double.infinity,
                height: 60,
                child: Center(
                    child: Text('Login as Voter',
                        style: TextStyle(color: Colors.white, fontSize: 16))),
              )),
        ),
        Padding(padding: const EdgeInsets.all(0), child: Text('Or')),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: CupertinoButton(
              borderRadius: BorderRadius.circular(45),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    title: 'Admin Wrapper',
                    builder: (context) => AdminWrapper()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff004445),
                    borderRadius: BorderRadius.circular(45)),
                width: double.infinity,
                height: 60,
                child: Center(
                    child: Text('Login as Admin',
                        style: TextStyle(color: Colors.white, fontSize: 16))),
              )),
        )
      ],
    ));
  }
}
