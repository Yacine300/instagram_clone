import 'dart:io';

class Story {
  String id;
  String createdAt;
  List<File> storyList = [];

  Story({required this.createdAt, required this.id, required this.storyList});
}
