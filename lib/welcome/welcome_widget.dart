import '../create_account/create_account_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../log_in_page/log_in_page_widget.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatefulWidget {
  WelcomeWidget({Key key}) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget>
    with TickerProviderStateMixin {
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
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/images/BSU_APFP_logo.png',
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                fit: BoxFit.fitWidth,
              ).animated([animationsMap['imageOnPageLoadAnimation']]),
              Text(
                'Welcome!',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Open Sans',
                  color: FlutterFlowTheme.primaryColor,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ).animated([animationsMap['textOnPageLoadAnimation']]),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInPageWidget(),
                      ),
                      (r) => false,
                    );
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
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountWidget(),
                      ),
                      (r) => false,
                    );
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}