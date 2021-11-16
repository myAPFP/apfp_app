import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPageWidget extends StatefulWidget {
  LogInPageWidget({Key key}) : super(key: key);

  @override
  _LogInPageWidgetState createState() => _LogInPageWidgetState();
}

class _LogInPageWidgetState extends State<LogInPageWidget> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool passwordVisibility;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
            returnHome(),
            textBoxLabel("Email Address",
                alignment: MainAxisAlignment.start, lPadding: 20),
            emailRow(),
            textBoxLabel("Password",
                alignment: MainAxisAlignment.start, lPadding: 20),
            passwordRow(),
            logIn(),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: textBoxLabel("Forgot Your Password?"))
          ],
        ),
      ),
    );
  }

  PageTransition transition() {
    return PageTransition(
      type: PageTransitionType.leftToRight,
      duration: Duration(milliseconds: 125),
      reverseDuration: Duration(milliseconds: 125),
      child: WelcomeWidget(),
    );
  }

  Text backToHomeText() {
    return Text(
      '< Back to Home',
      style: FlutterFlowTheme.title2.override(
        fontFamily: 'Open Sans',
        color: Color(0xFFBA0C2F),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InkWell backButton() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          transition(),
        );
      },
      child: backToHomeText(),
    );
  }

  Padding paddedBackButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
      child: backButton(),
    );
  }

  Padding returnHome() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 80),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [paddedBackButton()],
      ),
    );
  }

  TextFormField emailTextBox() {
    return TextFormField(
      controller: emailController,
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

  Row emailRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: emailTextBox(),
          ),
        )
      ],
    );
  }

  Row passwordRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              controller: passwordController,
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

  Padding textBoxLabel(String text,
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
              child: textBoxLabel(text),
            ),
          )
        ],
      ),
    );
  }

  FFButtonWidget logInButton() {
    return FFButtonWidget(
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          await Navigator.push(
            context,
            transition(),
          );
        } finally {
          setState(() => _loadingButton = false);
        }
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

  Padding logIn() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [logInButton()],
      ),
    );
  }
}
