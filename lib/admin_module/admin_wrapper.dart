import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_app/admin_module/admin_home.dart';
import 'package:vote_app/admin_module/login_with_credentials.dart';

class AdminWrapper extends StatefulWidget {
  @override
  _AdminWrapperState createState() => _AdminWrapperState();
}

class _AdminWrapperState extends State<AdminWrapper> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    final user = {};
    return user == null ? LoginWithCredentails() : AdminHome();
  }
}
