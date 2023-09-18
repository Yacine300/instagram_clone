import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/posts.dart';

class AddPostFinal extends StatefulWidget {
  static const routeName = "post-final";
  const AddPostFinal({super.key});

  @override
  State<AddPostFinal> createState() => _AddPostFinalState();
}

class _AddPostFinalState extends State<AddPostFinal> {
  final TextEditingController _textEditingController = TextEditingController();
  String _inputText = '';
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final File modifiedPost =
        ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New Post",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              CupertinoIcons.xmark,
              size: 32,
            )),
        actions: [
          GestureDetector(
            onTap: () async {
              Provider.of<Posts>(context, listen: false).addNewPost(
                  [modifiedPost], DateTime.now().toIso8601String(), _inputText);

              Navigator.of(context).pop();
            },
            child: const Text(
              "Share",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.file(
                        modifiedPost,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          setState(() {
                            _inputText = value;
                          });
                        },
                        style: const TextStyle(
                            color: Colors.white30, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'write a caption...',
                          // Set the hint text
                          hintStyle: TextStyle(
                              color: Colors.grey
                                  .withOpacity(0.5)), // Set the hint text color
                          // Adjust the content padding
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                                10), // Set the border radius
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white38,
                thickness: 0.3,
                height: 20,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Tag people",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              const Divider(
                color: Colors.white38,
                thickness: 0.3,
                height: 20,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Add Location",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 20,
                thickness: 0.3,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Add Music",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              const Divider(
                color: Colors.white38,
                height: 20,
                thickness: 0.3,
              ),
              Container(
                height: 35,
                width: 180,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white12),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.multitrack_audio_rounded,
                      size: 14,
                    ),
                    Text(
                      "Muslim",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "°",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Rmadi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white38,
                height: 20,
                thickness: 0.3,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Also post to",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 20,
                thickness: 0.3,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Share to facebook",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      Switch(
                        hoverColor: Colors.grey,
                        inactiveThumbColor: Colors.white,
                        value: false,
                        onChanged: (value) {},
                      )
                    ],
                  )),
              const Divider(
                color: Colors.transparent,
                height: 20,
                thickness: 0.3,
              ),
              const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Advanced settings",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      )
                    ],
                  )),
            ]),
      ),
    );
  }
}
