class Post {
  String nameOfElection;
  String titleOfPost;

  Post({this.titleOfPost, this.nameOfElection});

  factory Post.fromFirebase(Map map) {
    return Post(
        titleOfPost: map['nameOfPost'], nameOfElection: map['nameOfElection']);
  }
}
