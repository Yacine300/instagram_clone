import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/conversation/detail_conversation.dart';

class Conversations extends StatelessWidget {
  static const routeName = "/conversations";
  const Conversations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(size: 26),
        title: SizedBox(
          width: 100,
          child: Row(children: [
            Text(
              'end_lil',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
            ),
          ]),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_call_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit_note_rounded,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              SearchBar(),
              SizedBox(
                height: 30,
              ),
              FriendList(),
              SizedBox(
                height: 20,
              ),
              MessageRequest(),
              SizedBox(
                height: 15,
              ),
              MessagesSection()
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesSection extends StatelessWidget {
  const MessagesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(DetailConvarsation.routeName);
              },
              child: OneMessage());
        });
  }
}

class OneMessage extends StatelessWidget {
  const OneMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://i.pinimg.com/736x/fa/49/5f/fa495f157942da8a34c180dbea5a2c0c.jpg"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  right: 2,
                  bottom: 0,
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green,
                        border: Border.all(color: Colors.black, width: 2)),
                  ))
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Andrew_tate',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Actine now ',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.3), fontSize: 14),
              )
            ],
          ),
          Spacer(),
          Icon(
            CupertinoIcons.camera,
            color: Colors.white.withOpacity(0.4),
            size: 24,
          )
        ],
      ),
    );
  }
}

class MessageRequest extends StatelessWidget {
  const MessageRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Messages",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Requests (1)',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );
  }
}

class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 100,
              child: index != 0 ? YourOneFriend(index: index) : YourProfile(),
            )),
      ),
    );
  }
}

class YourProfile extends StatelessWidget {
  const YourProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/564x/53/b9/fb/53b9fb994aaf9fee850bbc6273d30b0c.jpg"),
        ),
        Spacer(),
        Text(
          'Your note',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class YourOneFriend extends StatelessWidget {
  final index;
  const YourOneFriend({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/564x/ea/4e/cd/ea4ecdabe0e3a176803b510ad212551e.jpg"),
                      fit: BoxFit.cover)),
            ),
            Positioned(
                right: 7,
                bottom: 0,
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green,
                      border: Border.all(color: Colors.black, width: 2)),
                ))
          ],
        ),
        Spacer(),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Solder_',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                )),
            TextSpan(
                text: '$index',
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))
          ]),
        )
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          filled: true,
          fillColor:
              Colors.grey.withOpacity(0.25), // Set the background color to grey

          hintText: 'Search...',
          // Set the hint text
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5)), // Set the hint text color
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ), // Adjust the content padding
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10), // Set the border radius
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Colors.white,
          )),
    );
  }
}
