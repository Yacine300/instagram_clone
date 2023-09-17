import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailConvarsation extends StatefulWidget {
  static const routeName = "/detail-conversation";
  const DetailConvarsation({super.key});

  @override
  State<DetailConvarsation> createState() => _DetailConvarsationState();
}

class _DetailConvarsationState extends State<DetailConvarsation> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController _textFieldController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Scroll to the bottom when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          size: 26,
        ),
        actions: [
          Icon(
            CupertinoIcons.phone,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            CupertinoIcons.videocam,
            size: 35,
          ),
          SizedBox(
            width: 10,
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/236x/fb/d4/6c/fbd46ca5a4139d005a5cbc4377b1918b.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "Nour El Yacine Herrouel",
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "herrouelyacine66",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(50)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 40,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
              child: Icon(
                Icons.camera_alt_rounded,
                size: 24,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _textFieldController,
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  border: InputBorder
                      .none, // Remove the default border of the text field
                  hintText: 'Message...',
                  hintStyle: TextStyle(
                    color: Colors.white30,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mic_none_rounded,
                  size: 24,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.photo,
                  size: 24,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.smiley,
                  size: 24,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Info(),
            SizedBox(
              height: 20,
            ),
            LeftMessageBubble(
                text: "weee chagolti , ma3lich bolhof ? sha9itk urgent "),
            RightMessageBubble(text: "Oui vasy sahbi , ghi lkhir?"),
            LeftMessageBubble(
                text: "sha9it 1000 da droik , nrj3halk demain inchalh"),
            RightMessageBubble(text: "sayi machi probléme...."),
            RightMessageBubble(text: "aya rwah tal9ani fel dar "),
            LeftMessageBubble(text: "ok"),
            LeftMessageBubble(text: "rani jay"),
            LeftMessageBubble(text: "hfdk"),
            Text(
              "15 Oct, 14:40",
              style: TextStyle(
                  color: Colors.white24,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            RightMessageBubble(text: "aya hwd hwd"),
          ],
        ),
      ),
    );
  }
}

class RightMessageBubble extends StatelessWidget {
  final text;
  const RightMessageBubble({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          constraints:
              BoxConstraints(maxWidth: 190, minWidth: 10, minHeight: 40),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          //alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class LeftMessageBubble extends StatelessWidget {
  final text;
  const LeftMessageBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: 190, minWidth: 40, minHeight: 40),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.white24),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.pinimg.com/236x/0a/5e/21/0a5e2108a96fdcfdf8425fc5acb7448c.jpg"),
                        fit: BoxFit.cover)),
              )),
          Text(
            "Nour El Yacine Herrouel",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            "herrouelyacine33",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          Text(
            "8 followers",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.white38, fontWeight: FontWeight.w400),
          ),
          Text(
            "you d'ont follow each other in instagram",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.white38, fontWeight: FontWeight.w400),
          ),
          Container(
            width: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white30, borderRadius: BorderRadius.circular(5)),
            child: Text(
              "view profile",
              //textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
        ]),
      ),
    );
  }
}
