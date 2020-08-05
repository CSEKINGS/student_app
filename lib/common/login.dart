// import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/admin/attendance/DbAndRefs.dart';
import 'package:student_app/admin/widgets/admin_bottomnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:student_app/common/admin_auth.dart';
// import 'package:';
import 'package:student_app/common/process_data.dart';
import 'theme.dart' as Theme;

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'TheGorgeousLogin',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new LoginPage(),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

// class users {
//   String name, key;
//   users(this.name);
//   users.fromSnapshot(DocumentSnapshot snapshot)
//       : name = snapshot.data['name'],
//         key = snapshot.documentID;
// }

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;

//  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  String _batch, _dept, _regno, password;
  Map data;
  final reference = Firestore.instance;
  List<String> details = [];

  // TextEditingController _uname = TextEditingController();
  // TextEditingController _pass = TextEditingController();
  String pword;
  String initialname;
  bool valid;
  // bool _passwordVisible;
  Widget iconType;

  // bool checkUserSP, checkPwordSP;

  // final _logkey = GlobalKey<FormState>();
  final snack = GlobalKey<ScaffoldState>();
  final ukey = GlobalKey<FormFieldState>();
  final passkey = GlobalKey<FormFieldState>();
  // String userid, passcode;

  auth() {}

  Future processdata() async {
    ukey.currentState.save();
    passkey.currentState.save();
    formValidation(valid);
  }

  Future formValidation(valid) async {
    _batch = '20' + initialname.substring(4, 6);
    _dept = initialname.substring(6, 9);
    _regno = initialname;
    switch (_dept) {
      case '101':
        {
          _dept = 'AE';
        }
        break;
      case '102':
        {
          _dept = 'AUTOMOBILE';
        }
        break;
      case '103':
        {
          _dept = 'CIVIL';
        }
        break;
      case '104':
        {
          _dept = 'CSE';
        }
        break;
      case '105':
        {
          _dept = 'EEE';
        }
        break;
      case '106':
        {
          _dept = 'ECE';
        }
        break;
      case '114':
        {
          _dept = 'MECH';
        }
        break;
      case '121':
        {
          _dept = 'BIOMEDICAL';
        }
        break;
    }
    var reff = reference
        .collection('collage')
        .document('student') //college,student,dept,batch,class,regno
        .collection(_dept)
        .where('Regno', isEqualTo: '$_regno')
        // .document(_batch)
        // .collection('103')
        // .document(_regno)
        .snapshots();
    reff.listen((event) async {
      var datam = event.documents[0];

      // data = event.documents[_regno];
      // print(data);
      // if (event.documents[0] == _regno) {
      password = await datam['DOB'];
      if (pword != password) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Password is incorrect'),
        ));
        return false;
      } else {
        print('data found');
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProcessData(_regno)),
        );
        return true;
      }
      // } else {
      // setState(() {
      //   iconType = Icon(
      //     Icons.error,
      //     color: Colors.red,
      //   );
      // });
      // return false;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        // ignore: missing_return
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 191.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/image_02.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void validcheck() {
  //   ukey.currentState.validate();
  // }

  @override
  void dispose() {
    loginEmailController.dispose();
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    processkey();
    // loginEmailController.addListener(validcheck);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void invalidsnackbar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }

  void validsnackbar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.greenAccent,
      duration: Duration(seconds: 5),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Student",
                  style: TextStyle(
                    color: left,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Staff",
                  style: TextStyle(
                    color: right,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // final cardkey = new GlobalKey<State>();
  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                // key:cardkey,
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 250.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            maxLength: 12,
                            key: ukey,
                            focusNode: myFocusNodeEmailLogin,
                            // controller: loginEmailController,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) {
                              ukey.currentState.validate();
                            },
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Register No.",
                              hintStyle: TextStyle(fontSize: 17.0),
                            ),
                            validator: (String input) {
                              if (!RegExp(r"^[0-9]{12}$").hasMatch(input)) {
                                // setState(() {
                                //   iconType = Icon(
                                //     Icons.error,
                                //     color: Colors.red,
                                //   );
                                // });
                                return 'Invalid Details';
                              }
                              return null;
                            },
                            onSaved: (String input) {
                              initialname = input;
                            },
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            key: passkey,
                            focusNode: myFocusNodePasswordLogin,
                            // controller: loginPasswordController,
                            onFieldSubmitted: (String input) {
                              passkey.currentState.validate();
                            },
                            maxLength: 10,
                            obscureText: _obscureTextLogin,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                size: 22.0,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleLogin,
                                child: Icon(
                                  _obscureTextLogin
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onSaved: (String input) {
                              pword = input.toString();
                            },
                            validator: (String input) {
                              if (!RegExp(r"^[0-9/-]{10}$").hasMatch(input)) {
                                return 'Password is incorrect';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (ukey.currentState.validate()) {
                        if (passkey.currentState.validate()) {
                          processdata();
                        }
                      }
                      // showInSnackBar("Login button pressed");
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final adminuserkey = GlobalKey<FormFieldState>();
  final adminpasskey = GlobalKey<FormFieldState>();
  final adminkey = GlobalKey<FormFieldState>();
  String givenkey, givenuser, givenpass;
  List<Contents> keys1 = List();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  processkey() {
    CollectionReference collref = Firestore.instance.collection('key');
    collref.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          keys1.add(Contents.fromSnapshot(event.documents[i]));
//            print(event.documents[i].data['name']);
        }
//        print(keys1[0].name);
      });
    });
  }

  validatekey() {
    for (int i = 0; i < keys1.length; i++) {
      if (keys1[i].name == givenkey) {
        validsnackbar('Loading...');
        admin_auth();
        break;
      } else {
        invalidsnackbar('invalid key');
      }
    }
  }

  // ignore: non_constant_identifier_names
  admin_auth() async {
    FirebaseUser user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: givenuser, password: givenpass))
          .user;
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AdminBottomNav()),
        );
        // print(true);
      } else {
        invalidsnackbar('invalid user');
      }
    }
  }

  Widget _buildSignUp(BuildContext context) {
    //signup
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 270.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            key: adminkey,
                            //key form field
                            focusNode: myFocusNodeName,
                            controller: signupNameController,
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              BlacklistingTextInputFormatter(
                                  new RegExp(r"\s\b|\b\s"))
                            ],
                            onSaved: (input) async {
                              givenkey = input;
                            },
                            // onFieldSubmitted: (input) {
                            //   givenkey = input.toString();
                            //   adminkey.currentState.validate();
                            // },
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: "Key",
                              hintStyle: TextStyle(fontSize: 16.0),
                            ),
                            validator: (String input) {
                              if (input.length < 5) {
                                return 'key length must be greater than 5';
                              }
                              return null;
                              // return null;
                            },
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            key: adminuserkey,
                            //EmailAdress field
                            focusNode: myFocusNodeEmail,
                            controller: signupEmailController,
                            onSaved: (input) {
                              givenuser = input.toString();
                            },
                            // onFieldSubmitted: (String input) {
                            //   adminuserkey.currentState.validate();
                            // },
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [
                              BlacklistingTextInputFormatter(
                                  new RegExp(r"\s\b|\b\s"))
                            ],
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                              ),
                              hintText: "Email Address",
                              hintStyle: TextStyle(fontSize: 16.0),
                            ),
                            validator: (String input) {
                              if (input.isEmpty) {
                                return 'Email Required';
                              }
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(input)) {
                                return 'Valid Email Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            key: adminpasskey,
                            //PasswordField
                            focusNode: myFocusNodePassword,
                            controller: signupPasswordController,
                            obscureText: _obscureTextSignup,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            onSaved: (input) {
                              givenpass = input.toString();
                            },
                            inputFormatters: [
                              BlacklistingTextInputFormatter(
                                  new RegExp(r"\s\b|\b\s"))
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  _obscureTextSignup
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 260.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(

                    //Button field
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await processkey();
                      adminkey.currentState.save();
                      adminuserkey.currentState.save();
                      adminpasskey.currentState.save();
                      if (adminkey.currentState.validate()) {
                        if (adminuserkey.currentState.validate()) {
                          await validatekey();
                        }
                      }

                      // showInSnackBar("SignUp button pressed");
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

//  void _toggleSignupConfirm() {
//    setState(() {
//      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
//    });
//  }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, Color(0xFFfbab66), 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
