import 'package:flutter/cupertino.dart';
import 'package:insta_clone/screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(
    child: Text("Home "),
  ),
  Center(
    child: Text("Search "),
  ),
  AddPostScreen(),
  Center(
    child: Text("favourite"),
  ),
  Center(
    child: Text("profile"),
  ),
];
