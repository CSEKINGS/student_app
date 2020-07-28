import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Grade extends StatefulWidget {
  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  String url = 'https://coe1.annauniv.edu/home/';
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: this.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),
      );
}
