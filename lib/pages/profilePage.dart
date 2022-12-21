import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_media_freelance/components/customChip.dart';
import 'package:social_media_freelance/components/stories.dart';
import 'package:social_media_freelance/components/tagbar.dart';
import 'package:social_media_freelance/constants/custom_icons.dart';
import 'package:social_media_freelance/constants/dummy_data.dart';
import 'package:social_media_freelance/models/profile_model.dart';
import 'package:social_media_freelance/models/story_model.dart';

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader(
      {Key? key,
      required this.profileImage,
      required this.name,
      required this.description,
      required this.location,
      required this.gender,
      required this.mode})
      : super(key: key);

  final Image profileImage;
  final String name, description, location;
  final Gender gender;
  final ProfilePageMode mode;

  Widget BlurredBackground() => ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.w),
          bottomRight: Radius.circular(35.w),
        ),
        child: Container(
          width: 1.sw,
          height: 240.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: profileImage.image,
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
      );

  Widget ActionBar(BuildContext context) => Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mode == ProfilePageMode.embedded
                ? SizedBox(
                    height: 25.sp,
                  )
                : InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: InkWell(
                onTap: () {
                  if (mode == ProfilePageMode.embedded) {
                    Navigator.of(context).pushNamed('/editProfile');
                  }
                  if (mode == ProfilePageMode.independent) {
                    ///Todo: Implement menu for independent mode of profile Page
                  }
                },
                child: Icon(
                  mode == ProfilePageMode.embedded
                      ? Icons.edit
                      : CustomIcons.dots,
                  color: Colors.white,
                  size: mode == ProfilePageMode.embedded ? 20.sp : 8.sp,
                ),
              ),
            )
          ],
        ),
      );

  Widget ProfilePicture() => Container(
        width: 110.w,
        height: 110.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: profileImage.image,
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(0.0, -2.0))
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurredBackground(),
        Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            ActionBar(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Row(
                children: [
                  ProfilePicture(),
                  SizedBox(width: 20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.urbanist(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            gender == Gender.famale
                                ? CustomIcons.female
                                : CustomIcons.male,
                            color: Colors.white,
                            size: 20.sp,
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        location,
                        style: GoogleFonts.urbanist(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        width: 200.w,
                        child: Text(
                          description,
                          style: GoogleFonts.urbanist(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _StatBar extends StatelessWidget {
  const _StatBar(
      {Key? key,
      required this.followerCount,
      required this.followingCount,
      required this.visitorCount})
      : super(key: key);

  final int followerCount, followingCount, visitorCount;
  String formatNumber(int number) => NumberFormat.compact().format(number);

  Widget VerticalDivider() => Container(
        width: 1.w,
        height: 55.h,
        color: Colors.grey,
      );

  Widget StatTile(int stat, String label) => Container(
        color: Colors.transparent,
        height: 60.h,
        width: 0.32.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formatNumber(stat),
              style: GoogleFonts.urbanist(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              style: GoogleFonts.urbanist(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatTile(followerCount, "Takip"),
        VerticalDivider(),
        StatTile(visitorCount, "Ziyaretçi"),
        VerticalDivider(),
        StatTile(followingCount, "Takip Edilen"),
      ],
    );
  }
}

class _ActionBanner extends StatelessWidget {
  const _ActionBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomChip(
                  icon: Icons.person,
                  text: "Arkadaş Ekle",
                  border: true,
                  onTap: () {},
                  width: 125.w,
                  height: 32.h,
                  color: Color(0xFFFF4D67),
                  textColor: Color(0xFFFF4D67)),
              CustomChip(
                  icon: Icons.message,
                  text: "Mesaj",
                  border: true,
                  onTap: () {},
                  width: 90.w,
                  height: 32.h,
                  color: Color(0xFFFF4D67),
                  textColor: Color(0xFFFF4D67)),
              CustomChip(
                  icon: Icons.group,
                  text: "Sosyal Medya",
                  border: true,
                  onTap: () {},
                  width: 125.w,
                  height: 32.h,
                  color: Color(0xFFFF4D67),
                  textColor: Color(0xFFFF4D67)),
            ],
          ),
          SizedBox(height: 9.h),
          CustomChip(
              icon: Icons.favorite,
              text: "Takip Et",
              border: false,
              onTap: () {},
              width: 355.w,
              height: 32.h,
              color: Color(0xFFFF4D67),
              textColor: Colors.white),
        ],
      ),
    );
  }
}

class _StoryBar extends StatelessWidget {
  const _StoryBar({Key? key, required this.stories}) : super(key: key);

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return StoryBar(

        ///Generate 10 story elements with dummy data
        storyElements: stories
            .map((story) => StoryElement(
                  size: 60.w,
                  isSeen: story.isSeen,
                  isOwned: story.isOwned,
                  image: story.image,
                  text: story.username,
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ))
            .toList());
  }
}

class _TagBar extends StatelessWidget {
  const _TagBar(
      {Key? key, required this.tags, required this.onClick, this.selected = 0})
      : super(key: key);

  final List<String> tags;
  final Function(int id) onClick;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 0.95.sw,
        height: 35.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.h),
          border:
              Border.all(width: 1.w, color: Color(0xFFDDDDDD).withOpacity(0.3)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  tags.length,
                  (int index) => TagElement(
                        id: index,
                        isSelected: selected == index,
                        highlightWidth: 70.w,
                        label: tags[index],
                        onClick: (id) {
                          onClick(id);
                        },
                      ))),
        ));
  }
}

