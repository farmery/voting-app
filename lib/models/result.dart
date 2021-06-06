import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:vote_app/models/candidate.dart';

class Result {
  String postName;
  Candidate winner;
  Result({
    this.postName = '',
    @required this.winner,
  });

  Map<String, dynamic> toMap() {
    return {
      'postName': postName,
      'winner': winner.toMap(),
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      postName: map['postName'] ?? '',
      winner: Candidate.fromMap(map['winner']) ?? Candidate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) => Result.fromMap(json.decode(source));
}
