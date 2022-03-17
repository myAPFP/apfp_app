import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:page_transition/page_transition.dart';
import '../create_account/create_account_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../log_in_page/log_in_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APFP',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(),
      home: WelcomeWidget(),
    );
  }
}

class WelcomeWidget extends StatefulWidget {
  WelcomeWidget({Key? key}) : super(key: key);

  static void returnToWelcome(BuildContext context) async {
    await Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        duration: Duration(milliseconds: 125),
        reverseDuration: Duration(milliseconds: 125),
        child: WelcomeWidget(),
      ),
    );
  }

  static void logOutToWelcome(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeWidget(),
      ),
      (r) => false,
    );
  }

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      curve: Curves.easeIn,
      trigger: AnimationTrigger.onPageLoad,
      duration: 1,
      delay: 50,
      fadeIn: true,
    ),
  };

  List<String>? adminEmails = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
    
  Future<FirebaseApp> _initFirebaseApp() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    user!.reload().then((_) => user.getIdToken(true));
    if (user.emailVerified) {
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => NavBarPage(initialPage: 0),
        ),
        (r) => false,
      );
    }
    return firebaseApp;
  }

  Widget _apfpLogo() {
    return Image.asset(
      'assets/images/BSU_APFP_logo.png',
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.3,
      fit: BoxFit.fitWidth,
    ).animated([animationsMap['imageOnPageLoadAnimation']]);
  }

  SafeArea _routeUI() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _apfpLogo(),
          _welcomeAnimated(),
          _contactText(),
          _logInButton(),
          _createAccountButton(),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  Row _showInitializingAppDialog() {
    return new Row(children: [
      CircularProgressIndicator(),
      Container(
          margin: EdgeInsets.only(left: 7), child: Text("Initializing App..."))
    ]);
  }

  SizedBox _welcomeAnimated() {
    const colorizeColors = [
      FlutterFlowTheme.primaryColor,
      FlutterFlowTheme.secondaryColor,
      FlutterFlowTheme.tertiaryColor
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Open Sans',
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText('Welcome!',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
              textAlign: TextAlign.center),
        ],
        isRepeatingAnimation: false,
      ),
    );
  }

  void getAdminEmails() {
    FireStore.getAdminEmails().then((value) {
      value.docs
        ..forEach((element) {
          adminEmails!.add(element["email"]);
        });
    });
  }

  Padding _contactText() {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: AutoSizeText.rich(
          TextSpan(
              text: 'This app is intended for members of the APFP at BSU.' +
                  ' If you are not an active member, you can contact an administrator by ',
              style: FlutterFlowTheme.subtitle1,
              children: <InlineSpan>[
                TextSpan(
                    text: '\nclicking here.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.secondaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        EmailContent email = EmailContent(
                            to: adminEmails,
                            subject: 'APFP Membership',
                            body: 'Hello, how can I become a member?');
                        OpenMailAppResult result =
                            await OpenMailApp.composeNewEmailInMailApp(
                                nativePickerTitle:
                                    'Select an email app to compose',
                                emailContent: email);

                        // If no mail apps found, show error
                        if (!result.didOpen && !result.canOpen) {
                          showNoMailAppsDialog(context);

                          // iOS: if multiple mail apps found, show dialog to select.
                          // There is no native intent/default app system in iOS so
                          // you have to do it yourself.
                        } else if (!result.didOpen && result.canOpen) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MailAppPickerDialog(
                                mailApps: result.options,
                              );
                            },
                          );
                        }
                      })
              ]),
          textAlign: TextAlign.center,
          maxLines: 6,
        ));
  }

  FFButtonWidget _logInButton() {
    return FFButtonWidget(
      key: Key("Welcome.loginButton"),
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
        width: MediaQuery.of(context).size.width * 0.4,
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
    );
  }

  FFButtonWidget _createAccountButton() {
    return FFButtonWidget(
      key: Key("Welcome.createAcctButton"),
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
        width: MediaQuery.of(context).size.width * 0.7,
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
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _initFirebaseApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                getAdminEmails();
                return _routeUI();
              }
              return Center(child: _showInitializingAppDialog());
            }),
      ),
    );
  }
}
