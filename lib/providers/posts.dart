import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post.dart';

class Posts with ChangeNotifier {
  List<Post> _myPosts = [];
  bool _isSelectedPost = false;
  List<File>? _currentPost;

  List<Post> get posts {
    return [..._myPosts];
  }

  bool get isSelectedPost {
    return _isSelectedPost;
  }

  List<File> get currentChargedPost {
    return _currentPost!;
  }

  void setCurrentPost(List<File>? currentPost) {
    _currentPost = currentPost;
    notifyListeners();
  }

  Post findById(String produitID) {
    return _myPosts.firstWhere((element) => element.id == produitID);
  }

  void addNewPost(List<File> post, String uid, String postText) async {
    DateTime now = DateTime.now();
    String postId = now.toString().replaceAll(RegExp(r'[-:.]'), '');

    Post newPost = Post(
        id: postId,
        music: File.fromUri(Uri.file("path")),
        nombreLikes: 0,
        postList: post,
        postText: postText,
        createdAt: DateTime.now().toString());
    _myPosts.add(newPost);

    print("added with success");
    notifyListeners();
  }
}
