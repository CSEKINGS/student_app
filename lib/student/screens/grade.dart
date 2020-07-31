import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Grade extends StatefulWidget {
  final List details;

  Grade(this.details);

  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  String url = 'https://coe1.annauniv.edu/home/';
  bool isLoading = true;
  final _key = UniqueKey();
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
    print('grade openeeed');
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              WebView(
                key: _key,
                initialUrl: this.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                onPageFinished: (url) {
                  _controller.evaluateJavascript("document.getElementsByClassName('box')[0].style.display='none';" +
                      "document.querySelector(\"#slider\").style.display='none';" +
                      "document.querySelector(\"#sidebar > div\").style.display='none';" +
                      "document.querySelector(\"#footer\").style.display='none';" +
                      "document.querySelector(\"#header\").style.display='none';" +
                      "document.querySelector(\"#menufront\").style.display='none';" +
                      "document.getElementById('register_no').value = '${widget.details[2]}';" +
                      "document.getElementById('dob').value = '${widget.details[4]}';");

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
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
      );
}
