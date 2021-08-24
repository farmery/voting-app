import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/models/candidate.dart';
import 'package:vote_app/models/post.dart';
import 'package:vote_app/services/database.dart';

class PostDetail extends StatefulWidget {
  final User user;
  final String titleOfPost;
  const PostDetail({
    Key key,
    this.user,
    this.titleOfPost,
  }) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Database database = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Place a vote',
        ),
      ),
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
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.titleOfPost,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    //list of candidates
                    StreamBuilder<List<Candidate>>(
                        stream: database.getCandidates(
                            Post(titleOfPost: widget.titleOfPost)),
                        builder: (context, snapshot) {
                          final candidates = snapshot?.data ?? [];
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: candidates.length ?? 0,
                                  itemBuilder: (_, i) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ListTile(
                                          title:
                                              Text(candidates[i].candidateName),
                                          subtitle:
                                              Text(candidates[i].matricNo),
                                          tileColor: Color(0xff021c1e),
                                          trailing: CupertinoButton(
                                            onPressed: () {
                                              database
                                                  .castVote(
                                                      candidates[i],
                                                      widget.user.email,
                                                      widget.titleOfPost)
                                                  .then((value) => value == null
                                                      ? ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                              content: Text(
                                                                  'You already voted for this candidate')))
                                                      : showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                              AlertDialog(
                                                                content: Text(
                                                                    'You Vote for ${candidates[i].candidateName} has been placed'),
                                                              )));
                                            },
                                            padding: EdgeInsets.zero,
                                            child: Text(
                                              'Vote',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ),
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      )));
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
