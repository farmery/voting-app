class Election {
  String electionTitle;
  int isOngoing;

  Election({this.electionTitle, this.isOngoing});
  Map<String, dynamic> toMap() {
    return {'electionTitle': electionTitle, 'isOngoing': isOngoing};
  }

  factory Election.fromMap(Map<String, dynamic> map) {
    return Election(
        electionTitle: map['electionTitle'] ?? '',
        isOngoing: map['isOngoing'] ?? 0);
  }
}
