import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../components/navbar.dart';
import '../search/search.dart';

class RealsScreen extends StatefulWidget {
  const RealsScreen({super.key});
  static const routeName = "/reals";

  @override
  State<RealsScreen> createState() => _RealsScreenState();
}

class _RealsScreenState extends State<RealsScreen> {
  bool isPlaying = true;
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  String videoUrl =
      'https://v1.pinimg.com/videos/mc/720p/0b/ef/ba/0befba868411495e4648b0f8a744b54f.mp4';

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    initializeVideoPlayerFuture = videoController.initialize();
    videoController.setLooping(true);
    videoController.setVolume(1);
    videoController.play();
  }

  @override
  void dispose() {
    videoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black87,
        bottomNavigationBar: NavBar(),
        body: SafeArea(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      if (isPlaying) {
                        videoController.pause();
                      } else {
                        videoController.play();
                      }
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: VideoPlayerWidget(
                          initializeVideoPlayerFuture:
                              initializeVideoPlayerFuture,
                          videoController: videoController),
                    ),
                  ),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Header(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InfoReals(),
                              LikeShareComment(),
                            ],
                          )
                        ],
                      )),
                  /* Center(
                    child: Icon(
                      isPlaying
                          ? Icons.play_arrow_rounded
                          : Icons.pause_circle_outline_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  )*/
                ],
              );
            },
          ),
        ));
  }
}

class LikeShareComment extends StatelessWidget {
  const LikeShareComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Icon(Icons.favorite_outline_rounded, size: 32),
              Text(
                "999.1 k",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            children: [
              Icon(Icons.messenger_outline_rounded, size: 32),
              Text(
                "14.1 k",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Icon(
            CupertinoIcons.paperplane,
            size: 32,
          ),
          Icon(Icons.more_vert_rounded, size: 32),
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/3e/b8/f8/3eb8f88e16eec09637b8c2bc96839292.jpg"))),
          )
        ],
      ),
    );
  }
}

class InfoReals extends StatelessWidget {
  const InfoReals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/564x/3e/b8/f8/3eb8f88e16eec09637b8c2bc96839292.jpg"),
              ),
              Text(
                "the_bodybuilding_mode",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button tap
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set the desired radius here
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.white),
                  ),
                ),
                child: Text(
                  'Follow',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          Text(
            "ceci est un text blabla blablabla ceci est un text blabla blablabla ",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "ceci est un text blabla blablabla",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Reals",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Icon(
          Icons.camera_alt_outlined,
          size: 26,
        ),
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoAction(),
        SizedBox(
          height: 5,
        ),
        ContentPost(
            url:
                "https://i.pinimg.com/564x/ee/ce/e8/eecee8ce2a67702ecd7cd6bd32af8d5d.jpg"),
        SizedBox(
          height: 10,
        ),
        PostFooter(),
        SizedBox(
          height: 5,
        ),
        Text(
          "1.661 Likes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        CommentSection(),
        SizedBox(
          height: 5,
        ),
        Text(
          "View all 6 comments",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        AddComment(),
        SizedBox(
          height: 5,
        ),
        Text(
          "4 minutes ago",
          style: TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
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
    return Row(
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
              "ceci est un simple text pour dementrer comment le future commentaire doit apparaitrececi est un simple text pour dementrer comment le future commentaire doit apparaitre",
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
    return Row(
      children: [
        LikeCommentShare(),
        Spacer(),
        PostIndex(),
        Spacer(),
        SavePost()
      ],
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
      width: 80,
      child: Row(
        children: [
          Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.blue),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.grey),
          ),
        ],
      ),
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
            CupertinoIcons.location,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class ContentPost extends StatelessWidget {
  final String url;
  const ContentPost({
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(url), fit: BoxFit.contain)),
    );
  }
}

class InfoAction extends StatelessWidget {
  const InfoAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class Subsribtion extends StatelessWidget {
  const Subsribtion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 100,
              child: index != 0 ? const SubscribeList() : const MyAccount(),
            )),
      ),
    );
  }
}

class SubscribeList extends StatelessWidget {
  const SubscribeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
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
            const Positioned(
              left: 2,
              top: 2,
              right: 2,
              bottom: 2,
              child: CircleAvatar(
                radius: 35,
                foregroundImage: NetworkImage(
                    "https://i.pinimg.com/564x/02/fd/24/02fd24158a6c6ffb8cc6168a2cde7dfa.jpg"),
              ),
            )
          ],
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

class MyAccount extends StatelessWidget {
  const MyAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
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
