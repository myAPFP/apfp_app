import '../../firebase/firestore.dart';
import '../../firebase/fire_auth.dart';

import '../../util/toasted/toasted.dart';
import '../../util/validator/validator.dart';

import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

import '../../util/internet_connection/internet.dart';

import '../../widgets/confimation_dialog/confirmation_dialog.dart';

import '../welcome/welcome_widget.dart';

import '../successful_registration/successful_registration_widget.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateAccountWidget extends StatefulWidget {
  CreateAccountWidget({Key? key}) : super(key: key);

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  /// [TextEditingController] for [_firstNameTextFormField].
  TextEditingController? _firstNameController;

  /// [TextEditingController] for [_lastNameTextFormField].
  TextEditingController? _lastNameController;

  /// [TextEditingController] for [_emailTextFormField].
  TextEditingController? _emailController;

  /// [TextEditingController] for [_passwordTextFormField].
  TextEditingController? _passwordController;

  /// [TextEditingController] for [_confirmPasswordTextFormField].
  TextEditingController? _confirmPasswordController;

  /// Controls the [CircularProgressIndicator] loading animation of a button.
  bool _loadingButton = false;

  /// Controls visisbility of characters in [_passwordTextFormField].
  late bool _passwordVisibility;

  /// Controls visisbility of characters in [_confirmPasswordTextFormField].
  late bool _confirmPasswordVisibility;

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Serves as key for the [Form] found in [build].
  ///
  /// Used to validate the current state of the [Form].
  final _formKey = GlobalKey<FormState>();

  /// Stores the id of the document associated with the user in the
  /// 'registered-users' Firestore collection.
  ///
  /// This variable will be assigned a value if a user provides valid APFP credentials
  /// and is later used to add a user's uid to their associated document
  /// within the 'registered-users' collection upon successful account creation.
  late String _docID;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisibility = false;
    _confirmPasswordController = TextEditingController();
    _confirmPasswordVisibility = false;
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController!.dispose();
    _lastNameController!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
  }

  /// Returns trimmed, lowercased text taken from [_emailController].
  String _getEmail() {
    return _emailController!.text.trim().toLowerCase();
  }

  /// Returns trimmed text taken from [_firstNameController]
  /// and [_lastNameController] and returns a string including
  /// the first and last name.
  ///
  /// Ex: John Doe
  String _getFullName() {
    final first = _firstNameController!.text.trim();
    final last = _lastNameController!.text.trim();
    return "$first $last";
  }

  /// Returns trimmed text taken from [_passwordController].
  String _getPassword() {
    return _passwordController!.text.trim();
  }

  /// Returns a [Row] in which an inner [InkWell], wrapped in a [Padding] and [Container],
  /// serves as the back button.
  ///
  /// When [InkWell]'s [onTap] is called, a call to [_returnToWelcome] is made.
  Row _backButtonRow() {
    return Row(
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
              key: Key("Create.backButton"),
              onTap: () async {
                WelcomeWidget.returnToWelcome(context);
              },
              child: Text(
                '< Back',
                style: FlutterFlowTheme.subtitle2,
              ),
            ),
          ),
        )
      ],
    );
  }

  /// Returns the header text which is displayed at the top of the
  /// create account screen.
  Padding _headerText() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text.rich(
                TextSpan(
                    text: 'Welcome to the myAPFP app.' +
                        ' Please enter the details below to create your account.',
                    style: FlutterFlowTheme.subtitle1,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '\nAPFP Membership is required to sign up.',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: FlutterFlowTheme.secondaryColor),
                      )
                    ]),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }

  /// Returns a [Row] which contains the 'First Name' label displayed
  /// above [_firstNameTextFormField].
  Row _firstNameLabel() {
    return Row(
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
            style: FlutterFlowTheme.title3,
          ),
        )
      ],
    );
  }

  /// Returns a [Padding] which contains the TextFormField used for
  /// handling first name input.
  Padding _firstNameTextFormField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(),
        alignment: AlignmentDirectional(0, 0),
        child: TextFormField(
          key: (Key("Create.firstNameTextField")),
          autofillHints: [AutofillHints.givenName],
          cursorColor: FlutterFlowTheme.secondaryColor,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please provide a value";
            }
            var firstUpperCase = value.substring(0, 1).toUpperCase();
            if (!Validator.isValidName(value)) {
              return "Please provide a valid first name";
            } else if (value.substring(0, 1) != firstUpperCase) {
              return "Please capitalize your name";
            }
            if (Validator.hasProfanity(value)) {
              // We want to allow the use of this word
              // here as it is a valid name
              if (value.trim() != 'Dick') {
                return 'Profanity is not allowed';
              }
            }
            return null;
          },
          keyboardType: TextInputType.name,
          controller: _firstNameController,
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
    );
  }

  /// Returns a [Row] which contains the 'Last Name' label displayed
  /// above [_lastNameTextFormField].
  Row _lastNameLabel() {
    return Row(
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
            style: FlutterFlowTheme.title3,
          ),
        )
      ],
    );
  }

  /// Returns a [Padding] which contains the TextFormField used for
  /// handling last name input.
  Container _lastNameTextFormField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(),
      child: TextFormField(
        key: Key("Create.lastNameTextField"),
        autofillHints: [AutofillHints.familyName],
        cursorColor: FlutterFlowTheme.secondaryColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please provide a value";
          }
          var firstUpperCase = value.substring(0, 1).toUpperCase();
          if (!Validator.isValidName(value)) {
            return "Please provide a valid last name";
          } else if (value.substring(0, 1) != firstUpperCase) {
            return "Please capitalize your name";
          }
          if (Validator.hasProfanity(value)) {
            // We want to allow the use of this word
            // here as it is a valid name
            if (value.trim() != 'Dick') {
              return 'Profanity is not allowed';
            }
          }
          return null;
        },
        keyboardType: TextInputType.name,
        controller: _lastNameController,
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
    );
  }

  /// Returns a [AutofillGroup] which wraps a [Row].
  ///
  /// This [Row] contains
  /// [_firstNameLabel], [_firstNameTextFormField], [_lastNameLabel], and
  /// [_lastNameTextFormField].
  AutofillGroup _nameRow() {
    return AutofillGroup(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_firstNameLabel(), _firstNameTextFormField()],
            ),
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_lastNameLabel(), _lastNameTextFormField()])
        ],
      ),
    );
  }

  /// Returns a padded [Row] which contains the 'Email' label displayed
  /// above [_emailTextFormField].
  Padding _emailLabel() {
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
              child: Text(
                'Email Address',
                style: FlutterFlowTheme.title3,
                key: Key("Create.emailAddressLabel"),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Returns a [Row] which contains the TextFormField used for
  /// handling email address input.
  Row _emailTextFormField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              key: Key("Create.emailTextField"),
              autofillHints: [AutofillHints.email],
              cursorColor: FlutterFlowTheme.secondaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a value";
                }
                if (!Validator.isValidEmail(value)) {
                  return "Please provide a valid email address";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'example@bsu.edu',
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
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  /// Returns a padded [Row] which contains the 'Password' label displayed
  /// above [_passwordTextFormField].
  Padding _passwordLabel() {
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
              child: Text(
                'Password',
                style: FlutterFlowTheme.title3,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Returns a [Row] which contains the TextFormField used for
  /// handling password input.
  Row _passwordTextFormField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              key: Key("Create.passwordTextField"),
              cursorColor: FlutterFlowTheme.secondaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a value";
                }
                if (!Validator.isValidPassword(value)) {
                  return "Please provide a valid password";
                }
                return null;
              },
              controller: _passwordController,
              obscureText: !_passwordVisibility,
              decoration: InputDecoration(
                  hintText: "!Password12",
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
                  suffixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(end: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            onTap: () => showPwRequirements(),
                            child: Icon(Icons.info,
                                color: FlutterFlowTheme.secondaryColor),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            key: Key("Create.pWVisibilty"),
                            onTap: () => setState(() {
                              _passwordVisibility = !_passwordVisibility;
                            }),
                            child: Icon(
                              _passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF757575),
                              size: 22,
                            ),
                          ),
                        ],
                      ))),
              style: FlutterFlowTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  /// Returns a padded [Row] which contains the 'Confirm Password' label
  /// displayed above [_confirmPasswordTextFormField].
  Padding _confirmPasswordLabel() {
    return Padding(
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
              child: Text('Confirm Password',
                  key: Key('Create.confirmPasswordLabel'),
                  style: FlutterFlowTheme.title3),
            ),
          )
        ],
      ),
    );
  }

  /// Returns a [Row] which contains the TextFormField used for
  /// handling confirmation password input.
  Row _confirmPasswordTextFormField() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 25, 0),
            child: TextFormField(
              key: Key("Create.confirmPasswordTextField"),
              cursorColor: FlutterFlowTheme.secondaryColor,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide a value";
                }
                if (value != _getPassword()) {
                  return "Passwords must match";
                }
                return null;
              },
              controller: _confirmPasswordController,
              obscureText: !_confirmPasswordVisibility,
              decoration: InputDecoration(
                hintText: "!Password12",
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
                suffixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InkWell(
                          onTap: () => showPwRequirements(),
                          child: Icon(Icons.info,
                              color: FlutterFlowTheme.secondaryColor),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          key: Key("Create.confirmPWVisibilty"),
                          onTap: () => setState(() {
                            _confirmPasswordVisibility =
                                !_confirmPasswordVisibility;
                          }),
                          child: Icon(
                            _confirmPasswordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ],
                    )),
              ),
              style: FlutterFlowTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  /// Returns a [Row] that contains icons that are used to toggle password
  /// visibility and view more info about password requirements.
  Row passwordIconRow(Function visibilityOnTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: () => setState(
            () => showPwRequirements(),
          ),
          child: Icon(Icons.info),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () => visibilityOnTap,
          child: Icon(
            _passwordVisibility
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Color(0xFF757575),
            size: 22,
          ),
        ),
      ],
    );
  }

  /// When called, an [AlertDialog] is displayed with text specifying
  /// password requirements.
  void showPwRequirements() {
    ConfirmationDialog.showConfirmationDialog(
        context: context,
        title: Text('Password Requirements'),
        content: Text(
            'Password must contain at least\n\n' +
                '- Eight characters\n' +
                '- One letter\n' +
                '- One number\n' +
                '- One special character',
            style: TextStyle(fontSize: 20)),
        cancelText: "",
        submitText: "OK",
        onCancelTap: () {},
        onSubmitTap: () => Navigator.pop(context, 'OK'));
  }

  /// Used to verify a user's APFP membership status.
  ///
  /// If the email
  /// they're attempting to sign up with is not found in the 'registered users'
  /// collection,
  ///
  /// account creation will be prohibited.
  void _verifyAPFPCredentials() async {
    if (await Internet.isConnected()) {
      if (_formKey.currentState!.validate()) {
        Toasted.showToast("Verifiying Membership...");
        FireStore.getRegisteredUser(_getEmail())
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.size != 0) {
            // Only works if there is unqiueness amongst
            // all email fields in 'registered users' firestore collection
            _docID = querySnapshot.docs.first.id;
            _createAccount();
          } else {
            Toasted.showToast(
                "You must be a member of the APFP to use this app.");
          }
        });
      }
    } else
      showSnackbar(context, "Please check your Internet connection");
  }

  /// Used to create a user's account based on their provided credentials.
  ///
  /// The user's UID is also uploaded to Firestore when the account is created.
  void _createAccount() async {
    User? user = await FireAuth.registerUsingEmailPassword(
        name: _getFullName(), email: _getEmail(), password: _getPassword());
    user?.updateDisplayName(_getFullName());
    user?.sendEmailVerification();
    if (user != null) {
      await user.reload();
      FireStore.storeUID(_docID, user.uid);
      if (user.emailVerified) {
        Toasted.showToast("Account has been verified. Please sign in.");
      } else {
        _onSuccessfulAccountCreation();
      }
    }
  }

  /// Called when a user successfully creates their account.
  /// 
  /// This will take the user to the Successful Registration screen
  /// that provides details on how to verify their email address.
  void _onSuccessfulAccountCreation() async {
    setState(() => _loadingButton = true);
    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessfulRegistrationWidget(),
        ),
      );
    } finally {
      setState(() => _loadingButton = false);
    }
  }

  /// Used to create the 'Create Account' button displayed towards the bottom
  /// of the form.
  Padding _createAccountButton() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FFButtonWidget(
            key: Key("Create.createAcctButton"),
            onPressed: () async {
              _verifyAPFPCredentials();
            },
            text: 'Create Account',
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
              borderRadius: 12,
            ),
            loading: _loadingButton,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          WelcomeWidget.returnToWelcome(context);
          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 25),
                    _backButtonRow(),
                    _headerText(),
                    _nameRow(),
                    _emailLabel(),
                    _emailTextFormField(),
                    _passwordLabel(),
                    _passwordTextFormField(),
                    _confirmPasswordLabel(),
                    _confirmPasswordTextFormField(),
                    _createAccountButton(),
                    SizedBox(height: 25)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
