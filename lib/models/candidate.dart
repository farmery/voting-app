import 'dart:convert';

class Candidate {
  String post;
  String candidateName;
  String matricNo;

  Candidate({this.candidateName, this.matricNo, this.post});

  Map<String, dynamic> toMap() {
    return {
      'post': post,
      'candidateName': candidateName,
      'matricNo': matricNo,
    };
  }

  factory Candidate.fromMap(Map map) {
    return Candidate(
      post: map['post'] ?? '',
      candidateName: map['candidateName'] ?? '',
      matricNo: map['matricNo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Candidate.fromJson(String source) =>
      Candidate.fromMap(json.decode(source));
}
