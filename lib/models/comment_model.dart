import 'package:flutter/material.dart';

class Comment {
  final String username;
  final String comment;
  final int likes;
  final bool isLiked, isOwned;
  final Image image;

  Comment(
      {required this.username,
      required this.comment,
      required this.likes,
      this.isLiked = false,
      this.isOwned = false,
      required this.image});
}
