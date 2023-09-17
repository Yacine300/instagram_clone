import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/storys.dart';
import 'package:instagram_clone/screens/add/add-post-final.dart';
import 'package:instagram_clone/screens/add/add-story.dart';
import 'package:instagram_clone/screens/home-screen/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../../function.dart';
import '../../models/post.dart';
import '../../providers/posts.dart';
import 'add-reels.dart';

class NextPost extends StatefulWidget {
  static const routeName = '/postNext';

  @override
  _NextPostState createState() => _NextPostState();
}

class _NextPostState extends State<NextPost>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScreenshotController screenshotController = ScreenshotController();
  File? selectedPost;
  //late TabController _songTabController;
  bool filter = true;
  bool openEdit = false;
  bool selectedEdit = false;
  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;
  double _warmth = 0.0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Number of tabs
    //_songTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // _songTabController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> filters = [
    {
      'color': Colors.transparent,
      'blendMode': BlendMode.color,
      'filterName': 'Original',
    },
    {
      'color': Colors.red,
      'blendMode': BlendMode.color,
      'filterName': 'Red',
    },
    {
      'color': Colors.green,
      'blendMode': BlendMode.saturation,
      'filterName': 'Green',
    },
    {
      'color': Colors.blue,
      'blendMode': BlendMode.multiply,
      'filterName': 'Blue',
    },
    {
      'color': Colors.grey,
      'blendMode': BlendMode.hue,
      'filterName': 'Inkwell',
    },
    {
      'color': Colors.yellow,
      'blendMode': BlendMode.color,
      'filterName': 'Yellow',
    },
    {
      'color': Colors.purple,
      'blendMode': BlendMode.overlay,
      'filterName': 'Lo-fi',
    },
    {
      'color': Colors.orange,
      'blendMode': BlendMode.softLight,
      'filterName': 'Rich',
    },
    {
      'color': Colors.teal,
      'blendMode': BlendMode.lighten,
      'filterName': 'Teal Light',
    },
    {
      'color': Colors.indigo,
      'blendMode': BlendMode.darken,
      'filterName': 'Indigo Dark',
    },
    {
      'color': Colors.pink,
      'blendMode': BlendMode.screen,
      'filterName': 'Pink Screen',
    },
    {
      'color': Colors.cyan,
      'blendMode': BlendMode.exclusion,
      'filterName': 'Cyan Exclusion',
    },
    {
      'color': Colors.amber,
      'blendMode': BlendMode.hardLight,
      'filterName': 'Amber Hard Light',
    },
    {
      'color': Colors.deepPurple,
      'blendMode': BlendMode.difference,
      'filterName': 'Deep Purple Difference',
    },
    {
      'color': Colors.lime,
      'blendMode': BlendMode.lighten,
      'filterName': 'Lime Lighten',
    },
    {
      'color': Colors.brown,
      'blendMode': BlendMode.multiply,
      'filterName': 'Brown Multiply',
    },
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final File? post = ModalRoute.of(context)?.settings.arguments as File?;
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    filter = false;
                  });
                },
                child: Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor:
                              0.95, // Set heightFactor to 1.0 to take full screen height
                          child: Scaffold(
                            backgroundColor: Colors.black,
                            body: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  height: 3,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextField(
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.withOpacity(
                                            0.25), // Set the background color to grey

                                        hintText: 'Search...',
                                        // Set the hint text
                                        hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(
                                                0.5)), // Set the hint text color
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ), // Adjust the content padding
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                              10), // Set the border radius
                                        ),
                                        prefixIcon: Icon(
                                          CupertinoIcons.search,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TabBar(
                                  onTap: (index) {
                                    if (index == 0) {
                                      setState(() {
                                        filter = true;
                                      });
                                    } else {
                                      setState(() {
                                        filter = false;
                                      });
                                    }
                                  },
                                  splashBorderRadius: BorderRadius.circular(5),
                                  indicatorColor: Colors.white,
                                  controller: _tabController,
                                  labelColor: Colors.white,
                                  automaticIndicatorColorAdjustment: true,
                                  dividerColor: Colors.black,
                                  // Text color of selected tab
                                  //indicatorWeight: 0.0,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  unselectedLabelColor: Colors
                                      .white38, // Text color of unselected tab
                                  indicator: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Colors.white70, // Underline color
                                          width: 2.0,
                                          style: BorderStyle
                                              .solid // Underline thickness
                                          ),
                                    ),
                                  ),
                                  tabs: [
                                    Tab(
                                      text: 'For You',
                                    ),
                                    Tab(text: 'Browse'),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://i.pinimg.com/236x/13/14/30/131430ed522cfe8c592eb75b9ca14d60.jpg"))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dzanum",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Teya Dora",
                                            style: TextStyle(
                                                color: Colors.white38),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.play_circle_outline_rounded,
                                            size: 26,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      isScrollControlled: true); // this to take all the height
                },
                child: Icon(
                  Icons.music_note_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                CupertinoIcons.xmark,
                size: 32,
              )),
          actions: [
            GestureDetector(
              onTap: () async {
                /* final Uint8List? imageBytes =
                    await screenshotController.capture();
                var modifiedPost = await uint8ListToFile(imageBytes!, "File");
                Provider.of<Posts>(context, listen: false).addNewPost(
                    [modifiedPost],
                    "sjp46uvdd8",
                    "text paragraph only for test");

                Navigator.of(context).pop();*/
              },
              child: GestureDetector(
                onTap: () async {
                  final Uint8List? imageBytes =
                      await screenshotController.capture();
                  selectedPost = await uint8ListToFile(
                      imageBytes!, DateTime.now().toIso8601String());

                  Navigator.of(context).pushNamed(AddPostFinal.routeName,
                      arguments: selectedPost);
                },
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white24,
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: post!.path.endsWith(".mp4")
                      ? VideoPlayerWidget(post)
                      : Screenshot(
                          controller: screenshotController,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.matrix([
                              _contrast,
                              0,
                              0,
                              0,
                              0,
                              0,
                              _contrast,
                              0,
                              0,
                              0,
                              0,
                              0,
                              _contrast,
                              0,
                              0,
                              0,
                              0,
                              0,
                              1,
                              0,
                            ]),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                filters[currentIndex]['color'],
                                filters[currentIndex]['blendMode'],
                              ),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.matrix([
                                  1,
                                  0,
                                  0,
                                  0,
                                  _warmth,
                                  0,
                                  1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                  -_warmth,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                ]),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.matrix(
                                    [
                                      _saturation,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      _saturation,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      _saturation,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      1,
                                      0,
                                    ],
                                  ),
                                  child: /**/
                                      ColorFiltered(
                                    colorFilter: ColorFilter.matrix(
                                      [
                                        _contrast,
                                        0,
                                        0,
                                        0,
                                        _brightness,
                                        0,
                                        _contrast,
                                        0,
                                        0,
                                        _brightness,
                                        0,
                                        0,
                                        _contrast,
                                        0,
                                        _brightness,
                                        0,
                                        0,
                                        0,
                                        1,
                                        0,
                                      ],
                                    ),
                                    child: Image.file(
                                      post,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            filter
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white12),
                      child: ListView.builder(
                          itemCount: filters.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    filters[index]['filterName'],
                                    style: TextStyle(
                                        color: index == currentIndex
                                            ? Colors.white
                                            : Colors.white54,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      filters[index]['color'],
                                      filters[index]['blendMode'],
                                    ),
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                        child: Container(
                                            height: 100,
                                            width: 100,
                                            child: Image.file(
                                              post,
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                : !openEdit
                    ? Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white12,
                          ),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Shadow",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            openEdit = true;
                                          });
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.5)),
                                          child: Icon(
                                            Icons.light_mode_outlined,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    : SizedBox(),
            !filter && openEdit
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 103),
                    child: Column(
                      children: [
                        Slider(
                          value: _contrast,
                          onChanged: (value) {
                            setState(() {
                              _contrast = value;
                            });
                          },
                          min: 0.0,
                          max: 2.0,
                        ),
                        Slider(
                          value: _brightness,
                          onChanged: (value) {
                            setState(() {
                              _brightness = value;
                            });
                          },
                          min: -1.0,
                          max: 1.0,
                        ),
                        Slider(
                          value: _warmth,
                          onChanged: (value) {
                            setState(() {
                              _warmth = value;
                            });
                          },
                          min: -1.0,
                          max: 1.0,
                        ),
                        Slider(
                          value: _saturation,
                          onChanged: (value) {
                            setState(() {
                              _saturation = value;
                            });
                          },
                          min: 0.0,
                          max: 2.0,
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Container(
              color: Colors.white12,
              child: TabBar(
                onTap: (index) {
                  if (index == 0) {
                    setState(() {
                      filter = true;
                    });
                  } else {
                    setState(() {
                      filter = false;
                    });
                  }
                },
                splashBorderRadius: BorderRadius.circular(5),
                indicatorColor: Colors.white,
                controller: _tabController,
                labelColor: Colors.white,
                automaticIndicatorColorAdjustment: true,
                dividerColor: Colors.black,
                // Text color of selected tab
                //indicatorWeight: 0.0,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor:
                    Colors.white38, // Text color of unselected tab
                indicator: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.white70, // Underline color
                        width: 2.0,
                        style: BorderStyle.solid // Underline thickness
                        ),
                  ),
                ),
                tabs: [
                  Tab(
                    text: 'Filter',
                  ),
                  Tab(text: 'Edit'),
                ],
              ),
            ),
          ],
        ));
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.withOpacity(0.5),
      radius: 15,
      child: Icon(
        Icons.camera_alt_outlined,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}

class SelectMultiple extends StatelessWidget {
  const SelectMultiple({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.file_copy_outlined,
            size: 20,
          ),
          Text(
            "SELECT MULTIPLE ",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class Recent extends StatelessWidget {
  const Recent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Row(
        children: [
          Text(
            "Recents",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Spacer(),
          RotatedBox(
            quarterTurns: -1,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File video;

  VideoPlayerWidget(this.video);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.video);
    _initializeVideoPlayerFuture = _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.play();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VideoPlayer(_videoController);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
