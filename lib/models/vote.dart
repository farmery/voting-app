import 'dart:convert';

class Vote {
  String voterId;
  String candidateName;
  Vote({
    this.voterId = '',
    this.candidateName = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'voterId': voterId,
      'candidateName': candidateName,
    };
  }

  factory Vote.fromMap(Map<String, dynamic> map) {
    return Vote(
      voterId: map['voterId'] ?? '',
      candidateName: map['candidateName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Vote.fromJson(String source) => Vote.fromMap(json.decode(source));
}
