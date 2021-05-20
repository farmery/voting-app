import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vote_app/models/candidate.dart';

import 'package:vote_app/services/database.dart';

class PostDetail extends StatefulWidget {
  final String titleOfPost;
  const PostDetail({
    Key key,
    this.titleOfPost,
  }) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
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
                            Text(widget.titleOfPost,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      //list of candidates
                      Expanded(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (_, i) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListTile(
                                      title: Text('Tomiwa dahunsi'),
                                      subtitle: Text('10 candidates'),
                                      tileColor: Color(0xff021c1e),
                                      trailing: CupertinoButton(
                                        onPressed: () {},
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          'Vote',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  )))
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
