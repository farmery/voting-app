import 'dart:convert';

class Candidate {
  String candidateName;
  String matricNo;
  int noOfVotes;

  Candidate({this.candidateName, this.matricNo, this.noOfVotes});

  factory Candidate.fromFirebase(Map map) {
    return Candidate(
        candidateName: map['candidateName'],
        matricNo: map['matricNo'],
        noOfVotes: map['noOfVotes']);
  }

  Map<String, dynamic> toMap() {
    return {
      'candidateName': candidateName,
      'matricNo': matricNo,
      'noOfVotes': noOfVotes,
    };
  }

  factory Candidate.fromMap(Map<String, dynamic> map) {
    return Candidate(
      candidateName: map['candidateName'] ?? '',
      matricNo: map['matricNo'] ?? '',
      noOfVotes: map['noOfVotes'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Candidate.fromJson(String source) =>
      Candidate.fromMap(json.decode(source));
}
