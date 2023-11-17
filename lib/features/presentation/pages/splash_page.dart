import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perfect_feed/features/presentation/pages/main_page.dart';
import 'package:perfect_feed/features/presentation/pages/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void didChangeDependencies() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var box = await Hive.openBox('perfect_feed_box');
    bool onBoardingShowed = box.get('onboarding_showed') == true;
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => !onBoardingShowed
          ? OnBoardingPage()
          : MainPage()
      ),
    );
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash_background.png',
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
