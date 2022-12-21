import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_freelance/constants/custom_icons.dart';
import 'package:social_media_freelance/constants/grid_structure.dart';
import 'package:intl/intl.dart';

class _ImageDialog extends StatelessWidget {
  const _ImageDialog({Key? key, required this.image}) : super(key: key);

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.w),
        child: Container(
          color: Colors.transparent, // set the background color to transparent
          width: 0.9.sw,
          child: Image(
            image: image.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader(
      {Key? key,
      required this.profileImage,
      required this.dateTime,
      required this.username,
      required this.postTitle})
      : super(key: key);

  final Image profileImage;
  final DateTime dateTime;
  final String username;
  final String postTitle;

  int howManyHoursAgo(DateTime time) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(time);
    return diff.inHours;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: EdgeInsets.all(5.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.w),
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  child: Image(
                    image: profileImage.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: GoogleFonts.urbanist(
                      fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  "${howManyHoursAgo(dateTime)} hours ago",
                  style: GoogleFonts.urbanist(
                      color: Color(0xFF616161),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ]),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Text(
                postTitle,
                style: GoogleFonts.urbanist(
                    fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody({Key? key, required this.images, required this.onImageClick})
      : super(key: key);
  final List<Image> images;
  final Function(Image) onImageClick;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.w),
      child: Container(
        width: 0.95.sw - 20,
        height: 0.95.sw - 20,
        child: StaggeredGrid.count(
            crossAxisCount: 6,
            mainAxisSpacing: 2.w,
            crossAxisSpacing: 2.w,
            children: List.generate(
              images.length,
              (index) {
                List gridMatrix = GRID_STRUCTURE[images.length - 1][index];
                return StaggeredGridTile.count(
                    crossAxisCellCount: gridMatrix[0],
                    mainAxisCellCount: gridMatrix[1],
                    child: GestureDetector(
                      onTap: () {
                        onImageClick(images[index]);
                      },
                      child: Image(
                        image: images[index].image,
                        fit: BoxFit.cover,
                      ),
                    ));
              },
            ).toList()),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  ActionTile({
    Key? key,
    this.color = Colors.black,
    required this.text,
    required this.icon,
    this.iconOffset = Offset.zero,
    required this.onClick,
  }) : super(key: key);

  final TEXT_STYLE = GoogleFonts.urbanist(
      fontSize: 12.sp, fontWeight: FontWeight.w600, color: Color(0xFF212121));

  final Color color;
  final String text;
  final IconData icon;
  final Offset iconOffset;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: SizedBox(
        width: 80.w,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: iconOffset.dy.isNegative ? iconOffset.dy.abs() : 0,
                    bottom: !iconOffset.dy.isNegative ? iconOffset.dy : 0,
                    left: !iconOffset.dx.isNegative ? iconOffset.dx : 0,
                    right: iconOffset.dx.isNegative ? iconOffset.dx.abs() : 0),
                child: Icon(
                  icon,
                  color: color,
                  size: 20.w,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                text,
                style: TEXT_STYLE.copyWith(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PostFooter extends StatelessWidget {
  _PostFooter(
      {Key? key,
      required this.onLikeClick,
      required this.onCommentClick,
      required this.onGiftClick,
      required this.onSendClick,
      required this.likeCount,
      required this.commentCount,
      required this.presentCount,
      required this.isLiked,
      required this.isGifted})
      : super(key: key);
  final Function() onLikeClick;
  final Function() onCommentClick;
  final Function() onGiftClick;
  final Function() onSendClick;

  final int likeCount, commentCount, presentCount;
  final bool isLiked, isGifted;

  final double SPACING = 0.0.w;

  String formatNumber(int number) => NumberFormat.compact().format(number);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.95.sw,
      height: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ActionTile(
                color: isLiked ? Color(0xFFFF4D67) : Colors.black,
                text: formatNumber(likeCount),
                icon: Icons.favorite_border_outlined,
                onClick: onLikeClick),
            SizedBox(
              width: SPACING,
            ),
            ActionTile(
                text: formatNumber(commentCount),
                icon: Icons.comment_outlined,
                onClick: onCommentClick),
            SizedBox(
              width: SPACING,
            ),
            ActionTile(
                text: formatNumber(presentCount),
                iconOffset: Offset(0, 5.h),
                color: isGifted ? Color(0xFFFF4D67) : Colors.black,
                icon: CustomIcons.gift,
                onClick: onGiftClick),
            Expanded(child: Container()),
            GestureDetector(onTap: onSendClick, child: Icon(CustomIcons.send)),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  PostCard(
      {Key? key,
      required this.initialLikeCount,
      required this.initialCommentCount,
      required this.initialPresentCount,
      this.isInitiallyLiked = false,
      this.initiallyGifted = false,
      required this.profileImage,
      required this.dateTime,
      required this.username,
      required this.postTitle,
      required this.images})
      : super(key: key);

  final bool isInitiallyLiked, initiallyGifted;
  final int initialLikeCount, initialCommentCount, initialPresentCount;

  final List<Image> images;
  final Image profileImage;
  final DateTime dateTime;
  final String username;
  final String postTitle;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _likeCount, _commentCount, _presentCount;

  late bool _liked, _gifted;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.initialLikeCount;
    _commentCount = widget.initialCommentCount;
    _presentCount = widget.initialPresentCount;
    _liked = widget.isInitiallyLiked;
    _gifted = widget.initiallyGifted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.95.sw,
      height: 480.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PostHeader(
            profileImage: widget.profileImage,
            dateTime: widget.dateTime,
            username: widget.username,
            postTitle: widget.postTitle,
          ),
          SizedBox(
            height: 5.h,
          ),
          _PostBody(
            images: widget.images,
            onImageClick: (image) {
              showDialog(
                  context: context,
                  builder: (context) => _ImageDialog(image: image));
            },
          ),
          _PostFooter(
            isLiked: _liked,
            likeCount: _likeCount,
            commentCount: _commentCount,
            presentCount: _presentCount,
            onLikeClick: () {
              if (_liked) {
                setState(() {
                  _likeCount--;
                  _liked = false;
                });
              } else {
                setState(() {
                  _likeCount++;
                  _liked = true;
                });
              }
            },
            onCommentClick: () {},
            onGiftClick: () {
              if (_gifted) {
                setState(() {
                  _presentCount--;
                  _gifted = false;
                });
              } else {
                setState(() {
                  _presentCount++;
                  _gifted = true;
                });
              }
            },
            onSendClick: () {},
            isGifted: _gifted,
          )
        ],
      ),
    );
  }
}
