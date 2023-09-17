import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/navbar.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profil';
  ProfileScreen({super.key});
  bool viewGridChoice = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      bottomNavigationBar: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.add_circled,
                size: 26,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu_rounded,
                size: 26,
              ))
        ],
        title: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                color: Colors.white,
                size: 16,
              ),
              Text(
                "lil_end",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.expand_more_rounded,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileImage(),
                  ProfileInfo(),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ActionProfile(),
              SizedBox(
                height: 30,
              ),
              SeeAll(),
              SizedBox(
                height: 15,
              ),
              Suggestion(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.grid_on_rounded,
                              size: 24,
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 0.5,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_box_outlined,
                              size: 24,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.2),
                          thickness: 0.5,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Capture the moment with a friend",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
              Text(
                "Create your first post",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 35,
              ),
              CompleteData()
            ],
          ),
        ),
      ),
    );
  }
}

class CompleteData extends StatelessWidget {
  const CompleteData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Complete your profil",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Text("2 of 4",
                    style: TextStyle(color: Colors.green, letterSpacing: 0)),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Complete",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ]),
        ),
        Spacer(),
      ],
    );
  }
}

class Suggestion extends StatelessWidget {
  const Suggestion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SugestedAccount(),
            );
          }),
    );
  }
}

class SugestedAccount extends StatelessWidget {
  const SugestedAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 10,
          top: 10,
          child: Icon(
            CupertinoIcons.xmark,
            size: 20,
            color: Colors.grey.shade400,
          ),
        ),
        Container(
          height: 250,
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white, width: 0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/564x/d4/28/bb/d428bb4dff60cf6df9b282ce58efcade.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "daniel fox",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              Text(
                "Followed by lil_end",
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Container(
                width: 150,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), color: Colors.blue),
                child: Text(
                  'Follow',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SeeAll extends StatelessWidget {
  const SeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Discover people",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        Text(
          "See all",
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );
  }
}

class ActionProfile extends StatelessWidget {
  const ActionProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 140,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey.withOpacity(0.25)),
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          width: 140,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey.withOpacity(0.25)),
          child: Text(
            'Share Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          width: 35,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey.withOpacity(0.25)),
          child: Icon(
            CupertinoIcons.person_badge_plus_fill,
            size: 20,
          ),
        )
      ],
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        image: DecorationImage(
          image: NetworkImage(
              "https://i.pinimg.com/564x/2c/82/a3/2c82a347c1e2191bba2ab9669be44d7b.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Posts",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "12",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Followers",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "5",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Following",
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
