import 'package:apfp/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../log_in_page/log_in_page_widget.dart';
import 'package:flutter/material.dart';

class PasswordResetWidget extends StatefulWidget {
  const PasswordResetWidget({Key? key}) : super(key: key);

  @override
  _PasswordResetWidgetState createState() => _PasswordResetWidgetState();
}

class _PasswordResetWidgetState extends State<PasswordResetWidget> {
  TextEditingController? _passwordController1;
  late bool passwordVisibility1;
  TextEditingController? _passwordController2;
  late bool passwordVisibility2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _passwordController1 = TextEditingController();
    passwordVisibility1 = false;
    _passwordController2 = TextEditingController();
    passwordVisibility2 = false;
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController1!.dispose();
    _passwordController2!.dispose();
  }

  String _getPassword1() {
    return _passwordController1!.text.trim();
  }

  String _getPassword2() {
    return _passwordController2!.text.trim();
  }

  PageTransition _transitionTo(Widget child) {
    return PageTransition(
      type: PageTransitionType.leftToRight,
      duration: Duration(milliseconds: 125),
      reverseDuration: Duration(milliseconds: 125),
      child: child,
    );
  }

  Padding _backButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 25, 0, 0),
      child: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogInPageWidget()),
            );
          },
          child: Text('< Back', style: FlutterFlowTheme.subtitle2)),
    );
  }

  TextFormField _passwordTextField() {
    return TextFormField(
      controller: _passwordController1,
      obscureText: !passwordVisibility1,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
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
    );
  }

  Row _passwordRow() {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
              child: _passwordTextField()))
    ]);
  }

  TextFormField _confirmPasswordTextField() {
    return TextFormField(
      controller: _passwordController2,
      obscureText: !passwordVisibility2,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
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
    );
  }

  Row _confirmPasswordRow() {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
              child: _confirmPasswordTextField()))
    ]);
  }

  Align _resetPasswordButton() {
    return Align(
      alignment: AlignmentDirectional(-0.05, 0),
      child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
          child: FFButtonWidget(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInPageWidget(),
                  ),
                );
              },
              text: 'Reset Password',
              options: FFButtonOptions(
                  width: 200,
                  height: 50,
                  color: Color(0xFFBA0C2F),
                  textStyle: FlutterFlowTheme.title2,
                  elevation: 2,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _backButton(),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 50, 0, 0),
                  child: Text('Please enter a new password',
                      style: FlutterFlowTheme.title3)),
              _passwordRow(),
              Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 50, 0, 0),
                  child: Text('Confirm new password',
                      style: FlutterFlowTheme.title3)),
              _confirmPasswordRow(),
              _resetPasswordButton()
            ],
          ),
        ),
      ),
    );
  }
}
