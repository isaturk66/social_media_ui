import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryElement extends StatelessWidget {
  // Constructor for the StoryElement class.
  // Takes in the following required arguments:
  // - size: the size of the story element
  // - image: an Image widget displaying the user's profile picture
  // And the following optional arguments:
  // - isOwned: a boolean value indicating whether the story element is owned by the current user
  // - isSeen: a boolean value indicating whether the story has been seen by the current user
  // - text: the name of the user associated with the story element
  const StoryElement(
      {Key? key,
      required this.size,
      required this.image,
      this.isOwned = false,
      this.isSeen = false,
      required this.text,
      required this.style})
      : super(key: key);

  final double size;
  final Image image;
  final bool isOwned;
  final TextStyle style;
  final bool isSeen;
  final String text;

  // Builds the widget tree for the StoryElement widget.
  @override
  Widget build(BuildContext context) {
    // Returns a Column widget containing a Stack widget and a Text widget.
    return Column(
      children: [
        // The Stack widget displays the user's profile picture and an optional "add" icon.
        Stack(
          children: [
            // The Container widget is used to display the user's profile picture.
            Container(
              // The BoxDecoration widget is used to add a border around the Container.
              decoration: BoxDecoration(
                // If the story element is owned by the current user, no border is displayed.
                // Otherwise, a border is displayed with a width of 2.w and a color determined by the isSeen variable.
                border: isOwned
                    ? Border()
                    : Border.all(
                        width: 2.w,
                        color: isSeen
                            ? Colors.grey
                            : Color.fromARGB(159, 228, 79, 101),
                      ),
                // The border radius is set to half of the size of the story element.
                borderRadius: BorderRadius.circular(size / 2),
              ),
              // The ClipRRect widget is used to clip the Container to a rounded shape.
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: Container(
                  width: size,
                  height: size,
                  // The Image widget displays the user's profile picture.
                  child: Image(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // If the story element is owned by the current user, an "add" icon is displayed in the bottom right corner.
            isOwned
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12.5.w,
                      height: 12.5.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.w),
                        color: Color.fromARGB(159, 228, 79, 101).withOpacity(1),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 10.w,
                      ),
                    ))
                : Container()
          ],
        ),
        // The SizedBox widget is used to add a fixed amount of vertical space between the Stack widget and the Text widget.
        SizedBox(
          height: 2.h,
        ),
        // The Text widget displays the name of the user associated with the story element.
        // If the story element is owned by the current user, the text "Hikayem" is displayed instead.
        Text(isOwned ? "Hikayem" : text, style: style)
      ],
    );
  }
}

class StoryBar extends StatelessWidget {
  // Constructor for the StoryBar class.
  // Takes in a required argument:
  // - storyElements: a list of StoryElement widgets to be displayed in the StoryBar
  const StoryBar({Key? key, required this.storyElements}) : super(key: key);

  final List<StoryElement> storyElements;

  // Builds the widget tree for the StoryBar widget.
  @override
  Widget build(BuildContext context) {
    // Returns a Container widget containing an Expanded widget.
    // The Expanded widget takes up all available space within the Container widget.
    return Container(
      width: 1.sw,
      height: 90.h,
      child: ListView.builder(
        // The scroll direction is set to horizontal.
        scrollDirection: Axis.horizontal,
        // The shrinkWrap property is set to true to make the ListView fit its children.
        shrinkWrap: true,
        // Padding is added to the ListView to add space between the items.
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        // The number of items in the list is determined by the length of the storyElements list.
        itemCount: storyElements.length,
        // The itemBuilder function is called for each item in the list to build the widget for that item.
        itemBuilder: (context, int) {
          // Padding is added around each StoryElement widget.
          return Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w),
            child: storyElements[int],
          );
        },
      ),
    );
  }
}
