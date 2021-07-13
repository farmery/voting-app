import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:vote_app/voter_module/login_with_google_screen.dart';
import 'package:vote_app/voter_module/voter_home.dart';

class VoterWrapper extends StatefulWidget {
  @override
  _VoterWrapperState createState() => _VoterWrapperState();
}

class _VoterWrapperState extends State<VoterWrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GoogleSignInAccount>(context);
    // final user = {};
    return user == null ? LoginWithGoogle() : VoterHomeScreen();
  }
}
