import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_freelance/components/postcard.dart';
import 'package:social_media_freelance/components/stories.dart';
import 'package:social_media_freelance/components/tagbar.dart';
import 'package:social_media_freelance/constants/dummy_data.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);
  Widget _header() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(14.w),
            child:
                Text("Hikayeler", style: GoogleFonts.urbanist(fontSize: 20.sp)),
          ),
          StoryBar(

              ///Generate 10 story elements with dummy data
              storyElements: StoryDummyData.stories
                  .map((story) => StoryElement(
                      size: 60.w,
                      isSeen: story.isSeen,
                      isOwned: story.isOwned,
                      style: GoogleFonts.urbanist(fontSize: 14.sp),
                      image: story.image,
                      text: story.username))
                  .toList())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        _header(),
        SizedBox(
          height: 15.h,
        ),
        TagBar(
          tags: TagBarDummyData.tags,
          onClick: (id) {
            //TODO: implement
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
                child: Column(
                    children: List.generate(
                        4,
                        (index) => Padding(
                              padding: EdgeInsets.only(bottom: 40.0.h),
                              child: PostCard(
                                profileImage: PostDummyData.profileImage,
                                dateTime: PostDummyData.dateTime,
                                username: PostDummyData.username,
                                postTitle: PostDummyData.postTitle,
                                initialCommentCount:
                                    PostDummyData.initialCommentCount,
                                initialLikeCount:
                                    PostDummyData.initialLikeCount,
                                initialPresentCount:
                                    PostDummyData.initialPresentCount,
                                images: PostDummyData.images,
                              ),
                            )))),
          ),
        ),
      ],
    ));
  }
}
