import 'dart:math';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../components/navbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = "/search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late VideoPlayerController videoController;
  late VideoPlayerController secondVideoController;
  late Future<void> initializeVideoPlayerFuture;
  late Future<void> secondInitializeVideoPlayerFuture;

  String videoUrl =
      'https://v1.pinimg.com/videos/mc/720p/0b/ef/ba/0befba868411495e4648b0f8a744b54f.mp4';
  String secondVideoUrl =
      "https://v1.pinimg.com/videos/mc/720p/f9/98/b8/f998b8666506d4606263451273cdf956.mp4";

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    initializeVideoPlayerFuture = videoController.initialize();
    videoController.setLooping(true);
    videoController.setVolume(0.0);
    videoController.play();

    secondVideoController =
        VideoPlayerController.networkUrl(Uri.parse(secondVideoUrl));
    secondInitializeVideoPlayerFuture = secondVideoController.initialize();
    secondVideoController.setLooping(true);
    secondVideoController.setVolume(0.0);
    secondVideoController.play();
  }

  @override
  void dispose() {
    videoController.dispose();
    secondVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black87,
      bottomNavigationBar: const NavBar(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.black87,
              actions: [
                CupertinoButton(
                  onPressed: () {
                    // Handle button tap
                  },
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
              title: TextField(
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey
                        .withOpacity(0.25), // Set the background color to grey

                    hintText: 'Search...',
                    // Set the hint text
                    hintStyle: TextStyle(
                        color: Colors.grey
                            .withOpacity(0.5)), // Set the hint text color
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ), // Adjust the content padding
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(10), // Set the border radius
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                    )),
              ),
              automaticallyImplyLeading: false,
              expandedHeight: 25,
              pinned: false,
              floating: true,
              snap: true,
            ),
          ];
        },
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: StaggeredGrid.count(
              axisDirection: AxisDirection.down,
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.pinimg.com/564x/d5/93/00/d5930003f7abe26b2a3d0aab66f063b0.jpg"),
                              fit: BoxFit.cover)),
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 3.5,
                    child: SizedBox(
                      child: VideoPlayerWidget(
                          initializeVideoPlayerFuture:
                              initializeVideoPlayerFuture,
                          videoController: videoController),
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 3.5,
                    child: SizedBox(
                      child: VideoPlayerWidget(
                          initializeVideoPlayerFuture:
                              secondInitializeVideoPlayerFuture,
                          videoController: secondVideoController),
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.pinimg.com/564x/13/bd/2c/13bd2c3a8a366c993311b40afc2ecdcc.jpg"),
                              fit: BoxFit.cover)),
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.pinimg.com/564x/a0/6f/67/a06f67d416b06f19a7421de9aab17018.jpg"),
                              fit: BoxFit.cover)),
                    )),
                StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://i.pinimg.com/564x/3d/4b/5f/3d4b5f666f631b01eb9f59e351536003.jpg"),
                              fit: BoxFit.cover)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final initializeVideoPlayerFuture;
  final videoController;

  VideoPlayerWidget(
      {required this.initializeVideoPlayerFuture,
      required this.videoController});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: widget.videoController.value.aspectRatio,
            child: VideoPlayer(widget.videoController!),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ));
        }
      },
    );
  }
}