class _PostContainer extends StatefulWidget {
  _PostContainer({Key? key, required this.images}) : super(key: key);

  final List<Image> images;

  @override
  State<_PostContainer> createState() => __PostContainerState();
}

class __PostContainerState extends State<_PostContainer> {
  //PageController
  final PageController _pageController = PageController(initialPage: 0);

  Widget ImageTile(Image image) => ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          width: (0.95.sw - 8.w) / 3,
          height: (0.95.sw - 8.w) / 3,
          child: Image(
            image: image.image,
            fit: BoxFit.cover,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return FutureBuilder(
                future: Future.value(true),
                builder: (BuildContext context, AsyncSnapshot<void> snap) {
                  return _TagBar(
                      selected:
                          snap.hasData ? _pageController.page!.round() : 0,
                      tags: const ["Gönderiler", "Shorts", "Hediyeler"],
                      onClick: (index) {
                        _pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      });
                },
              );
            }),
        SizedBox(
          height: 5.h,
        ),
        Expanded(
          child: PageView(controller: _pageController, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.95.sw,
                  height: 260.h,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 4.w,
                      runSpacing: 4.w,
                      children: widget.images.map((e) => ImageTile(e)).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(color: Colors.white)]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Container(color: Colors.white)]),
          ]),
        )
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  final IconData icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 0.95.sw,
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18.sp,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                title,
                style: GoogleFonts.urbanist(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              Expanded(child: Container()),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmbeddedProfilePage extends StatelessWidget {
  const _EmbeddedProfilePage({Key? key}) : super(key: key);

  Widget horizontalLine() => Container(
        width: 0.95.sw,
        height: 1.h,
        color: Colors.grey.withOpacity(0.3),
      );

  Widget Menu({
    required List<Widget> children,
  }) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: 21,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.w),
          child: Column(
            children: children,
          ),
        ),
      );

  Widget CenterTile({required Color color, required String title}) => Container(
      width: 172.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.urbanist(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ));

  Widget CenterBar() => Container(
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CenterTile(color: Color(0xFFFECf5D), title: "Ajans Merkezi"),
            CenterTile(color: Color(0xFF9F6CD9), title: "Yayıncı Merkezi"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileHeader(
          profileImage: ProfileDummyData.profileImage,
          name: ProfileDummyData.name,
          mode: ProfilePageMode.embedded,
          description: ProfileDummyData.description,
          location: ProfileDummyData.location,
          gender: ProfileDummyData.gender,
        ),
        SizedBox(height: 10.h),
        _StatBar(
          followerCount: ProfileDummyData.followerCount,
          followingCount: ProfileDummyData.followingCount,
          visitorCount: ProfileDummyData.visitorCount,
        ),
        SizedBox(height: 15.h),
        CenterBar(),
        SizedBox(height: 15.h),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Menu(children: [
                _MenuTile(
                  icon: Icons.person,
                  title: "Mağaza",
                  onTap: () {},
                ),
                horizontalLine(),
                _MenuTile(
                  icon: Icons.settings,
                  title: "Aristokrasi",
                  onTap: () {},
                ),
                horizontalLine(),
                _MenuTile(
                  icon: Icons.help,
                  title: "VIP / Premium",
                  onTap: () {},
                )
              ]),
              SizedBox(height: 15.h),
              Menu(children: [
                _MenuTile(
                  icon: Icons.person,
                  title: "Seviye",
                  onTap: () {},
                ),
                horizontalLine(),
                _MenuTile(
                  icon: Icons.settings,
                  title: "Madalya",
                  onTap: () {},
                ),
                horizontalLine(),
                _MenuTile(
                  icon: Icons.help,
                  title: "Çift",
                  onTap: () {},
                ),
                horizontalLine(),
                _MenuTile(
                  icon: Icons.help,
                  title: "Aile",
                  onTap: () {},
                ),
              ]),
              SizedBox(height: 15.h),
            ],
          ),
        ))
      ],
    );
  }
}

class _IndependentProfilePage extends StatelessWidget {
  const _IndependentProfilePage({Key? key}) : super(key: key);

  Widget horizontalDivider() => Container(
        width: 0.95.sw,
        height: 1.h,
        color: Color(0xFFDDDDDD).withOpacity(0.3),
      );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _ProfileHeader(
        mode: ProfilePageMode.independent,
        profileImage: ProfileDummyData.profileImage,
        name: ProfileDummyData.name,
        description: ProfileDummyData.description,
        location: ProfileDummyData.location,
        gender: ProfileDummyData.gender,
      ),
      SizedBox(height: 10.h),
      _StatBar(
        followerCount: ProfileDummyData.followerCount,
        followingCount: ProfileDummyData.followingCount,
        visitorCount: ProfileDummyData.visitorCount,
      ),
      SizedBox(height: 10.h),
      _ActionBanner(),
      SizedBox(height: 15.h),
      _StoryBar(
        stories: ProfileDummyData.stories,
      ),
      SizedBox(height: 12.h),
      horizontalDivider(),
      SizedBox(height: 8.h),
      Expanded(
        child: _PostContainer(
          images: ProfileDummyData.posts,
        ),
      )
    ]);
  }
}

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, required this.mode}) : super(key: key);

  final ProfilePageMode mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: mode == ProfilePageMode.embedded
          ? _EmbeddedProfilePage()
          : _IndependentProfilePage(),
    );
  }
}
