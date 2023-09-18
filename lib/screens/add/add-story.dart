import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add/add-Post.dart';
import 'package:instagram_clone/screens/add/add-reels.dart';
import 'package:instagram_clone/screens/add/when-story-selected.dart';
import 'package:provider/provider.dart';

import '../../function.dart';
import '../../providers/storys.dart';

bool resultPermission = false;
bool isFront = false;
bool isFlashOn = false;

late CameraController controller;

late List<CameraDescription> cameras;

class AddStory extends StatefulWidget {
  static const routeName = "/story";
  const AddStory({super.key});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  Future checkCameras() async {
    cameras = await availableCameras();
    controller = isFront
        ? CameraController(cameras[1], ResolutionPreset.high)
        : CameraController(cameras[0], ResolutionPreset.high);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCameras();
  }

  @override
  Widget build(BuildContext context) {
    Storys storys = Provider.of<Storys>(context);
    if (resultPermission == false) {
      return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar:
            storys.isSelectedStory ? const StoryNavBar() : const SizedBox(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                CupertinoIcons.xmark,
                size: 24,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  size: 24,
                )),
          ],
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  const AddStoryIcon(),
                  const SizedBox(
                    height: 20,
                  ),
                  const FirstText(),
                  const SizedBox(
                    height: 15,
                  ),
                  const SceondText(),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () => AppSettings.openAppSettings(),
                      child: const OpenSettingButton()),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool result =
                          await requestCameraAndMicrophonePermissions();
                      if (result)
                        await controller.initialize().then(
                              (value) => setState(
                                () {
                                  resultPermission = result;
                                },
                              ),
                            );
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(0.5)),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black, width: 2),
                            color: Colors.white.withOpacity(0.2)),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      );
    } else {
      return !storys.isSelectedStory
          ? const AccessCameraAllowed()
          : WhenStroySelected(selectedStorys: storys.currentChargedStory);
    }
  }
}

class AccessCameraAllowed extends StatefulWidget {
  const AccessCameraAllowed({
    super.key,
  });

  @override
  State<AccessCameraAllowed> createState() => _AccessCameraAllowedState();
}

class _AccessCameraAllowedState extends State<AccessCameraAllowed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          height: 60,
          width: double.infinity,
          color: Colors.black87,
          child: Stack(
            children: [
              if (resultPermission)
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFront = !isFront;
                          });
                        },
                        child: const Icon(
                          Icons.cameraswitch_outlined,
                          size: 28,
                        ),
                      ),
                    )),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 2)),
                  ))
            ],
          ),
        ),
        body: Stack(
          children: [
            const PreviewCamera(),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Actions(),
                      TakePictureButton(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class StoryNavBar extends StatefulWidget {
  const StoryNavBar({
    super.key,
  });

  @override
  State<StoryNavBar> createState() => _StoryNavBarState();
}

class _StoryNavBarState extends State<StoryNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      height: 60,
      width: double.infinity,
      color: Colors.black87,
      child: Stack(
        children: [
          if (resultPermission)
            Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      isFront = !isFront;
                      setState(
                        () {
                          isFront = !isFront;
                        },
                      );
                    },
                    child: const Icon(
                      Icons.cameraswitch_outlined,
                      size: 28,
                    ),
                  ),
                )),
          Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white, width: 2)),
              ))
        ],
      ),
    );
  }
}

class TakePictureButton extends StatefulWidget {
  const TakePictureButton({
    super.key,
  });

  @override
  State<TakePictureButton> createState() => _TakePictureButtonState();
}

class _TakePictureButtonState extends State<TakePictureButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) async {
        await startRecording(controller);
        print("start");
      },
      onLongPressEnd: (details) async {
        XFile? video = await stopRecording(controller);

        Provider.of<Storys>(context, listen: false)
            .chargeStory([File(video!.path)]);
      },
      onTap: () async {
        XFile? picture = await takePicture(controller);
        Provider.of<Storys>(context, listen: false)
            .chargeStory([File(picture!.path)]);
      },
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white.withOpacity(0.8)),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black87, width: 2),
              color: Colors.white.withOpacity(0.8)),
        ),
      ),
    );
  }
}

class Actions extends StatefulWidget {
  const Actions({
    super.key,
  });

  @override
  State<Actions> createState() => _ActionsState();
}

class _ActionsState extends State<Actions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          CupertinoIcons.xmark,
          size: 28,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isFlashOn = !isFlashOn;
            });
            isFlashOn
                ? controller.setFlashMode(FlashMode.torch)
                : controller.setFlashMode(FlashMode.off);
          },
          child: Icon(
              !isFlashOn ? Icons.flash_off_rounded : Icons.flash_on_rounded,
              size: 28),
        ),
        const Icon(CupertinoIcons.settings, size: 28)
      ],
    );
  }
}

class PreviewCamera extends StatelessWidget {
  const PreviewCamera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.88,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FutureBuilder<CameraController?>(
          future: openCamera(isFront, controller, cameras),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return CameraPreview(snapshot
                  .data!); // Access the CameraController using snapshot.data
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(color: Colors.transparent),
              );
            }
          },
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

class NavBarAction extends StatelessWidget {
  const NavBarAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(GalleryScreen.routeName),
                  child: Text(
                    "POST",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  "STORY",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(AddReel.routeName),
                  child: Text(
                    "REALS",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "LIVE",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ],
    );
  }
}

class OpenSettingButton extends StatelessWidget {
  const OpenSettingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
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
    return const Text(
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
    return const Text(
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
        const Icon(
          CupertinoIcons.camera_viewfinder,
          color: Colors.white,
          size: 60,
        ),
        const SizedBox(
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
