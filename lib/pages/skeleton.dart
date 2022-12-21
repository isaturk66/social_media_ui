import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_freelance/components/stories.dart';
import 'package:social_media_freelance/constants/dummy_data.dart';
import 'package:social_media_freelance/models/profile_model.dart';
import 'package:social_media_freelance/pages/feedPage.dart';
import 'package:social_media_freelance/pages/profilePage.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  //Page controller for the page view
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // Screen spacing at the top
        Expanded(
          child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FeedPage(),
                ProfilePage(
                  mode: ProfilePageMode.embedded,
                ),
              ]),
        ),
        SizedBox(
          width: 1.sw,
          height: 80.h,
          child: Placeholder(
            color: Colors.black,
            strokeWidth: 2.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Two buttons for the bottom navigation bar
                IconButton(
                    onPressed: () {
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    icon: const Icon(Icons.home)),

                IconButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      //pushnamed profile
                      Navigator.of(context).pushNamed('/profile');
                    },
                    icon: const Icon(Icons.sailing)),

                IconButton(
                    onPressed: () {
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    icon: const Icon(Icons.person)),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
