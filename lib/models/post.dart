import 'dart:io';

class Post {
  String id;
  String createdAt;
  List<File> postList = [];
  File music;
  int nombreLikes;
  String postText;

  Post(
      {required this.createdAt,
      required this.id,
      required this.music,
      required this.postList,
      required this.postText,
      required this.nombreLikes});
}
