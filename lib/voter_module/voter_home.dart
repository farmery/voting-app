import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_app/admin_module/ongoing_poll.dart';
import 'package:vote_app/models/post.dart';
import 'package:vote_app/services/auth.dart';
import 'package:vote_app/services/database.dart';
import 'package:vote_app/voter_module/post_detail.dart';

class VoterHomeScreen extends StatefulWidget {
  @override
  _VoterHomeScreenState createState() => _VoterHomeScreenState();
}

class _VoterHomeScreenState extends State<VoterHomeScreen> {
  int index = 0;
  PageController pageController = PageController();
  whenPageChanges(int pageIndex) {
    index = pageIndex;
  }

  changePageOnTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  bool hasVoted;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    String imageSrc = currentUser?.photoURL ?? null;

    void switchSelectedItem(int newIndex) {
      index = newIndex;
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Color(0xff004445),
              elevation: 0,
              currentIndex: index,
              onTap: (index) {
                setState(() {
                  switchSelectedItem(index);
                  changePageOnTap(index);
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.how_to_vote_rounded),
                  label: 'Ongoing Election',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.poll),
                  label: 'Results',
                )
              ]),
          appBar: AppBar(
            leadingWidth: 150,
            // centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(imageSrc),
                    )),
                Expanded(
                  child: Text(
                    currentUser.displayName,
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    AuthService().logOut();
                  },
                  child: Text('Logout'))
            ],
          ),
          body: PageView(controller: pageController, children: [
            FutureBuilder<Map>(
                future: Database().getElectionStatus(),
                builder: (context, snapshot) {
                  String status;
                  if (snapshot.data != null) {
                    status = snapshot.data['status'];
                  } else {
                    status = 'onGoing';
                  }
                  return status == 'onGoing'
                      ? PlaceYourVote()
                      : Container(
                          child: Center(
                            child: Text('No Running Election',
                                style: TextStyle(fontSize: 30)),
                          ),
                        );
                }),
            Results(),
          ])),
    );
  }
}

class Results extends StatelessWidget {
  const Results({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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

                    FutureBuilder<Map>(
                        future: Database().getElectionStatus(),
                        builder: (context, snapshot) {
                          String status;
                          if (snapshot.data != null) {
                            status = snapshot.data['status'];
                          } else {
                            status = 'onGoing';
                          }

                          return status == 'onGoing'
                              ? Expanded(
                                  child: StreamBuilder<List<Post>>(
                                    stream: Database().getPosts(),
                                    builder: (context, snapshot) {
                                      final posts = snapshot?.data ?? [];
                                      return ListView.builder(
                                        itemBuilder: (_, i) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              OnGoingPoll(posts: posts, i: i),
                                        ),
                                        itemCount: posts.length,
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      Icon(CupertinoIcons.timer,
                                          size: 300, color: Colors.grey),
                                      Text('Elections Results Pending...',
                                          style: TextStyle(fontSize: 30)),
                                    ],
                                  ),
                                );
                        }),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

class PlaceYourVote extends StatelessWidget {
  const PlaceYourVote({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database database = Database();

    return Stack(
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
                          SizedBox(width: 4),
                          Icon(
                            Icons.list_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('List of Polls',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    //list of posts
                    StreamBuilder<List<Post>>(
                        stream: database.getPosts(),
                        builder: (context, snapshot) {
                          final posts = snapshot.data ?? [];
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: posts.length ?? 0,
                                  itemBuilder: (_, i) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(CupertinoPageRoute(
                                                    builder: (_) => PostDetail(
                                                          titleOfPost: posts
                                                              .elementAt(i)
                                                              .titleOfPost,
                                                        )));
                                          },
                                          title: Text(
                                              posts.elementAt(i).titleOfPost),
                                          subtitle: Text('10 candidates'),
                                          tileColor: Color(0xff021c1e),
                                          trailing: FutureBuilder<Map>(
                                              future:
                                                  database.getElectionStatus(),
                                              builder: (context, snapshot) {
                                                String status;
                                                if (snapshot.data != null) {
                                                  status =
                                                      snapshot.data['status'];
                                                } else {
                                                  status = 'Ongoing';
                                                }
                                                return Text(
                                                  status,
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                );
                                              }),
                                          shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      )));
                        })
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
