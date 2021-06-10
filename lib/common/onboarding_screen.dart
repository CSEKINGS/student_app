import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:student_app/common/login.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
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
          body: 'Get latest news about the college via push notification.',
          image: _buildImage('announce'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Notes and Question banks',
          body: 'View and download notes prepared by your college on the go',
          image: _buildImage('notes'),
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent)),
            child: const Text(
              'sample btn',
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'placeholder',
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Lets go ', style: bodyStyle),
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
