import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
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
