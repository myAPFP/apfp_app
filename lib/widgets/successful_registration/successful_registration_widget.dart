// Copyright 2022 The myAPFP Authors. All rights reserved.

import '../welcome/welcome_widget.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';

class SuccessfulRegistrationWidget extends StatefulWidget {
  SuccessfulRegistrationWidget({Key? key}) : super(key: key);

  @override
  _SuccessfulRegistrationWidgetState createState() =>
      _SuccessfulRegistrationWidgetState();
}

class _SuccessfulRegistrationWidgetState
    extends State<SuccessfulRegistrationWidget> {
  /// Controls the [CircularProgressIndicator] loading animation of a button.
  bool _loadingButton = false;

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Returns the header text which is displayed at the top of the
  /// Successful Registration screen.
  Text _headerText() {
    return Text(
      'Thank you for registering! Please verify your email address before logging in.\n\n' +
          'If you are using a BSU email, be sure to check your junk folder.',
      textAlign: TextAlign.center,
      style: TextStyle().copyWith(fontSize: 22, fontWeight: FontWeight.normal),
    );
  }

  /// When pressed, returns the user back to the Welcome screen.
  FFButtonWidget _returnToWelcomeButton() {
    return FFButtonWidget(
      key: Key("Successful.backToHomeButton"),
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRight,
              duration: Duration(milliseconds: 125),
              reverseDuration: Duration(milliseconds: 125),
              child: WelcomeWidget(),
            ),
          );
        } finally {
          setState(() => _loadingButton = false);
        }
      },
      text: 'Back to Home',
      options: FFButtonOptions(
        width: 250,
        height: 50,
        color: Colors.white,
        textStyle: TextStyle()
            .copyWith(fontSize: 24, color: FlutterFlowTheme.primaryColor),
        elevation: 2,
        borderSide: BorderSide(
          color: FlutterFlowTheme.secondaryColor,
          width: 3,
        ),
        borderRadius: 12,
      ),
      loading: _loadingButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 100, 20, 50),
                child: _headerText(),
              ),
            ),
            _returnToWelcomeButton()
          ],
        ),
      ),
    );
  }
}
