import 'package:flutter/cupertino.dart';
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
                    Expanded(
                      child: StreamBuilder<List<Post>>(
                        stream: database.getPosts(),
                        builder: (context, snapshot) {
                          final posts = snapshot?.data ?? [];
                          return ListView.builder(
                            itemBuilder: (_, i) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OnGoingPoll(posts: posts, i: i),
                            ),
                            itemCount: posts.length,
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CupertinoButton(
                          child: Text(
                            'End Election',
                          ),
                          onPressed: () {}),
                    ),
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

class OnGoingPoll extends StatelessWidget {
  const OnGoingPoll({Key key, @required this.posts, @required this.i})
      : super(key: key);

  final List<Post> posts;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff021c1e), borderRadius: BorderRadius.circular(15)),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(posts[i].titleOfPost,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: StreamBuilder<List<Candidate>>(
                stream: Database().getCandidates(posts[i]),
                builder: (context, snapshot) {
                  final candidates = snapshot?.data ?? [];
                  return ListView.separated(
                      separatorBuilder: (_, i) => Divider(
                            height: 0,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.white.withOpacity(0.5),
                          ),
                      itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(candidates[index].candidateName,
                                    style: TextStyle(fontSize: 18)),
                                FutureBuilder<int>(
                                  future:
                                      Database().getVotesNo(candidates[index]),
                                  builder: (context, snapshot) {
                                    final votesNo = snapshot?.data ?? 0;
                                    return Text('$votesNo Votes');
                                  },
                                )
                              ],
                            ),
                          ),
                      itemCount: candidates.length);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
