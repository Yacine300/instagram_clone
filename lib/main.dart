import 'package:flutter/material.dart';
import 'package:instagram_clone/components/Route.dart';
import 'package:instagram_clone/providers/posts.dart';
import 'package:instagram_clone/providers/storys.dart';

import 'package:instagram_clone/screens/home-screen/home.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Storys()),
        ChangeNotifierProvider(create: (_) => Posts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram clone',
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white, size: 10),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              iconSize: MaterialStateProperty.all<double>(12),
            ),
          ),
          primaryColor: Colors.white,
          indicatorColor: Colors.white,
          useMaterial3: true,
        ),
        routes: routes,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
