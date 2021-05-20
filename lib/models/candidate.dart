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
}
