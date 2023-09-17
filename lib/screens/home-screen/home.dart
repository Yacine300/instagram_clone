import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/story.dart';
import 'package:instagram_clone/providers/storys.dart';
import 'package:instagram_clone/screens/add/add-transition-story.dart';
import 'package:provider/provider.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';

import '../../components/navbar.dart';
import '../../function.dart';
import '../../models/post.dart';
import '../../providers/posts.dart';
import '../add/add-Post.dart';

int currentIndex = 0;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMoreVisible = false;

  void _showNotificationOverlay(context) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 100,
          left: 50,
          width: 200,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Clicked',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    // Remove the overlay after a short delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    var _myPosts = Provider.of<Posts>(context, listen: true).posts;
    return GestureDetector(
      onTap: () {
        setState(() {
          isMoreVisible = !isMoreVisible;
        });
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.black87,
          bottomNavigationBar: NavBar(),

          /* navigationBar: CupertinoNavigationBar(
            leading: InstagramText(),
            middle: Row(
              children: [Spacer(), AppbarAction()],
            )),*/
          body: /*SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Subsribtion()
              ],
            ),
          ),
        ),*/
              NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  toolbarHeight: 70,
                  backgroundColor: Colors.black87,
                  actions: [
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/notifications"),
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                      ),
                      iconSize: 26,
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/conversations"),
                      icon: const Icon(
                        Icons.chat_bubble_outline_rounded,
                      ),
                      iconSize: 26,
                    ),
                  ],
                  title: Row(
                    children: [
                      const Text(
                        "Instagram",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'Instagram',
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: -1,
                        child: IconButton(
                          onPressed: () {
                            _showNotificationOverlay(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                  expandedHeight: 25,
                  pinned: false,
                  floating: true,
                  snap: true,
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Subsribtion(),
                      isMoreVisible
                          ? Positioned(
                              top: 0,
                              left: 15,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 100,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.grey.shade900),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Icon(
                                          Icons.people_outline,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Favourites",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Icon(
                                          Icons.star_border_rounded,
                                          size: 28,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                          : SizedBox(),
                    ],
                  ),
                  Divider(
                    thickness: 0.2,
                    color: Colors.grey[500],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _myPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: HomePost(currentPost: _myPosts[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class HomePost extends StatelessWidget {
  final Post currentPost;
  const HomePost({super.key, required this.currentPost});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoAction(),
        ContentPost(urls: currentPost.postList),
        PostFooter(),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            currentPost.nombreLikes.toString() + " Likes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        CommentSection(),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "View all 6 comments",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
        AddComment(),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "4 minutes ago",
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}

class AddComment extends StatelessWidget {
  const AddComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                "https://i.pinimg.com/564x/53/b9/fb/53b9fb994aaf9fee850bbc6273d30b0c.jpg"),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Add comment...",
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/icons/others/favourite.png"))),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/others/hands.png"),
                          fit: BoxFit.contain)),
                ),
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CommentSection extends StatelessWidget {
  const CommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        width: double.infinity,
        child: Wrap(
          children: [
            Text(
              "cbum",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              "ceci est un simpletext pour dementrer comment le future commentaire doit apparaitre",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ],
        ));
  }
}

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeCommentShare(),
          Spacer(),
          PostIndex(),
          Spacer(),
          SavePost()
        ],
      ),
    );
  }
}

class SavePost extends StatelessWidget {
  const SavePost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.bookmark,
      size: 26,
    );
  }
}

class PostIndex extends StatelessWidget {
  const PostIndex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 5,
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class LikeCommentShare extends StatelessWidget {
  const LikeCommentShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            CupertinoIcons.heart,
            size: 26,
          ),
          const Icon(
            CupertinoIcons.bubble_left,
            size: 26,
          ),
          const Icon(
            CupertinoIcons.paperplane,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class ContentPost extends StatelessWidget {
  final List<File> urls;
  const ContentPost({
    required this.urls,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: PageView.builder(
                pageSnapping: false,
                scrollDirection: Axis.horizontal,
                itemCount: urls.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    urls[index],
                    fit: BoxFit.cover,
                  );
                })),
      ),
    );
  }
}

