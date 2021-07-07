import 'dart:convert';

class Post {
  String titleOfPost;

  Post({this.titleOfPost});

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      titleOfPost: map['titleOfPost'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titleOfPost': titleOfPost,
    };
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
