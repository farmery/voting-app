import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/models/candidate.dart';
import 'package:vote_app/models/post.dart';
import 'package:vote_app/models/vote.dart';
import 'package:vote_app/services/database.dart';

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
                                StreamBuilder<List<Vote>>(
                                    stream:
                                        Database().getVotes(candidates[index]),
                                    builder: (context, snapshot) {
                                      return Text(
                                          '${snapshot?.data?.length ?? 0} Votes');
                                    })
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