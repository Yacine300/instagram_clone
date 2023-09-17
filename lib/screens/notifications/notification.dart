import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  static const routeName = "/notifications";
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(size: 26),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FollowRequest(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Last 30 days",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Notification(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Suggested for you',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            SuugestSection(),
            SizedBox(
              height: 15,
            ),
            Text(
              "See all suggestion",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      )),
    );
  }
}

class SuugestSection extends StatelessWidget {
  const SuugestSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: OneSuggested(),
          );
        });
  }
}

class OneSuggested extends StatelessWidget {
  const OneSuggested({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/564x/01/55/ed/0155ed1e777497fee69c3414dcee0b24.jpg")),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alpha Simpson',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Suggested for you',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
            )
          ],
        ),
        Spacer(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.blue),
          child: Text(
            "Follow",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Icon(
          CupertinoIcons.xmark,
          color: Colors.white.withOpacity(0.4),
          size: 16,
        )
      ],
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.pink,
                      Colors.purple,
                      Colors.blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const Positioned(
                left: 2,
                top: 2,
                right: 2,
                bottom: 2,
                child: CircleAvatar(
                  radius: 35,
                  foregroundImage: NetworkImage(
                      "https://i.pinimg.com/564x/02/fd/24/02fd24158a6c6ffb8cc6168a2cde7dfa.jpg"),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        SizedBox(
          width: 250,
          child: Wrap(
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'cbum_',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "created a broadcast channel: Don't Freack Out",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400))
                ]),
              )
            ],
          ),
        )
      ],
    );
  }
}

class FollowRequest extends StatelessWidget {
  const FollowRequest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white, width: 1)),
          child: Icon(
            Icons.person_add_outlined,
            size: 24,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          children: [
            Text(
              'Follow request',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Follow request',
              style: TextStyle(color: Colors.white.withOpacity(0.3)),
            )
          ],
        )
      ],
    );
  }
}
