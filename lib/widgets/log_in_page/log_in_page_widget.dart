// Copyright 2022 The myAPFP Authors. All rights reserved.

import '/main.dart';
import '../welcome/welcome_widget.dart';

import '/firebase/fire_auth.dart';

import '/util/toasted/toasted.dart';
import '/util/validator/validator.dart';
import '/util/internet_connection/internet.dart';

import '/widgets/confimation_dialog/confirmation_dialog.dart';
import '/widgets/email_not_confirmed/email_not_confirmed_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInPageWidget extends StatefulWidget {
  LogInPageWidget({Key? key}) : super(key: key);

  @override
  _LogInPageWidgetState createState() => _LogInPageWidgetState();
}

class _LogInPageWidgetState extends State<LogInPageWidget> {
  /// [TextEditingController] for [_emailTextFormField].
  TextEditingController? _emailController;

  /// [TextEditingController] for [_passwordTextFormField].
  TextEditingController? _passwordController;

  /// [TextEditingController] for the [_emailDialogTextField] within [_showEmailDialog].
  TextEditingController? _dialogEmailController;

  /// Controls visisbility of characters in [_passwordTextFormField].
  late bool passwordVisibility;

  /// Controls the [CircularProgressIndicator] loading animation of a button.
  bool _loadingButton = false;

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Serves as key for the [Form] found in [build].
  ///
  /// Used to validate the current state of the [Form].
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _dialogEmailController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    _dialogEmailController!.dispose();
  }

  /// Returns trimmed, lowercased text taken from [_emailController].
  String _getEmail() {
    return _emailController!.text.trim().toLowerCase();
  }

  /// Returns trimmed, lowercased text taken from [_dialogEmailController] within [_showEmailDialog].
  String _getDialogEmail() {
    return _dialogEmailController!.text.trim().toLowerCase();
  }

  /// Returns trimmed text taken from [_passwordController].
  String _getPassword() {
    return _passwordController!.text.trim();
  }

  /// Adds leftToRight [PageTransition] animation between this route,
  /// [LogInPageWidget], and another route.
  PageTransition _transitionTo(Widget child) {
    return PageTransition(
      type: PageTransitionType.leftToRight,
      duration: Duration(milliseconds: 125),
      reverseDuration: Duration(milliseconds: 125),
      child: child,
    );
  }

  /// Returns a [Padding] widget who's child is a [InkWell].
  ///
  /// [InkWell]'s [onTap] parameter is used to go back to [WelcomeWidget].
  ///
  /// [InkWell]'s [child] parameter holds a [Text] which serves as the button title.
  Row _backButton() {
    return Row(children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 50),
        child: InkWell(
          onTap: () async {
            WelcomeWidget.returnToWelcome(context);
          },
          child: Text('< Back', style: FlutterFlowTheme.subtitle2),
        ),
      )
    ]);
  }

  /// Returns a [TextFormField] which is used for email address input.
  ///
  /// This [Widget] uses [_emailController] as its [TextEditingController].
  Row _emailTextFormField() {
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
                if (!Validator.isValidEmail(value)) {
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

  /// Returns a [TextFormField] which is used for password input.
  ///
  /// This [Widget] uses [_passwordController] as its [TextEditingController].
  Row _passwordTextFormField() {
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
                if (Validator.hasProfanity(value)) {
                  return 'Profanity is not allowed';
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

  /// Returns a [Row] whose only child is a [Text] widget wrapped in a [Padding].
  ///
  /// The string passed to this method will be displayed as a label.
  Row _label(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 15, 0, 5),
            child: Text(
              text,
              style: FlutterFlowTheme.title3,
              textAlign: TextAlign.center,
            ))
      ],
    );
  }

  /// This method is called when a user presses the 'Log In' button.
  ///
  /// If the user is not connected to the Internet before
  /// this method is called, a relevant warning toast will be displayed.
  ///
  /// Otherwise, if connected to the Internet, an attempt to validate
  /// the [Form] is made, and if successful, the user is signed in.
  ///
  /// - If the user has verified their email address, they are finally taken to
  /// Home. Otherwise, the user will be taken to the [EmailNotConfirmedWidget] route.
  void _login() async {
    if (await Internet.isConnected()) {
      if (_formKey.currentState!.validate()) {
        await FireAuth.signInUsingEmailPassword(
            email: _getEmail(), password: _getPassword());
        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await currentUser.reload();
          if (currentUser.emailVerified) {
            _goHome();
          } else {
            await Navigator.push(context,
                _transitionTo(EmailNotConfirmedWidget(email: _getEmail())));
          }
        }
      }
    } else
      showSnackbar(context, "Please check your Internet connection");
  }

  /// This method is called when a user attempts to login with the correct
  /// credentials AND has their email address verified.
  ///
  /// When called a [CircularProgressIndicator] loading animation starts until
  /// the user is successfully taken to Home.
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

  /// Returns a [Padding] which creates the 'Log In' button which appears on screen.
  /// When pressed, [_login] is called.
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

  /// When called, this method shows a dialog which has a title, content text
  /// and a [TextField] allowing users to enter their email address.
  ///
  /// The [title] will be displayed on the top of the dialog in bold font.
  ///
  /// The [contentText] will be displayed above the [TextField].
  ///
  /// The [onSubmitTap] parameter holds the method to be called when the user
  /// presses the dialog's submit ('SEND') button.
  void _showEmailDialog(
      {String? title, String? contentText, Function()? onSubmitTap}) {
    ConfirmationDialog.showConfirmationDialog(
        context: context,
        title: Text(title!),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(contentText!, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ConfirmationDialog.dialogTextField(
                enabled: true,
                kbType: TextInputType.emailAddress,
                hintText: 'Enter your email here',
                contr: _dialogEmailController)
          ],
        ),
        onSubmitTap: onSubmitTap!,
        onCancelTap: () => Navigator.pop(context),
        cancelText: "Back",
        submitText: "Send");
  }

  /// Returns a [Padding] which creates the 'Forgot Your Password?' label which appears on screen.
  /// When pressed, [_showEmailDialog] is called, showing a dialog which prompts
  /// a user to enter their email address to receive instructions on how to reset
  /// their password.
  ///
  /// If a user submits an invalid email address, a relevant warning toast is displayed.
  Padding _forgotPasswordLabel() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child:
                Text("Forgot Your Password?", style: FlutterFlowTheme.title3),
            onTap: () => _showEmailDialog(
                title: 'Forget Password',
                contentText:
                    'Please enter the email associated with your account.' +
                        '\n\nYou will recieve a link to reset your password.',
                onSubmitTap: () {
                  if (Validator.isValidEmail(_getDialogEmail())) {
                    if (!Validator.hasProfanity(_getDialogEmail())) {
                      FireAuth.sendResetPasswordLink(email: _getDialogEmail());
                      Navigator.pop(context);
                    } else
                      Toasted.showToast('Profanity is not allowed.');
                  } else
                    Toasted.showToast('Please provide a valid email address');
                }),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: WillPopScope(
            onWillPop: () async {
              WelcomeWidget.returnToWelcome(context);
              return false;
            },
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
                        _backButton(),
                        _label("Email Address"),
                        _emailTextFormField(),
                        _label("Password"),
                        _passwordTextFormField(),
                        _logInButton(),
                        _forgotPasswordLabel()
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
