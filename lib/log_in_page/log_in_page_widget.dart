import 'package:apfp/fire_auth/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:apfp/validator/validator.dart';

class LogInPageWidget extends StatefulWidget {
  LogInPageWidget({Key? key}) : super(key: key);

  @override
  _LogInPageWidgetState createState() => _LogInPageWidgetState();
}

class _LogInPageWidgetState extends State<LogInPageWidget> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  late bool passwordVisibility;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final verify = Validator();
  final fire_auth = FireAuth();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _returnHome(),
            _textBoxLabel("Email Address",
                alignment: MainAxisAlignment.start, lPadding: 20),
            _emailRow(),
            _textBoxLabel("Password",
                alignment: MainAxisAlignment.start, lPadding: 20),
            _passwordRow(),
            _logIn(),
            _forgotPasswordLabel()
          ],
        ),
      ),
    );
  }

  String _getEmail() {
    return _emailController!.text.trim().toLowerCase();
  }

  String _getPassword() {
    return _passwordController!.text.trim();
  }

  bool _allInputsIsValid() {
    return verify.isValidEmail(_getEmail());
  }

  PageTransition _transitionTo(Widget child) {
    return PageTransition(
      type: PageTransitionType.leftToRight,
      duration: Duration(milliseconds: 125),
      reverseDuration: Duration(milliseconds: 125),
      child: child,
    );
  }

  Text _backToHomeText() {
    return Text(
      '< Back to Home',
      style: FlutterFlowTheme.title2.override(
        fontFamily: 'Open Sans',
        color: Color(0xFFBA0C2F),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InkWell _backButton() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          _transitionTo(WelcomeWidget()),
        );
      },
      child: _backToHomeText(),
    );
  }

  Padding _paddedBackButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
      child: _backButton(),
    );
  }

  Padding _returnHome() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 80),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [_paddedBackButton()],
      ),
    );
  }

  TextFormField _emailTextBox() {
    return TextFormField(
      controller: _emailController,
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'example@bsu.edu',
        hintStyle: FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Open Sans',
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ),
      style: FlutterFlowTheme.bodyText1.override(
        fontFamily: 'Open Sans',
        fontSize: 16,
      ),
      textAlign: TextAlign.start,
    );
  }

  Row _emailRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: _emailTextBox(),
          ),
        )
      ],
    );
  }

  Row _passwordRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              controller: _passwordController,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () => passwordVisibility = !passwordVisibility,
                  ),
                  child: Icon(
                    passwordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Color(0xFF757575),
                    size: 22,
                  ),
                ),
              ),
              style: FlutterFlowTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  Padding _textBoxLabel(String text,
      {MainAxisAlignment alignment = MainAxisAlignment.center,
      double lPadding = 0}) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(lPadding, 0, 0, 0),
        child: Row(mainAxisAlignment: alignment, children: [
          Text(text,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ))
        ]));
  }

  Padding label(String text) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: _textBoxLabel(text),
            ),
          )
        ],
      ),
    );
  }

  void _signIn() async {
    if (_allInputsIsValid()) {
      await fire_auth.signInUsingEmailPassword(
          email: _getEmail(), password: _getPassword(), context: context);
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        fire_auth.refreshUser(currentUser);
        if (currentUser.emailVerified) {
          _goHome();
        } else {
          FireAuth.showToast("Please verify your email address.");
        }
      }
    }
  }

  void _goHome() async {
    setState(() => _loadingButton = true);
    try {
      await Navigator.push(
        context,
        _transitionTo(NavBarPage(initialPage: "Home")),
      );
    } finally {
      setState(() => _loadingButton = false);
    }
  }

  FFButtonWidget _logInButton() {
    return FFButtonWidget(
      onPressed: () async {
        _signIn();
      },
      text: 'Log In',
      options: FFButtonOptions(
        width: 150,
        height: 50,
        color: Color(0xFFBA0C2F),
        textStyle: FlutterFlowTheme.bodyText1.override(
          fontFamily: 'Open Sans',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: 12,
      ),
      loading: _loadingButton,
    );
  }

  Padding _logIn() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_logInButton()],
      ),
    );
  }

  Padding _forgotPasswordLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: _textBoxLabel("Forgot Your Password?"),
          )
        ],
      ),
    );
  }
}
