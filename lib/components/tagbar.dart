import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TagElement extends StatelessWidget {
  TagElement(
      {Key? key,
      this.isSelected = false,
      required this.label,
      required this.onClick,
      required this.id,
      double? highlightWidth})
      : highlightWidth = highlightWidth ?? 45.w,
        super(key: key);

  final int id;
  final bool isSelected;
  final String label;
  final double highlightWidth;
  final Function(int id) onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick(id);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Text(label,
              style: GoogleFonts.urbanist(
                  fontSize: 14.sp,
                  color: isSelected ? const Color(0xFFFF4D67) : Colors.grey)),
          Container(
            height: 3.h,
            width: highlightWidth,
            decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF4D67) : Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.h),
                  topRight: Radius.circular(3.h),
                )),
          ),
        ],
      ),
    );
  }
}

class TagBar extends StatefulWidget {
  const TagBar(
      {Key? key,
      required this.tags,
      required this.onClick,
      this.initialSelected = 0})
      : super(key: key);

  final List<String> tags;
  final Function(int id) onClick;
  final int initialSelected;

  @override
  State<TagBar> createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> {
  bool _atEnd = false;
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.h),
        child: Stack(
          children: [
            Container(
              width: 0.95.sw - 25.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 1.w, color: Color(0xFFDDDDDD).withOpacity(0.3)),
              ),
              child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (scrollUpdate) {
                    setState(() {
                      _atEnd = scrollUpdate.metrics.pixels ==
                          scrollUpdate.metrics.maxScrollExtent;
                    });
                    return true;
                  },
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.tags.length,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    itemBuilder: (context, int) {
                      return Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: TagElement(
                            id: int,
                            isSelected: _selected == int,
                            label: widget.tags[int],
                            onClick: (id) {
                              setState(() {
                                _selected = id;
                              });
                              widget.onClick(id);
                            },
                          ));
                    },
                  )),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 35.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1.w,
                      color: Color(0xFFDDDDDD).withOpacity(0.3),
                    ),
                    right: BorderSide(
                      width: 1.w,
                      color: Color(0xFFDDDDDD).withOpacity(0.3),
                    ),
                    bottom: BorderSide(
                      width: 2.w,
                      color: Color(0xFFDDDDDD).withOpacity(0.3),
                    ),
                  ),
                ),
                child: Center(
                  child: _atEnd
                      ? Container()
                      : Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 17.sp,
                        ),
                ),
              ),
            ),
          ],
        ));
  }
}
