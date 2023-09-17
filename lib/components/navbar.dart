import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Spacer(),
            InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Icon(
                Icons.home_filled,
                color: Colors.white,
                size: 32,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, '/search'),
              child: const Icon(
                CupertinoIcons.search,
                color: Colors.white,
                size: 32,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/all'),
              child: const Icon(
                CupertinoIcons.plus_app,
                color: Colors.white,
                size: 32,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, '/reals'),
              child: const Icon(
                CupertinoIcons.play_circle,
                color: Colors.white,
                size: 32,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, '/profil'),
              child: const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/564x/53/b9/fb/53b9fb994aaf9fee850bbc6273d30b0c.jpg"),
              ),
            ),

            // Spacer()
          ],
        ),
      ),
    );
  }
}
