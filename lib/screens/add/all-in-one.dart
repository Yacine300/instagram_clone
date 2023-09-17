import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add/add-reels.dart';
import 'package:instagram_clone/screens/add/add-story.dart';
import 'package:instagram_clone/screens/add/add-transition-story.dart';

import 'add-Post.dart';

class AllInOne extends StatefulWidget {
  static const routeName = "/all";
  AllInOne({super.key});

  @override
  State<AllInOne> createState() => _AllInOneState();
}

class _AllInOneState extends State<AllInOne> {
  String currentField = GalleryScreen.routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (currentField == GalleryScreen.routeName) GalleryScreen(),
          if (currentField == AddTransitionStory.routeName)
            AddTransitionStory(),
          if (currentField == AddReel.routeName) AddReel(),
          Positioned(
              bottom: 10,
              right: currentField == AddStory.routeName
                  ? 75
                  : currentField == AddReel.routeName
                      ? -10
                      : currentField == GalleryScreen.routeName
                          ? 150
                          : -200,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceIn,
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          currentField = GalleryScreen.routeName;
                        }),
                        child: Text(
                          "POST",
                          style: TextStyle(
                              color: currentField == GalleryScreen.routeName
                                  ? Colors.white
                                  : Colors.grey,
                              letterSpacing: 1,
                              fontWeight:
                                  currentField == GalleryScreen.routeName
                                      ? FontWeight.bold
                                      : FontWeight.w400),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          currentField = AddTransitionStory.routeName;
                        }),
                        child: Text(
                          "STORY",
                          style: TextStyle(
                              color:
                                  currentField == AddTransitionStory.routeName
                                      ? Colors.white
                                      : Colors.grey,
                              letterSpacing: 1,
                              fontWeight:
                                  currentField == AddTransitionStory.routeName
                                      ? FontWeight.bold
                                      : FontWeight.w400),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          currentField = AddReel.routeName;
                        }),
                        child: Text(
                          "REALS",
                          style: TextStyle(
                              color: currentField == AddReel.routeName
                                  ? Colors.white
                                  : Colors.grey,
                              letterSpacing: 1,
                              fontWeight: currentField == AddReel.routeName
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
