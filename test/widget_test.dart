import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:student_app/views/student/screens/dashboard.dart';
import 'package:student_app/views/student/screens/profile.dart';

void main() {
  List<String> details = [
    'Harish',
    'bdjdjsjs',
    '820617104017',
    '84949',
    '13-11-1999',
    '2017',
    'gdhdhjs@hss.sn',
    'JDJDJJENN',
    'CSE',
    'bdbdjdj',
    'https://images.unsplash.com/photo-15645643218370',
  ];
  testWidgets('Dashboard screen renders properly', (WidgetTester tester) async {
    //execute test
    await tester.pumpWidget(MaterialApp(home: Dashboard(details: details, days: 19)));
    await tester.pump(Duration(seconds: 7));
    final Finder titleText = find.text('Attendance Percentage');
    final Finder percentageText = find.text('10.53%');
    final Finder noOfDaysText = find.text('Total number of days:19');
    final Finder presentDaysText = find.text('No of Present days: null');
    final Finder pieChart = find.byType(CircularPercentIndicator);
    expect(titleText, findsOneWidget);
    expect(percentageText, findsOneWidget);
    expect(noOfDaysText, findsOneWidget);
    expect(presentDaysText, findsOneWidget);
    expect(pieChart, findsOneWidget);
  });

  testWidgets('Profile page displays text and image', (WidgetTester tester)async{

    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(home: Profile(details: details))));

    final Finder name = find.text('Name :  Harish');
    final Finder rollNumber = find.text('Roll no : BDJDJSJS');
    final Finder registerNo = find.text('Register no : 820617104017');
    final Finder phoneNo = find.text('Phone number : 84949');
    final Finder dob = find.text('DOB :  13-11-1999');
    final Finder batch = find.text('Batch :  2017');
    final Finder email = find.text('Email :  gdhdhjs@hss.sn');
    final Finder bg = find.text('Blood group :  JDJDJJENN');
    final Finder department = find.text('Department :  CSE');
    final Finder address = find.text('Address :  bdbdjdj');
    final Finder image = find.byType(CircleAvatar);

    expect(name, findsOneWidget);
    expect(rollNumber, findsOneWidget);
    expect(registerNo, findsOneWidget);
    expect(phoneNo, findsOneWidget);
    expect(dob, findsOneWidget);
    expect(batch, findsOneWidget);
    expect(email, findsOneWidget);
    expect(bg, findsOneWidget);
    expect(department, findsOneWidget);
    expect(address, findsOneWidget);
    expect(image, findsOneWidget);

  });
}
