import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessfulRegistrationWidget extends StatefulWidget {
  SuccessfulRegistrationWidget({Key key}) : super(key: key);

  @override
  _SuccessfulRegistrationWidgetState createState() =>
      _SuccessfulRegistrationWidgetState();
}

class _SuccessfulRegistrationWidgetState
    extends State<SuccessfulRegistrationWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      'Thank you for registering! Please check your email and confirm your email address before logging in.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
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
                      color: Colors.white,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 2,
                      borderSide: BorderSide(
                        color: Color(0xFFBA0C2F),
                        width: 4,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButton,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
