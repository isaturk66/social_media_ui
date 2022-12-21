import 'package:flutter/material.dart';
import 'package:social_media_freelance/services/router.dart' as router;
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    const App(),
  );
}

class NoGlowBehaviour extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            scrollBehavior: NoGlowBehaviour(),
            onGenerateRoute: router.onGenerateRoute,
          );
        });
  }
}
