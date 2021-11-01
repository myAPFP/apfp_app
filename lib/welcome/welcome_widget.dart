import '../create_account/create_account_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../log_in_page/log_in_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeWidget extends StatefulWidget {
  WelcomeWidget({Key key}) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget>
    with TickerProviderStateMixin {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      curve: Curves.easeIn,
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 50,
      fadeIn: true,
    ),
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 50,
      fadeIn: true,
    ),
  };

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/BSU_APFP_logo.png',
                    width: 250,
                    height: 200,
                    fit: BoxFit.fitWidth,
                  ).animated([animationsMap['imageOnPageLoadAnimation']])
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.primaryColor,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ).animated([animationsMap['textOnPageLoadAnimation']])
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton1 = true);
                      try {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 125),
                            reverseDuration: Duration(milliseconds: 125),
                            child: LogInPageWidget(),
                          ),
                        );
                      } finally {
                        setState(() => _loadingButton1 = false);
                      }
                    },
                    text: 'Log In',
                    options: FFButtonOptions(
                      width: 150,
                      height: 50,
                      color: Color(0xFFBA0C2F),
                      textStyle: FlutterFlowTheme.subtitle2.override(
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
                    loading: _loadingButton1,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'This app is intended for members of the Adult Physical Fitness Program at Ball State University. If you do not have an account, please contact an administrator at <EMAIL>.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.primaryColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  setState(() => _loadingButton2 = true);
                  try {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 125),
                        reverseDuration: Duration(milliseconds: 125),
                        child: CreateAccountWidget(),
                      ),
                    );
                  } finally {
                    setState(() => _loadingButton2 = false);
                  }
                },
                text: 'Create Account',
                options: FFButtonOptions(
                  width: 200,
                  height: 50,
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 2,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.secondaryColor,
                    width: 3,
                  ),
                  borderRadius: 12,
                ),
                loading: _loadingButton2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
