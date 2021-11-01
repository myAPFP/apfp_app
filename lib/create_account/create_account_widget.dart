import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../successful_registration/successful_registration_widget.dart';
import '../welcome/welcome_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountWidget extends StatefulWidget {
  CreateAccountWidget({Key key}) : super(key: key);

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  bool passwordVisibility1;
  TextEditingController textController5;
  bool passwordVisibility2;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    passwordVisibility1 = false;
    textController5 = TextEditingController();
    passwordVisibility2 = false;
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.tertiaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            duration: Duration(milliseconds: 125),
                            reverseDuration: Duration(milliseconds: 125),
                            child: WelcomeWidget(),
                          ),
                        );
                      },
                      child: Text(
                        '< Back',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      'Welcome to the Adult Physical Fitness Program at Ball State University! Please enter the details below to create your account.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.title2.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Text(
                              'First Name',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Open Sans',
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(),
                          alignment: AlignmentDirectional(0, 0),
                          child: TextFormField(
                            controller: textController1,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'John',
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
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Text(
                            'Last Name',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: textController2,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Doe',
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
                      ),
                    )
                  ],
                )
              ],
            ),
            Padding(
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
                      child: Text(
                        'Email Address',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
                    child: TextFormField(
                      controller: textController3,
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
                    ),
                  ),
                )
              ],
            ),
            Padding(
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
                      child: Text(
                        'Password',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
                    child: TextFormField(
                      controller: textController4,
                      obscureText: !passwordVisibility1,
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
                            () => passwordVisibility1 = !passwordVisibility1,
                          ),
                          child: Icon(
                            passwordVisibility1
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
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        'Confirm Password',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Open Sans',
                          color: FlutterFlowTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
                    child: TextFormField(
                      controller: textController5,
                      obscureText: !passwordVisibility2,
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
                            () => passwordVisibility2 = !passwordVisibility2,
                          ),
                          child: Icon(
                            passwordVisibility2
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
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
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
                          MaterialPageRoute(
                            builder: (context) =>
                                SuccessfulRegistrationWidget(),
                          ),
                        );
                      } finally {
                        setState(() => _loadingButton = false);
                      }
                    },
                    text: 'Create Account',
                    options: FFButtonOptions(
                      width: 200,
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
