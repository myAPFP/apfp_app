import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';

class SuccessfulRegistrationWidget extends StatefulWidget {
  SuccessfulRegistrationWidget({Key? key}) : super(key: key);

  @override
  _SuccessfulRegistrationWidgetState createState() =>
      _SuccessfulRegistrationWidgetState();
}

class _SuccessfulRegistrationWidgetState
    extends State<SuccessfulRegistrationWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Text _headerText() {
    return Text(
      'Thank you for registering! Please check your email and confirm your email address before logging in.',
      textAlign: TextAlign.center,
      style: TextStyle().copyWith(fontSize: 22, fontWeight: FontWeight.normal),
    );
  }

  FFButtonWidget _backToHomeButton() {
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
            _backToHomeButton()
          ],
        ),
      ),
    );
  }
}
