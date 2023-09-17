import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/function.dart';
import 'package:instagram_clone/models/story.dart';
import 'package:instagram_clone/screens/add/add-reels.dart';
import 'package:instagram_clone/screens/add/add-story.dart';
import 'package:instagram_clone/screens/add/when-story-selected.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/storys.dart';
import 'add-Post.dart';

class AddStorySmall extends StatefulWidget {
  static const routeName = "/small";
  AddStorySmall({super.key});

  @override
  State<AddStorySmall> createState() => _AddStorySmallState();
}

class _AddStorySmallState extends State<AddStorySmall> {
  List<File> medias = [];
  List<List<Color>> mediaColors = [];
  List<File> chargedStorys = [];
  //List<int> compteur = [];
  bool isSelectionMultiple = false;

  ScrollController _scrollController = ScrollController();

  void generateMediaColors() async {
    for (var media in medias) {
      List<Color> colors = await generateColors(media.path);
      mediaColors.add(colors);
    }

    // After generating all colors, set the state to rebuild the UI.
    setState(() {});
  }

  void scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // Reached the top of the grid
        print('Reached the top of the grid');
      } else {
        // Reached the bottom of the grid
        print('Reached the bottom of the grid');
      }
    }
  }

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
    _scrollController.addListener(scrollListener);
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
    Storys storys = Provider.of<Storys>(context);
    bool selectedAStory = storys.isSelectedStory;

    return selectedAStory
        ? WhenStroySelected(selectedStorys: storys.currentChargedStory)
        /* */
        : Stack(children: [
            Scaffold(
                backgroundColor: Colors.black87,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: Text(
                    'Add To Story',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        CupertinoIcons.xmark,
                        size: 28,
                      )),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        /* Provider.of<Storys>(context, listen: false)
                    .addNewStory([medias[currentIndex]], "007XCDF");
                Navigator.of(context).pop();*/
                      },
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 28,
                          )),
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
                          /* Container(
                    height: 300,
                    color: Colors.grey,
                    child: Container(
                width: 200,
                color: Colors.black,
                child: medias[currentIndex].path.endsWith(".mp4")
                    ? VideoPlayerWidget(medias[currentIndex])
                    : Image.file(
                        medias[currentIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),*/
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.black,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Recent(),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      isSelectionMultiple =
                                          !isSelectionMultiple;
                                      chargedStorys = [];
                                    }),
                                    child: SelectMultiple(
                                      text: isSelectionMultiple
                                          ? "cancel"
                                          : "select",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 580,
                            child: GridView.builder(
                              controller: _scrollController,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2, // Set the number of columns here
                                crossAxisSpacing: 0.5,
                                mainAxisSpacing: 0.5,
                              ),
                              itemCount: medias.length,
                              itemBuilder: (context, index) {
                                // List<Color> colors = snapshot.data!;
                                if (!medias[index].path.endsWith(".mp4")) {
                                  return GestureDetector(
                                    onTap: () {
                                      onItemSelected(index);
                                      setState(() {
                                        selectedAStory = true;
                                        storys.chargeStory([medias[index]]);
                                      });
                                    },
                                    onLongPress: () => setState(() {
                                      isSelectionMultiple =
                                          !isSelectionMultiple;
                                      chargedStorys.add(medias[index]);
                                    }),
                                    child: isSelectionMultiple
                                        ? GestureDetector(
                                            onTap: () => setState(() {
                                              if (!chargedStorys
                                                  .contains(medias[index])) {
                                                chargedStorys
                                                    .add(medias[index]);
                                              } else {
                                                chargedStorys
                                                    .remove(medias[index]);
                                              }
                                            }),
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          /*  gradient: LinearGradient(
                                          colors: colors,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),*/
                                                          ),
                                                      child: Image.file(
                                                        medias[index],
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: chargedStorys
                                                                .contains(
                                                                    medias[
                                                                        index])
                                                            ? Colors.blue
                                                            : Colors.white38),
                                                    child: Text(
                                                      (chargedStorys.indexWhere(
                                                                  (element) =>
                                                                      element ==
                                                                      medias[
                                                                          index]) +
                                                              1)
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: chargedStorys
                                                                .contains(
                                                                    medias[
                                                                        index])
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //chargedStorys.indexWhere((element) => element == medias(index))
                                              ],
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                /*  gradient: LinearGradient(
                                      colors: colors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),*/
                                                ),
                                            child: Image.file(
                                              medias[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  );
                                } else {
                                  File video = medias[index];
                                  return GestureDetector(
                                    onTap: () {
                                      onItemSelected(index);
                                      setState(() {
                                        selectedAStory = true;
                                        storys.chargeStory([medias[index]]);
                                      });
                                    },
                                    onLongPress: () => setState(() {
                                      isSelectionMultiple =
                                          !isSelectionMultiple;
                                      chargedStorys.add(medias[index]);
                                    }),
                                    child: isSelectionMultiple
                                        ? GestureDetector(
                                            onTap: () => setState(() {
                                              if (!chargedStorys
                                                  .contains(medias[index])) {
                                                chargedStorys
                                                    .add(medias[index]);
                                              } else {
                                                chargedStorys
                                                    .remove(medias[index]);
                                              }
                                            }),
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          /*  gradient: LinearGradient(
                                          colors: colors,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),*/
                                                          ),
                                                      child: VideoPlayerWidget(
                                                          video)),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  right: 10,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: chargedStorys
                                                                .contains(
                                                                    medias[
                                                                        index])
                                                            ? Colors.blue
                                                            : Colors.white38),
                                                    child: Text(
                                                      (chargedStorys.indexWhere(
                                                                  (element) =>
                                                                      element ==
                                                                      medias[
                                                                          index]) +
                                                              1)
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: chargedStorys
                                                                .contains(
                                                                    medias[
                                                                        index])
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //chargedStorys.indexWhere((element) => element == medias(index))
                                              ],
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                /*  gradient: LinearGradient(
                                      colors: colors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),*/
                                                ),
                                            child: VideoPlayerWidget(video)),
                                  );
                                }
                              },
                            ),
                          ),

                          /*GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 0.4),
                    itemCount: medias.length,
                    itemBuilder: (context, index) {
                      if (!medias[index].path.endsWith(".mp4")) {
                        generateColors(medias[index].path);
                        File image = medias[index];
                        return GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(gradient: ),
                          ),
                          onTap: () {
                            onItemSelected(index);
                            setState(() {
                              selectedAStory = true;
                            });
                          },
                        );
                      } else {
                        File video = medias[index];
                        return GestureDetector(
                          onTap: () {
                            onItemSelected(index);
                            setState(() {
                              selectedAStory = true;
                            });
                          },
                          child: Container(
                            color: Colors.black,
                            child: VideoPlayerWidget(video),
                          ),
                        );
                      }
                    },
                  ),*/
                        ],
                      )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: chargedStorys.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 100,
                      color: Colors.black54,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: chargedStorys.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 20),
                                    width: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: !chargedStorys[index]
                                              .path
                                              .endsWith(".mp4")
                                          ? Image.file(
                                              chargedStorys[index],
                                              fit: BoxFit.cover,
                                            )
                                          : VideoPlayerWidget(
                                              chargedStorys[index]),
                                    ),
                                  );
                                }),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                storys.chargeStory(chargedStorys);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 18,
                                    color: Colors.black,
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  : SizedBox(),
            )
          ]);
  }
}

class SelectMultiple extends StatelessWidget {
  final String text;
  const SelectMultiple({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      ),
    );
  }
}
