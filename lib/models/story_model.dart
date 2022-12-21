import 'package:flutter/cupertino.dart';

class Story {
  final String username;
  final Image image;
  final bool isSeen;
  final bool isOwned;

  Story(
      {required this.username,
      required this.image,
      this.isSeen = false,
      this.isOwned = false});
}