import 'package:apfp/firebase/fire_auth.dart';
import 'package:apfp/util/internet_connection/internet.dart';
import 'package:apfp/util/toasted/toasted.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/main.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:apfp/util/validator/validator.dart';

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
  final _formKey = GlobalKey<FormState>();
  final verify = Validator();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  String _getEmail() {
    return _emailController!.text.trim().toLowerCase();
  }

  String _getPassword() {
    return _passwordController!.text.trim();
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
    return Text('< Back to Home', style: FlutterFlowTheme.subtitle2);
  }

  Padding _backButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            _transitionTo(WelcomeWidget()),
          );
        },
        child: _backToHomeText(),
      ),
    );
  }

  Padding _returnToWelcome() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 80),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [_backButton()],
      ),
    );
  }

  Row _emailTextField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              key: Key("Login.emailTextField"),
              cursorColor: FlutterFlowTheme.secondaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a value";
                }
                if (!verify.isValidEmail(value)) {
                  return "Please provide a valid email address";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'example@bsu.edu',
                hintStyle: FlutterFlowTheme.bodyText1,
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
              style: FlutterFlowTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  Row _passwordTextField() {
    return Row(
      key: Key('LogIn.passwordTextBox'),
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              key: Key("Login.passwordTextField"),
              cursorColor: FlutterFlowTheme.secondaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a value";
                }
                return null;
              },
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
                  key: Key("Login.passwordVisibiltyIcon"),
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

  Padding _textFieldLabel(String text,
      {MainAxisAlignment alignment = MainAxisAlignment.center,
      double lPadding = 0}) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(lPadding, 0, 0, 5),
        child: Row(mainAxisAlignment: alignment, children: [
          Text(text,
              textAlign: TextAlign.center, style: FlutterFlowTheme.title3)
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
              child: _textFieldLabel(text),
            ),
          )
        ],
      ),
    );
  }

  void _login() async {
    if (await Internet.isConnected()) {
      if (_formKey.currentState!.validate()) {
        await FireAuth.signInUsingEmailPassword(
            email: _getEmail(), password: _getPassword(), context: context);
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await currentUser.reload();
          if (currentUser.emailVerified) {
            _goHome();
          } else {
            Toasted.showToast("Please verify your email address.");
          }
        }
      }
    } else
      Toasted.showToast("Please connect to the Internet.");
  }

  void _goHome() async {
    setState(() => _loadingButton = true);
    try {
      await Navigator.push(
        context,
        _transitionTo(NavBarPage(initialPage: 0)),
      );
    } finally {
      setState(() => _loadingButton = false);
    }
  }

  Padding _logInButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FFButtonWidget(
            key: Key('LogIn.logInButton'),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              _login();
            },
            text: 'Log In',
            options: FFButtonOptions(
              width: 150,
              height: 50,
              color: Color(0xFFBA0C2F),
              textStyle: FlutterFlowTheme.title2,
              elevation: 2,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton,
          )
        ],
      ),
    );
  }

  Padding _resendEmailButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FFButtonWidget(
            key: Key('LogIn.resendEmailButton'),
            onPressed: () async {
              FireAuth.reSendEmailVerification();
            },
            text: 'Resend email verification',
            options: FFButtonOptions(
              width: 250,
              height: 50,
              color: Color(0xFFBA0C2F),
              textStyle: FlutterFlowTheme.title2,
              elevation: 2,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
            loading: _loadingButton,
          )
        ],
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
            child: _textFieldLabel("Forgot Your Password?"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _returnToWelcome(),
                  _textFieldLabel("Email Address",
                      alignment: MainAxisAlignment.start, lPadding: 20),
                  _emailTextField(),
                  _textFieldLabel("Password",
                      alignment: MainAxisAlignment.start, lPadding: 20),
                  _passwordTextField(),
                  _logInButton(),
                  _resendEmailButton(),
                  _forgotPasswordLabel()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
