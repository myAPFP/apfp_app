import 'package:apfp/firebase/fire_auth.dart';
import 'package:apfp/util/internet_connection/internet.dart';
import 'package:apfp/util/toasted/toasted.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
import 'package:apfp/widgets/email_not_confirmed/email_not_confirmed_widget.dart';
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
  TextEditingController? _dialogEmailController;
  late bool passwordVisibility;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
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

  String _getEmail() {
    return _emailController!.text.trim().toLowerCase();
  }

  String _getDialogEmail() {
    return _dialogEmailController!.text.trim().toLowerCase();
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

  Row _backButton() {
    return Row(children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 0, 50),
        child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              _transitionTo(WelcomeWidget()),
            );
          },
          child: _backToHomeText(),
        ),
      )
    ]);
  }

  Row _emailTextFormField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: TextFormField(
              key: Key("Login.emailTextField"),
              autofillHints: [AutofillHints.email],
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
              decoration: InputDecoration(
                  hintText: 'example@bsu.edu',
                  hintStyle: FlutterFlowTheme.bodyText1,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2))),
              style: FlutterFlowTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  Row _passwordTextFormField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
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
                border: OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 2)),
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
            await Navigator.push(
                context, _transitionTo(EmailNotConfirmedWidget(email: _getEmail())));
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

  void _showEmailDialog(
      {String? title, String? contentText, Function()? onSubmitTap}) {
    ConfirmationDialog.showConfirmationDialog(
        context: context,
        title: title!,
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
                    FireAuth.sendResetPasswordLink(email: _getDialogEmail());
                    Navigator.pop(context);
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
      ),
    );
  }
}
