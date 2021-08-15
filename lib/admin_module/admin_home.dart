import 'package:flutter/material.dart';
import 'package:vote_app/admin_module/new_election.dart';
import 'package:vote_app/admin_module/ongoing_election.dart';
import 'package:vote_app/services/auth.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int index = 0;
  PageController pageController = PageController();
  whenPageChanges(int pageIndex) {
    index = pageIndex;
  }

  changePageOnTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    void switchSelectedItem(int newIndex) {
      index = newIndex;
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          backgroundColor: Color(0xff004445),
          resizeToAvoidBottomInset: false,
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
                  icon: Icon(Icons.add),
                  label: 'New Election',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.poll),
                  label: 'Ongoing Election',
                )
              ]),
          appBar: AppBar(
            leadingWidth: 150,
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            centerTitle: false,
            title: Text(
              'Admin Home',
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    AuthService().logOut();
                  },
                  child: Text('Logout'))
            ],
          ),
          body: PageView(
            pageSnapping: true,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: whenPageChanges(index),
            controller: pageController,
            children: <Widget>[NewElection(), OngoingElection()],
          )),
    );
  }
}
