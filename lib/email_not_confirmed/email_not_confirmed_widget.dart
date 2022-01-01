import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';

class EmailNotConfirmedWidget extends StatefulWidget {
  EmailNotConfirmedWidget({Key? key}) : super(key: key);

  @override
  _EmailNotConfirmedWidgetState createState() =>
      _EmailNotConfirmedWidgetState();
}

class _EmailNotConfirmedWidgetState extends State<EmailNotConfirmedWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Padding _contextMessage() {
    return Padding(
      key: Key('Email.contextMessage'),
      padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 300,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.tertiaryColor,
            ),
            child: Text(
              'Your account cannot be accessed until the email address is confirmed.' +
                  'Please check your email account for a confirmation before logging in.',
              textAlign: TextAlign.center,
              style: TextStyle().copyWith(
                fontWeight: FontWeight.normal,
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _resendEmailRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.tertiaryColor,
          ),
          child: Text(
            'Resend Confirmation Email',
            textAlign: TextAlign.center,
            style: TextStyle().copyWith(
              color: FlutterFlowTheme.secondaryColor,
            ),
          ),
        )
      ],
    );
  }

  Padding _returnToHome() {
    return Padding(
      key: Key('Email.returnHomeButton'),
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_returnHomeButton()],
      ),
    );
  }

  FFButtonWidget _returnHomeButton() {
    return FFButtonWidget(
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
        width: 180,
        height: 50,
        color: FlutterFlowTheme.tertiaryColor,
        textStyle: TextStyle().copyWith(
          color: FlutterFlowTheme.primaryColor,
        ),
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
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [_contextMessage(), _resendEmailRow(), _returnToHome()],
        ),
      ),
    );
  }
}
