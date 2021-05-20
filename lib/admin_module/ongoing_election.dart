import 'package:flutter/material.dart';
import 'package:vote_app/models/candidate.dart';
import 'package:vote_app/models/post.dart';
import 'package:vote_app/services/database.dart';

class OngoingElection extends StatefulWidget {
  @override
  _OngoingElectionState createState() => _OngoingElectionState();
}

class _OngoingElectionState extends State<OngoingElection> {
  Database database = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35))),
                elevation: 3,
                shadowColor: Colors.black,
                color: Color(0xff004445),
                child: FractionallySizedBox(
                  heightFactor: 0.98,
                  widthFactor: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 8),
                            Icon(
                              Icons.insert_drive_file,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Election Results',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      //list of posts
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
