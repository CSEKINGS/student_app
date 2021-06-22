import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// grade UI
class Grade extends StatefulWidget {
  /// default
  const Grade(this.details);

  /// get register number and DOB to autofill in web view
  final List details;

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
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(child: Text('Visit https://coe1.annauniv.edu/home/'));
    } else {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              WebView(
                key: _key,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                onPageFinished: (url) {
                  _controller.evaluateJavascript(
                      "document.getElementsByClassName('box')[0].style.display='none';"
                      "document.getElementsByTagName(\"body\")[0].style.background='none';"
                      "document.querySelector(\"#slider\").style.display='none';"
                      "document.querySelector(\"#sidebar > div\").style.display='none';"
                      "document.querySelector(\"#footer\").style.display='none';"
                      "document.querySelector(\"#header\").style.display='none';"
                      "document.querySelector(\"#menufront\").style.display='none';"
                      "document.getElementById('register_no').value = '${widget.details[2]}';"
                      "document.getElementById('dob').value = '${widget.details[4]}';");

                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(),
            ],
          ),
        ),
      );
    }
  }
}