class InfoAction extends StatelessWidget {
  const InfoAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.pink,
                      Colors.purple,
                      Colors.blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const Positioned(
                left: 2,
                top: 2,
                right: 2,
                bottom: 2,
                child: CircleAvatar(
                  radius: 15,
                  foregroundImage: NetworkImage(
                      "https://i.pinimg.com/564x/02/fd/24/02fd24158a6c6ffb8cc6168a2cde7dfa.jpg"),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "bjarson_fitness",
            style: TextStyle(color: Colors.white),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage("assets/icons/others/blue-valid.png"),
                )),
          ),
          Spacer(),
          const Icon(
            CupertinoIcons.ellipsis_vertical,
            size: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class Subsribtion extends StatefulWidget {
  const Subsribtion({
    super.key,
  });

  @override
  State<Subsribtion> createState() => _SubsribtionState();
}

class _SubsribtionState extends State<Subsribtion> {
  @override
  Widget build(BuildContext context) {
    List<Story> myStorys = Provider.of<Storys>(context, listen: true).myStorys;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyAccount(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: myStorys.length,
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                      height: 100,
                      child: SubscribeList(
                        currentStory: myStorys[index],
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscribeList extends StatefulWidget {
  final Story currentStory;
  const SubscribeList({
    required this.currentStory,
    super.key,
  });

  @override
  State<SubscribeList> createState() => _SubscribeListState();
}

class _SubscribeListState extends State<SubscribeList> {
  VideoPlayerController? storyController;

  @override
  void dispose() {
    if (storyController != null) {
      storyController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Story> myStorys = Provider.of<Storys>(context, listen: true).myStorys;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            var _timer;
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Scaffold(
                      body: StoryPageView(
                        itemBuilder: (context, pageIndex, storyIndex) {
                          final story = myStorys[pageIndex].storyList;
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: Container(color: Colors.black),
                              ),
                              Positioned(
                                  top: 10,
                                  bottom: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: AspectRatio(
                                      aspectRatio: 1.75 / 2.9,
                                      child: !story[storyIndex]
                                              .path
                                              .endsWith(".mp4")
                                          ? Image.file(
                                              story[storyIndex],
                                              fit: BoxFit.cover,
                                            )
                                          : VideoPlayerWidget(
                                              story[storyIndex]),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 25),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StoryHeader(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SendMessageField(),
                                        Icon(
                                          CupertinoIcons.paperplane,
                                          size: 28,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        /* gestureItemBuilder:
                                (context, pageIndex, storyIndex) {
                              return Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    color: Colors.white,
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },*/
                        pageLength: myStorys.length,
                        storyLength: (int pageIndex) {
                          return myStorys[pageIndex].storyList.length;
                        },
                        onPageLimitReached: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  });
                },
                barrierColor: Colors.transparent);
          },
          child: Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.pink,
                      Colors.purple,
                      Colors.blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Positioned(
                left: 2,
                top: 2,
                right: 2,
                bottom: 2,
                child: CircleAvatar(
                    radius: 35,
                    foregroundImage: NetworkImage(
                        "https://i.pinimg.com/236x/e1/6e/5e/e16e5e187e6e554759f62923d5e5f321.jpg")),
              )
            ],
          ),
        ),
        Spacer(),
        Text(
          'cbum',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class SendMessageField extends StatelessWidget {
  const SendMessageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background
        border: Border.all(color: Colors.white), // White border
        borderRadius: BorderRadius.circular(50), // Rounded corners
      ),
      child: TextField(
        style: TextStyle(color: Colors.white), // Text color
        decoration: InputDecoration(
          border:
              InputBorder.none, // Remove the default border of the text field
          hintText: 'Send Message',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class StoryHeader extends StatelessWidget {
  const StoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/564x/01/cc/67/01cc678626fdca6ff8534a04a6b44691.jpg"),
                  fit: BoxFit.cover)),
        ),
        Text(
          "Akh-Spider",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "1h",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_rounded,
              size: 26,
            ))
      ],
    );
  }
}

class MyAccount extends StatelessWidget {
  const MyAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AddTransitionStory.routeName,
        arguments: {
          'position': 1,
        },
      ), ///////////////////////
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                "https://i.pinimg.com/564x/53/b9/fb/53b9fb994aaf9fee850bbc6273d30b0c.jpg"),
          ),
          Spacer(),
          Text(
            'Your Story',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class AppbarAction extends StatelessWidget {
  const AppbarAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        children: [
          CupertinoButton(
            onPressed: () {
              // Handle button tap
            },
            child: const Icon(
              CupertinoIcons.heart,
              size: 26,
            ),
          ),
          CupertinoButton(
            onPressed: () {
              // Handle button tap
            },
            child: const Icon(
              CupertinoIcons.bubble_left_bubble_right,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class InstagramText extends StatelessWidget {
  const InstagramText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: CupertinoTheme.of(context).textTheme.textStyle,
            child: const Text(
              'Instagram',
              // style: TextStyle(fontSize: 24), explecitly method
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}
