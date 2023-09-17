import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/storys.dart';
import 'package:instagram_clone/screens/add/add-post-next.dart';
import 'package:instagram_clone/screens/add/add-story.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../../function.dart';
import '../../models/post.dart';
import '../../providers/posts.dart';
import 'add-reels.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = '/gallery';

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  List<File> medias = [];
  bool isLoading = true;
  int currentIndex = 0;
  File? selectedPost;
  void onItemSelected(int index) {
    setState(() {
      currentIndex = index;
      selectedPost = medias[currentIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMediaFiles();
  }

  Future<void> fetchMediaFiles() async {
    Directory? appDir = await getExternalStorageDirectory();
    Directory galleryDir = Directory('/storage/emulated/0/DCIM/100PINT/Pins');
    print(appDir);

    if (await galleryDir.exists()) {
      List<FileSystemEntity> files = galleryDir.listSync();

      for (var file in files) {
        if (file is File) {
          if (file.path.endsWith('.jpg') || file.path.endsWith('.jpeg')) {
            medias.add(file);
          } else if (file.path.endsWith('.mp4')) {
            medias.add(file);
          }
        }
      }
      selectedPost = medias[0];

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'New Post',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
                final Uint8List? imageBytes =
                    await screenshotController.capture();
                selectedPost = await uint8ListToFile(
                    imageBytes!, DateTime.now().toIso8601String());

                Navigator.of(context)
                    .pushNamed(NextPost.routeName, arguments: selectedPost);

                /*  Provider.of<Posts>(context, listen: false).addNewPost(
                    [modifiedPost],
                    "sjp46uvdd8",
                    "text paragraph only for test");

                Navigator.of(context).pop();*/
              },
              child: Text(
                "Next",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    height: 300,
                    color: Colors.grey,
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                          width: 200,
                          color: Colors.grey,
                          child: medias[currentIndex].path.endsWith(".mp4")
                              ? VideoPlayerWidget(medias[currentIndex])
                              : PhotoView(
                                  imageProvider:
                                      FileImage(medias[currentIndex]))),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Recent(),
                          Spacer(),
                          SelectMultiple(),
                          SizedBox(
                            width: 10,
                          ),
                          CameraButton(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 290,
                    child: StorageElements(
                      onItemSelected: onItemSelected,
                      medias: medias,
                    ),
                  )
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

class StorageElements extends StatefulWidget {
  const StorageElements(
      {Key? key, required this.medias, required this.onItemSelected})
      : super(key: key);

  final List<File> medias;
  final void Function(int index) onItemSelected;

  @override
  State<StorageElements> createState() => _StorageElementsState();
}

class _StorageElementsState extends State<StorageElements> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemCount: widget.medias.length,
          itemBuilder: (context, index) {
            if (!widget.medias[index].path.endsWith(".mp4")) {
              File image = widget.medias[index];
              return GestureDetector(
                onTap: () {
                  widget.onItemSelected(
                      index); // Pass the selected index directly
                },
                child: Opacity(
                  opacity: widget.onItemSelected == index ? 0.5 : 1.0,
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              File video = widget.medias[index];
              return GestureDetector(
                onTap: () {
                  widget.onItemSelected(
                      index); // Pass the selected index directly
                },
                child: Opacity(
                  opacity: widget.onItemSelected == index ? 0.5 : 1.0,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.black,
                      child: VideoPlayerWidget(video),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
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
