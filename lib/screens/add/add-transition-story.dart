import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add/add-story-small.dart';
import 'package:instagram_clone/screens/add/add-story.dart';

class AddTransitionStory extends StatelessWidget {
  static const routeName = '/all-story';

  const AddTransitionStory({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Now you can access the parameters using args

    final int? screenPosition = args?['position'];
    screenPosition ?? 0;
    return Scaffold(
      body: PageView.builder(
        // controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: 2, // Number of screens
        //  physics: CustomScrollPhysics(),
        itemBuilder: (context, index) {
          if (screenPosition == 1) {
            if (index == 0) {
              return AddStorySmall();
            } else if (index == 1) {
              return const AddStory();
            }
          } else {
            if (index == 0) {
              return const AddStory();
            } else if (index == 1) {
              return AddStorySmall();
            }
          }
          return const SizedBox
              .shrink(); // Return an empty widget for any other index
        },
      ),
    );
  }
}
