import 'package:flutter/widgets.dart';
import 'package:instagram_clone/screens/add/add-Post.dart';
import 'package:instagram_clone/screens/add/add-post-final.dart';
import 'package:instagram_clone/screens/add/add-post-next.dart';
import 'package:instagram_clone/screens/add/add-reels.dart';
import 'package:instagram_clone/screens/add/add-story-small.dart';
import 'package:instagram_clone/screens/add/add-story.dart';
import 'package:instagram_clone/screens/add/add-transition-story.dart';
import 'package:instagram_clone/screens/add/all-in-one.dart';
import 'package:instagram_clone/screens/conversation/conversation.dart';
import 'package:instagram_clone/screens/conversation/detail_conversation.dart';
import 'package:instagram_clone/screens/home-screen/home.dart';
import 'package:instagram_clone/screens/notifications/notification.dart';
import 'package:instagram_clone/screens/profile/profile.dart';
import 'package:instagram_clone/screens/reals/reals.dart';
import 'package:instagram_clone/screens/search/search.dart';

Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  RealsScreen.routeName: (context) => RealsScreen(),
  GalleryScreen.routeName: (context) => GalleryScreen(),
  NextPost.routeName: (context) => NextPost(),
  AddStory.routeName: (context) => AddStory(),
  AddReel.routeName: (context) => AddReel(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AllInOne.routeName: (context) => AllInOne(),
  Conversations.routeName: (context) => Conversations(),
  Notifications.routeName: (context) => Notifications(),
  AddStorySmall.routeName: (context) => AddStorySmall(),
  AddTransitionStory.routeName: (context) => AddTransitionStory(),
  AddPostFinal.routeName: (context) => AddPostFinal(),
  DetailConvarsation.routeName: (context) => DetailConvarsation(),
};
