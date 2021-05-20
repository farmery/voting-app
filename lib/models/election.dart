class Election {
  String electionTitle;

  Election({this.electionTitle});

  factory Election.fromFirebase(Map electionMap) {
    return Election(electionTitle: electionMap['electionTitle']);
  }
}
