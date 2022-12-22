import 'package:flutter/material.dart';
import 'package:social_media_freelance/constants/dummy_data.dart';
import 'package:social_media_freelance/models/profile_model.dart';
import 'package:social_media_freelance/pages/commentsPage.dart';
import 'package:social_media_freelance/pages/editPage.dart';
import 'package:social_media_freelance/pages/feedPage.dart';
import 'package:social_media_freelance/pages/profilePage.dart';
import 'package:social_media_freelance/pages/skeleton.dart';
import 'package:social_media_freelance/pages/splash.dart';

var onGenerateRoute = (settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const Splash());
    case '/skeleton':
      return MaterialPageRoute(builder: (context) => Skeleton());
    case '/comments':
      return MaterialPageRoute(builder: (context) => CommentsPage());
    case '/profile':
      return MaterialPageRoute(
          builder: (context) => Scaffold(
                  body: ProfilePage(
                mode: ProfilePageMode.independent,
              )));
    case '/editProfile':
      return MaterialPageRoute(builder: (context) => EditPage());
    default:
  }
};
