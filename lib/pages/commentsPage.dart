import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_freelance/constants/dummy_data.dart';
import 'package:social_media_freelance/models/comment_model.dart';

class _CommentTile extends StatefulWidget {
  _CommentTile({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  State<_CommentTile> createState() => __CommentTileState();
}

class __CommentTileState extends State<_CommentTile> {
  late int _likes;
  late bool _liked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _likes = widget.comment.likes;
    _liked = widget.comment.isLiked;
  }

  Widget ProfilePicture() => Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: widget.comment.image.image,
            fit: BoxFit.cover,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 20.w),
          ProfilePicture(),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 0.5.sw,
                child: Text.rich(TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp), //apply style to all
                    children: [
                      TextSpan(
                          text: widget.comment.username,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "    "),
                      TextSpan(text: widget.comment.comment)
                    ])),
              ),
              !widget.comment.isOwned
                  ? Padding(
                      padding: EdgeInsets.only(top: 6.0.w, left: 10.0.w),
                      child: Text(
                        '${_likes} beğenme',
                        style: GoogleFonts.urbanist(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF616161)),
                      ),
                    )
                  : Container()
            ],
          ),
          Expanded(child: Container()),
          !widget.comment.isOwned
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _liked = !_liked;
                      _liked ? _likes++ : _likes--;
                    });
                  },
                  icon: Icon(Icons.favorite_border_outlined,
                      size: 20.sp,
                      color: _liked ? Color(0xFFFF4D67) : Colors.grey))
              : Container(),
        ],
      ),
    );
  }
}

class _MessengerBar extends StatelessWidget {
  _MessengerBar({Key? key, required this.onSend, required this.image})
      : super(key: key);

  final Function(String text) onSend;
  final Image image;
  final TextEditingController _controller = TextEditingController();

  Widget _ProfilePicture() => Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: image.image,
            fit: BoxFit.cover,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 1.sw,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0, // border width
            color: Colors.grey.withOpacity(0.3), // border color
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          _ProfilePicture(),
          SizedBox(width: 15.w),
          Expanded(
              child: Container(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Yorum yaz...',
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          )),
          InkWell(
            onTap: () {
              onSend(_controller.text);
              _controller.clear();
            },
            child: Container(
              height: 60.h,
              width: 80.w,
              child: Center(
                child: Icon(
                  Icons.send,
                  size: 25.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late List<Comment> _comments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comments = CommentDummyData.comments;
  }

  Widget HorizontalDivider() => Container(
        width: 0.8.sw,
        height: 1.h,
        color: Colors.grey.withOpacity(0.5),
      );

  Widget _header(BuildContext context) => Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Stack(
          children: [
            Container(
              width: 1.sw,
              child: Center(
                child: Text(
                  'Yorumlar',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25.sp,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            _header(context),
            SizedBox(height: 10.h),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  _CommentTile(
                    comment: CommentDummyData.title,
                  ),
                  SizedBox(height: 15.h),
                  HorizontalDivider(),
                  SizedBox(height: 15.h),
                  ..._comments
                      .map((e) => Padding(
                            padding: EdgeInsets.only(bottom: 12.0.h),
                            child: _CommentTile(
                              comment: e,
                            ),
                          ))
                      .toList()
                ],
              ),
            )),
            _MessengerBar(
              onSend: (text) {
                Comment newComment = Comment(
                    username: "ranatrkylmz",
                    comment: text,
                    likes: 0,
                    image: ProfileDummyData.profileImage);

                setState(() {
                  _comments.add(newComment);
                });
              },
              image: ProfileDummyData.profileImage,
            ),
          ],
        ),
      ),
    );
  }
}
