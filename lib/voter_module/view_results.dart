import 'package:flutter/material.dart';

class ViewResults extends StatefulWidget {
  @override
  _ViewResultsState createState() => _ViewResultsState();
}

class _ViewResultsState extends State<ViewResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('View Results', style: TextStyle(color: Colors.black)),
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
                color: Color(0xff8D99FF),
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
                      // a list of posts results
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
