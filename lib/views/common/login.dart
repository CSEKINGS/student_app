import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_app/controllers/process_data.dart';
import 'package:student_app/models.dart';
import 'package:student_app/views/admin/admin_widgets.dart';

import 'package:student_app/views/utils/theme/theme.dart' as theme;

class LoginPage extends StatefulWidget {
  /// default
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  //GlobalKeys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final snack = GlobalKey<ScaffoldState>();
  final studentFormKey = GlobalKey<FormState>();
  final staffFormKey = GlobalKey<FormState>();

  //TextEditingController Objects and other controllers
  TextEditingController registerNoController = TextEditingController();
  TextEditingController studentPasswordController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController staffPasswordController = TextEditingController();

  PageController? _pageController;

  //FirebaseReferences and its variables
  final reference = FirebaseFirestore.instance;
  late CollectionReference reference1;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Objects
  DatabaseReference dbobj = DatabaseReference();

  //Lists
  List<String> details = [];
  List<Contents> cls = [];
  List<Contents> keys1 = [];

  //Variables
  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool? valid;
  Color left = Colors.black;
  Color right = Colors.white;
  String? _batch, _dept, _regno, password, foundclass, registerNo;

  void formValidation() {
    registerNo = registerNoController.text;
    _batch = '20${registerNo!.substring(4, 6)}';
    _dept = registerNo!.substring(6, 9);
    _regno = registerNo;
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
    listClass();
  }

  void listClass() {
    reference1 = reference
        .collection('collage')
        .doc('entity')
        .collection('class')
        .doc(_dept)
        .collection(_batch!);
    // reference.collection('class').document('$_dept').collection('$_batch');
    reference1.snapshots().listen((event) {
      cls.clear();
      setState(() {
        for (var i = 0; i < event.docs.length; i++) {
          cls.add(Contents.fromSnapshot(event.docs[i]));
        }
        loadPassword();
      });
    });
  }

  void loadPassword() async {
    var reff1 = reference
        .collection('collage')
        .doc('student')
        .collection(_dept!)
        .doc(_batch);
    for (var i = 0; i < cls.length; i++) {
      await reff1
          .collection(cls[i].name ?? "unknown")
          .where('Regno', isEqualTo: _regno)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            password = element.data()['DOB'].toString();
            if (password != studentPasswordController.text) {
              invalidSnackBar('Password is incorrect');
            } else {
              foundclass = cls[i].name;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProcessData(_regno, foundclass)),
              );
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height
              : 775.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Expanded(
                child: Image(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/image_01.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
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
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildSignIn(context),
                    ),
                    ConstrainedBox(
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
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    processKey();
    getUser().then((user) {
      if (user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AdminBottomNav()),
        );
      }
    });

    _pageController = PageController(keepPage: true);
  }

  void invalidSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ));
  }

  void validSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: _onSignInButtonPress,
                child: Text(
                  'Student',
                  style: TextStyle(
                    color: left,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: _onSignUpButtonPress,
                child: Text(
                  'Staff',
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

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 220.0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: studentFormKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              autocorrect: false,
                              maxLength: 12,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 16.0),
                              controller: registerNoController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.person,
                                  size: 22.0,
                                ),
                                hintText: 'Register No',
                                hintStyle: TextStyle(fontSize: 17.0),
                              ),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Enter Register No';
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 25.0,
                                right: 25.0),
                            child: TextFormField(
                              autocorrect: false,
                              maxLength: 10,
                              obscureText: _obscureTextLogin,
                              controller: studentPasswordController,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                              onFieldSubmitted: (input) {
                                if (studentFormKey.currentState!.validate()) {
                                  formValidation();
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: const Icon(
                                  FontAwesomeIcons.lock,
                                  size: 22.0,
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(fontSize: 17.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Icon(
                                    _obscureTextLogin
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                  ),
                                ),
                              ),
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Enter Password';
                                } else if (!RegExp(r'^[0-9/-]{10}$')
                                    .hasMatch(input)) {
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
              ),
              Container(
                margin: const EdgeInsets.only(top: 210.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: theme.GradientColors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: theme.GradientColors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [
                        theme.GradientColors.loginGradientEnd,
                        theme.GradientColors.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: theme.GradientColors.loginGradientEnd,
                  onPressed: () {
                    if (studentFormKey.currentState!.validate()) {
                      formValidation();
                    }
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void processKey() {
    var collRef = FirebaseFirestore.instance.collection('key');
    collRef.snapshots().listen((event) {
      setState(() {
        for (var i = 0; i < event.docs.length; i++) {
          keys1.add(Contents.fromSnapshot(event.docs[i]));
        }
      });
    });
  }

  void validateKey() {
    for (var i = 0; i < keys1.length; i++) {
      if (keys1[i].name == keyController.text) {
        validSnackBar('Loading...');
        adminAuth();
        break;
      } else {
        invalidSnackBar('invalid key');
      }
    }
  }

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  void adminAuth() async {
    User? user;
    try {
      user = (await _auth.signInWithEmailAndPassword(
              email: emailAddressController.text,
              password: staffPasswordController.text))
          .user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (user != null) {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AdminBottomNav()),
        );
      } else {
        invalidSnackBar('invalid user');
      }
    }
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 310.0,
                  child: SingleChildScrollView(
                    child: Form(
                      key: staffFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: keyController,
                                keyboardType: TextInputType.visiblePassword,
                                textCapitalization: TextCapitalization.words,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                style: const TextStyle(fontSize: 16.0),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.key,
                                  ),
                                  hintText: 'Key',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Key';
                                  } else if (input.length < 5) {
                                    return 'key length must be greater than 5';
                                  }
                                  return null;
                                  // return null;
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: emailAddressController,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                style: const TextStyle(fontSize: 16.0),
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.envelope,
                                  ),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                                validator: (String? input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Email Address';
                                  } else if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(input)) {
                                    return 'Valid Email Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2.0,
                          ),
                          SizedBox(
                            height: 89,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                autocorrect: false,
                                controller: staffPasswordController,
                                obscureText: _obscureTextSignup,
                                style: const TextStyle(fontSize: 16.0),
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                },
                                onFieldSubmitted: (input) {
                                  processKey();
                                  if (staffFormKey.currentState!.validate()) {
                                    validateKey();
                                  }
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s\b|\b\s'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: const Icon(
                                    FontAwesomeIcons.lock,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignup,
                                    child: Icon(
                                      _obscureTextSignup
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 300.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: theme.GradientColors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: theme.GradientColors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: [
                        theme.GradientColors.loginGradientEnd,
                        theme.GradientColors.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  //Button field
                  highlightColor: Colors.transparent,
                  splashColor: theme.GradientColors.loginGradientEnd,
                  onPressed: () {
                    processKey();
                    if (staffFormKey.currentState!.validate()) {
                      validateKey();
                    }
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController!.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
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
}

class TabIndicationPainter extends CustomPainter {
  late Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController? pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController!.position;
    var fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    var pageOffset = pos.extentBefore / fullExtent;

    var left2right = dxEntry < dxTarget;
    var entry = Offset(left2right ? dxEntry : dxTarget, dy);
    var target = Offset(left2right ? dxTarget : dxEntry, dy);

    var path = Path();
    path.addArc(
        Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
