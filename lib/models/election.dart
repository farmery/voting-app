class Election {
  String electionTitle;

  Election({this.electionTitle});
  Map<String, dynamic> toMap() {
    return {
      'electionTitle': electionTitle,
    };
  }

  factory Election.fromMap(Map<String, dynamic> map) {
    return Election(
      electionTitle: map['electionTitle'] ?? '',
    );
  }
}
