import 'package:flutter/material.dart';
import 'package:social_media_freelance/pages/skeleton.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Delay the navigation to the next page by 1 second
    // remove this when you actually use splash screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/skeleton');
    });
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
