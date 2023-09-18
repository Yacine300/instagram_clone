import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/function.dart';
import 'package:instagram_clone/screens/add/add-Post.dart';
import 'package:provider/provider.dart';

import '../../providers/storys.dart';

int currentSelected = 0;

class WhenStroySelected extends StatefulWidget {
  final List<File> selectedStorys;

  const WhenStroySelected({super.key, required this.selectedStorys});

  @override
  State<WhenStroySelected> createState() => _WhenStroySelectedState();
}

class _WhenStroySelectedState extends State<WhenStroySelected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              FutureBuilder<List<Color>>(
                future:
                    generateColors(widget.selectedStorys[currentSelected].path),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    List<Color> colors = snapshot.data!;
                    return Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          !widget.selectedStorys[currentSelected].path
                                  .endsWith('.mp4')
                              ? Image.file(
                                  widget.selectedStorys[currentSelected],
                                  fit: BoxFit.cover,
                                )
                              : VideoPlayerWidget(
                                  widget.selectedStorys[currentSelected]),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Error loading image'),
                    );
                  }
                },
              ),
              const IconsSection(),
            ],
          ),
          if (widget.selectedStorys.length > 1)
            widget.selectedStorys.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                              itemCount: widget.selectedStorys.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    currentSelected = index;
                                  }),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 20),
                                    width: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: !widget.selectedStorys[index].path
                                              .endsWith(".mp4")
                                          ? Image.file(
                                              widget.selectedStorys[index],
                                              fit: BoxFit.cover,
                                            )
                                          : VideoPlayerWidget(
                                              widget.selectedStorys[index]),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<Storys>(context, listen: false)
                                .addNewStory(widget.selectedStorys,
                                    DateTime.now().toIso8601String());
                            Navigator.of(context).pop();
                          },
                          child: const Row(
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
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          if (widget.selectedStorys.length == 1) ...[
            const Spacer(), // Add Spacer before Actions
            Actions(selectedStory: widget.selectedStorys),
          ],
        ],
      ),
    );
  }
}

class Actions extends StatelessWidget {
  final selectedStory;
  const Actions({
    super.key,
    required this.selectedStory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 270,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white.withOpacity(0.1)),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<Storys>(context, listen: false).addNewStory(
                            selectedStory, DateTime.now().toIso8601String());
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.person,
                              size: 18,
                            ),
                            Text(
                              "Your story",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 40,
                      width: 140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(0.1)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green),
                              child: const Icon(
                                Icons.star_rate_rounded,
                                size: 11,
                              ),
                            ),
                            const Text(
                              "Close Friends",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      )),
                ]),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(0.9)),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class IconsSection extends StatelessWidget {
  const IconsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black.withOpacity(0.4)),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black.withOpacity(0.4)),
          child: const Icon(
            Icons.animation_outlined,
            size: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black.withOpacity(0.4)),
          child: const Icon(
            Icons.workspaces_filled,
            size: 20,
          ),
        ),
      ],
    );
  }
}
