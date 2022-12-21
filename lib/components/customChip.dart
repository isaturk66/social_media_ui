import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChip extends StatelessWidget {
  const CustomChip(
      {Key? key,
      required this.icon,
      required this.text,
      required this.border,
      required this.onTap,
      required this.width,
      required this.height,
      required this.color,
      required this.textColor})
      : super(key: key);

  final IconData icon;
  final String text;
  final bool border;
  final double width, height;
  final Color color, textColor;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: border ? Colors.transparent : color,
          border: border
              ? Border.all(
                  color: color,
                  width: 2.w,
                )
              : Border(),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
              size: height * 0.6,
            ),
            SizedBox(
              width: 7.w,
            ),
            Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: (height * 0.35).sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
