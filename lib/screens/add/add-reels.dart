import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add/add-Post.dart';
import 'package:path_provider/path_provider.dart';

import 'add-story.dart';

class AddReel extends StatefulWidget {
  static const routeName = "/reel";
  const AddReel({super.key});

  @override
  State<AddReel> createState() => _AddReelState();
}

class _AddReelState extends State<AddReel> {
  List<File> medias = [];
  bool isLoading = true;
  int currentIndex = 0;

  void onItemSelected(int index) {
    setState(() {
      currentIndex = index;
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'New Reel',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              CupertinoIcons.xmark,
              size: 24,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 24,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 90,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.camera,
                        size: 26,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.add_circled,
                        size: 26,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.square_stack_3d_up_fill,
                        size: 26,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Recent(),
                Spacer(),
                SelectMultiple(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 470,
              child: Stack(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 0.6),
                    itemCount: medias.length,
                    itemBuilder: (context, index) {
                      if (!medias[index].path.endsWith(".mp4")) {
                        File image = medias[index];
                        return GestureDetector(
                          onTap: () {
                            onItemSelected(
                                index); // Pass the selected index directly
                          },
                          child: Opacity(
                            opacity: onItemSelected == index ? 0.5 : 1.0,
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        File video = medias[index];
                        return GestureDetector(
                          onTap: () {
                            onItemSelected(
                                index); // Pass the selected index directly
                          },
                          child: Opacity(
                            opacity: onItemSelected == index ? 0.5 : 1.0,
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
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class AutoSelectStory extends StatelessWidget {
  const AutoSelectStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.yellow),
    );
  }
}

class OpenSettingButton extends StatelessWidget {
  const OpenSettingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Open Settings",
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 15),
    );
  }
}

class SceondText extends StatelessWidget {
  const SceondText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "This let you share your photos, record videos and preview effects. You can change this anytime in you device settings. ",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
    );
  }
}

class FirstText extends StatelessWidget {
  const FirstText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Allow Instagram to access your camera and microphone",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

class AddStoryIcon extends StatelessWidget {
  const AddStoryIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.camera_viewfinder,
          color: Colors.white,
          size: 60,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 3,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey),
        )
      ],
    );
  }
}
