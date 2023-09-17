import 'dart:io';
import 'package:flutter/material.dart';

import '../models/story.dart';

class Storys with ChangeNotifier {
  List<Story> _myStorys = [];
  bool _isSelectedStory = false;
  List<File>? _currentStory;

  List<Story> get myStorys {
    return [..._myStorys];
  }

  bool get isSelectedStory {
    return _isSelectedStory;
  }

  List<File> get currentChargedStory {
    return _currentStory!;
  }

  void noSelectedStory() {
    _isSelectedStory = false;
    notifyListeners();
  }

  void aSelectedStory() {
    _isSelectedStory = true;
    notifyListeners();
  }

  void chargeStory(List<File> currentStory) {
    _currentStory = currentStory;
    aSelectedStory();
    notifyListeners();
  }

  void dechargeStroy() {
    _currentStory = null;
    noSelectedStory();
    notifyListeners();
  }

  Story findById(String produitID) {
    return _myStorys.firstWhere((element) => element.id == produitID);
  }

  /*Future<String> uploadFile(File file, String filename) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child(filename);
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }*/

  void addNewStory(List<File> story, String uid) async {
    DateTime now = DateTime.now();
    String postId = now.toString().replaceAll(RegExp(r'[-:.]'), '');

    Story newPost = Story(
        id: postId, storyList: story, createdAt: DateTime.now().toString());
    _myStorys.add(newPost);
    noSelectedStory();

    print("added with success");
    notifyListeners();
  }
}
