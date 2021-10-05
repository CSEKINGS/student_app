import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:student_app/common/login.dart';

/// onBoarding page UI
class OnBoardingPage extends StatefulWidget {
  /// default constructor
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Widget _buildImage(String assetName) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Image.asset('assets/$assetName.png', width: 350.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      // pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: 'Timetables',
          body: 'Get up-to-date timetables in single click.',
          image: _buildImage('timetable'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Events',
          body: 'Learn about events and fest.',
          image: _buildImage('candidate'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Grades',
          body: 'Check your grades and assessment exams scores.',
          image: _buildImage('grade'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Announcements',
          body: 'Get latest news via push notification.',
          image: _buildImage('announce'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Notes and Question banks',
          body: 'View and download notes on the go',
          image: _buildImage('notes'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Q/A',
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Submit your question in global chat ', style: bodyStyle),
            ],
          ),
          image: _buildImage('announce'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
