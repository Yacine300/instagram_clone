import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:palette_generator/palette_generator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

Future<File> uint8ListToFile(Uint8List uint8list, String fileName) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$fileName');
  await file.writeAsBytes(uint8list);
  return file;
}

Future<CroppedFile?> cropImage() async {
  CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath:
          "https://i.pinimg.com/236x/67/b7/50/67b750e2a1e0b8531c99f43bc7ab3f91.jpg",
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ]);
  return cropped;

  // Use the cropped image as needed
}

Future<bool> requestCameraAndMicrophonePermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
  ].request();

  // Check if both permissions are granted
  if (statuses[Permission.camera]!.isGranted &&
      statuses[Permission.microphone]!.isGranted) {
    // Permissions granted, continue with your logic
    print('Camera and microphone permissions granted.');
    return true;
  } else {
    // Permissions not granted, handle it accordingly (e.g., show an error message)
    print('Camera and microphone permissions not granted.');
    return false;
  }
}

Future<CameraController> startRecording(CameraController controller) async {
  try {
    await controller.startVideoRecording();
    return controller;
  } catch (e) {
    print("Error starting video recording: $e");
  }
  return controller;
}

Future<XFile?> stopRecording(CameraController controller) async {
  try {
    if (controller.value.isRecordingVideo) {
      // Stop recording only if it's currently recording
      XFile savedVideo = await controller.stopVideoRecording();
      return savedVideo;
    }
  } catch (e) {
    print("Error stopping video recording: $e");
  }
  return null;
}

Future<XFile?> takePicture(CameraController controller) async {
  try {
    // Take the picture

    final XFile picture = await controller.takePicture();

    // Dispose the camera controller after taking the picture
    controller.dispose();

    // Return the captured image as an XFile
    return picture;
  } catch (e) {
    print("Error taking picture: $e");
    return null; // Return null if there's an error
  }
}

Future<CameraController?> openCamera(
    bool isFront, CameraController controller, cameras) async {
  // Ensure that you have the necessary permissions before opening the camera
  // ...

  // Get the list of available cameras

  /*if (cameras.isEmpty) {
    // No available cameras
    return null;
  }*/

  // Use the first camera available (you can choose a specific camera based on your requirements)
  controller = isFront
      ? CameraController(cameras[1], ResolutionPreset.max)
      : CameraController(cameras[0], ResolutionPreset.max);

  try {
    // Initialize the camera controller
    await controller.initialize();

    // Open the camera
    await controller.lockCaptureOrientation();
    await controller.setFocusMode(FocusMode.auto);

    return controller; // Return the initialized camera controller
  } catch (e) {
    // Handle any exceptions that occur during camera initialization
    print("Error: $e");
    return null; // Return null if there's an error
  }
}

Future<ui.Image> getImageFromUrl(String url) async {
  final response = await http.get(Uri.parse(url));
  final Uint8List bytes = response.bodyBytes;

  return await decodeImageFromList(bytes);
}

Future<List<Color>> generateColors(String imagePath) async {
  final File imageFile = File(imagePath);

  // Check if the file is a video (assuming video files end with ".mp4")
  bool isVideo = imagePath.toLowerCase().endsWith('.mp4');

  // If it's a video, return a list containing a transparent color
  if (isVideo) {
    return [Colors.transparent, Colors.transparent];
  }

  final PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(
    FileImage(imageFile),
    maximumColorCount: 3,
  );

  List<Color> finalList;

  try {
    if (paletteGenerator.colors.length < 3) {
      finalList = [
        paletteGenerator.colors.first,
        paletteGenerator.colors.first,
      ];
    } else {
      finalList = [paletteGenerator.colors.first, paletteGenerator.colors.last];
    }
    return finalList;
  } catch (e) {
    // If palette generation fails, return a default gradient
    return [Colors.transparent, Colors.transparent];
  }
}

Future<Uri> getImageFileFromAssets(String asset) async {
  final byteData = await rootBundle.load(asset);
  final buffer = byteData.buffer;
  Directory tempDir = await getApplicationDocumentsDirectory();
  String tempPath = tempDir.path;
  var filePath =
      tempPath + '/file_01.png'; // file_01.tmp is dump file, can be anything
  return (await File(filePath).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)))
      .uri;
}

Future<ui.Image> loadImageFromAsset(String assetName) async {
  final data = await rootBundle.load(assetName);
  final bytes = data.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}

Future<Color> allColorProcess(String image) async {
  return getAverageColor(await getImageFromUrl(image));
}

Future<Color> getAverageColor(ui.Image image) async {
  ByteData? byteData = await image.toByteData();
  Uint8List pixels = byteData!.buffer.asUint8List();

  int red = 0;
  int green = 0;
  int blue = 0;
  int pixelCount = 0;

  for (int i = 0; i < pixels.length; i += 4) {
    int alpha = pixels[i + 3];
    int pixelRed = pixels[i + 2];
    int pixelGreen = pixels[i + 1];
    int pixelBlue = pixels[i];

    // Only consider pixels that are not transparent // opacity - min 0 max 255
    if (alpha > 0 && alpha <= 255) {
      red += pixelRed;
      green += pixelGreen;
      blue += pixelBlue;
      pixelCount++;
    }
  }

  // Calculate the average color
  if (pixelCount > 0) {
    red = red ~/
        pixelCount; // ~/ return the integer value after deviding exemple : 10/3 = 3.33 => 3 is the final result
    green = green ~/ pixelCount;
    blue = blue ~/ pixelCount;
  }

  return Color.fromRGBO(red, green, blue, 1).withOpacity(0.2);
}
