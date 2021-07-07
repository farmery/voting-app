import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/models/candidate.dart';
import 'package:vote_app/models/post.dart';
import 'package:vote_app/services/database.dart';

class EditPost extends StatefulWidget {
  final String titleOfPost;
  final String titleOfElection;

  EditPost({this.titleOfPost, this.titleOfElection});
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  Database database = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.titleOfPost, style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Text('Add or remove candidates'),
              SizedBox(
                height: 16,
              ),
              // edit post
              Expanded(
                  child: StreamBuilder<List<Candidate>>(
                stream: database
                    .getCandidates(Post(titleOfPost: widget.titleOfPost)),
                builder: (_, snapshot) {
                  final candidates = snapshot?.data;
                  return ListView.builder(
                      itemCount: candidates?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                candidates.elementAt(index).candidateName,
                                style: TextStyle(fontSize: 18),
                              ),
                              subtitle:
                                  Text(candidates.elementAt(index).matricNo),
                              trailing: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(Icons.clear),
                                  onPressed: () {
                                    database.deleteCandidate(candidates[index]);
                                  }),
                            ),
                            Divider()
                          ],
                        );
                      });
                },
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  String candidateName;
                  String candidateMatricNo;
                  return Dialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Container(
                      height: 203,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Enter candidate full name',
                                  labelStyle: TextStyle(fontSize: 14)),
                              onChanged: (val) {
                                candidateName = val;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Enter candidate matric number',
                                  labelStyle: TextStyle(fontSize: 14)),
                              onChanged: (val) {
                                candidateMatricNo = val;
                              },
                            ),
                            SizedBox(height: 8),
                            MaterialButton(
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.blue,
                                child: Text(
                                  'Add Candidate',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (candidateName != null &&
                                      candidateMatricNo != null) {
                                    //add candidate
                                    database
                                        .addCandidate(Candidate(
                                            candidateName: candidateName,
                                            matricNo: candidateMatricNo,
                                            post: widget.titleOfPost))
                                        .then((value) =>
                                            Navigator.of(context).pop())
                                        .catchError((e) {
                                      ScaffoldMessengerState().showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Please check your internet connection')));
                                      print(e);
                                    });
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
