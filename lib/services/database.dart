import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote_app/models/candidate.dart';
import 'package:vote_app/models/election_status.dart';
import 'package:vote_app/models/post.dart';

class Database {
  CollectionReference candidatesCollection =
      FirebaseFirestore.instance.collection('candidates');
  CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference statusCollection =
      FirebaseFirestore.instance.collection('status');

  //add candidate
  Future addCandidate(Candidate candidate) {
    return candidatesCollection.doc(candidate.matricNo).set(candidate.toMap());
  }

  //delete candidate
  void deleteCandidate(Candidate candidate) {
    final doc = candidatesCollection.doc(candidate.matricNo);
    doc.get().then((docSnap) =>
        docSnap.exists ? doc.delete() : print('candidate doesnt exist'));
  }

  // get candidates
  Stream<List<Candidate>> getCandidates(Post post) {
    return candidatesCollection
        .where('post', isEqualTo: post.titleOfPost)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((candidate) => Candidate.fromMap(candidate.data()))
            .toList());
  }

  //get posts
  Stream<List<Post>> getPosts() {
    return postsCollection.snapshots().map((snapshots) =>
        snapshots.docs.map((post) => Post.fromMap(post.data())).toList());
  }

  // Future createPost
  void createPost(Post post) {
    postsCollection.doc(post.titleOfPost).set(post.toMap());
  }

  // cast vote
  void castVote(Candidate candidate, String voterId) {
    postsCollection
        .doc(candidate.post)
        .collection('votes')
        .doc(candidate.candidateName + voterId)
        .set({'candidateName': candidate.candidateName});
  }

  //get votes
  Future<int> getVotesNo(Candidate candidate) {
    return postsCollection
        .doc(candidate.post)
        .collection('votes')
        .where('candidateName', isEqualTo: candidate.candidateName)
        .snapshots()
        .length;
  }

  //set election status
  Future setElectionStatus(ElectionStatus status) {
    return statusCollection.doc('status').set({'status': status});
  }

  //get election status
  Future<Map> getElectionStatus() {
    return statusCollection.doc('status').get().then((value) => value.data());
  }
}
