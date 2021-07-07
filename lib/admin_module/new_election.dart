import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/admin_module/add_candidate.dart';

import 'package:vote_app/models/candidate.dart';
import 'package:vote_app/models/post.dart';
import 'package:vote_app/services/database.dart';

import 'edit_post.dart';

class NewElection extends StatefulWidget {
  @override
  _NewElectionState createState() => _NewElectionState();
}

class _NewElectionState extends State<NewElection> {
  bool candidateListEmpty = false;

  List<Candidate> candidates;

  Database database = Database();
  bool enableCandidateAdd = false;

  @override
  Widget build(BuildContext context) {
    String titleOfElection = 'new election';
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                              Icons.poll,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('New Election',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Color(0xff021c1e),
                          child: ListOfPostsFromDb(
                            titleOfPost: titleOfElection,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Color(0xff021c1e),
                          child: NewPostWidget(
                            titleOfElection: titleOfElection,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class ListOfPostsFromDb extends StatefulWidget {
  final String titleOfPost;
  final String titleOfElection;
  const ListOfPostsFromDb({
    this.titleOfPost,
    this.titleOfElection,
    Key key,
  }) : super(key: key);

  @override
  _ListOfPostsFromDbState createState() => _ListOfPostsFromDbState();
}

class _ListOfPostsFromDbState extends State<ListOfPostsFromDb> {
  Database database = Database();

  //dummydata
  List registeredPosts = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff021c1e), borderRadius: BorderRadius.circular(15)),
      height: 200,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text('Registered posts',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          //list of registered posts
          SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<List<Post>>(
                stream: Database().getPosts(),
                builder: (context, snapshot) {
                  final posts = snapshot?.data ?? [];
                  return ListView.separated(
                      itemCount: posts.length,
                      separatorBuilder: (_, i) => Divider(
                            height: 0,
                            indent: 16,
                            endIndent: 16,
                            color: Colors.white.withOpacity(0.5),
                          ),
                      itemBuilder: (_, i) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => EditPost(
                                        titleOfPost: posts[i].titleOfPost,
                                        titleOfElection: 'new election',
                                      )));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(posts[i].titleOfPost,
                                        style: TextStyle(fontSize: 18)),
                                    Icon(Icons.edit, size: 18)
                                  ],
                                ),
                              ),
                            ),
                          ));
                }),
          )
        ],
      ),
    );
  }
}

class NewPostWidget extends StatelessWidget {
  final String titleOfElection;
  const NewPostWidget({
    this.titleOfElection,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String titleOfPost;
    return Container(
      height: 160,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Add Post to be contested for',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (val) {
                titleOfPost = val;
              },
              maxLines: 1,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 14),
                labelText: 'What is the title of the post?',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                  onPressed: () {
                    if (titleOfPost != null) {
                      Database().createPost(Post(titleOfPost: titleOfPost));
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => AddCandidates(
                                titleOfPost: titleOfPost,
                                titleOfElection: titleOfElection,
                              )));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
