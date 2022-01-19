import 'package:apfp/util/toasted/toasted.dart';
import 'package:apfp/util/validator/validator.dart';

import '/flutter_flow/flutter_flow_widgets.dart';
import '../activity_card/activity_card.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:apfp/main.dart';
import 'package:flutter/material.dart';

class AddActivityWidget extends StatefulWidget {
  AddActivityWidget({Key? key}) : super(key: key);

  @override
  _AddActivityWidgetState createState() => _AddActivityWidgetState();
}

class _AddActivityWidgetState extends State<AddActivityWidget> {
  String? exercisetype;
  TextEditingController? activityNameTextController;
  TextEditingController? totalCalTextController;
  TextEditingController? exerciseTextController;
  TextEditingController? durationTextController;
  String? duration;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    activityNameTextController = TextEditingController();
    totalCalTextController = TextEditingController();
    exerciseTextController = TextEditingController();
    durationTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    activityNameTextController!.dispose();
    totalCalTextController!.dispose();
  }

  Text _header({required String text, TextStyle? style}) {
    return Text(text, style: style);
  }

  String _getName() {
    return activityNameTextController!.text.toString().trim();
  }

  String _getExercise() {
    return exerciseTextController!.text.toString().trim();
  }

  String _getDuration() {
    return durationTextController!.text.toString().trim();
  }

  FFButtonOptions _ffButtonOptions() {
    return FFButtonOptions(
      width: 120,
      height: 50,
      color: FlutterFlowTheme.secondaryColor,
      textStyle: FlutterFlowTheme.title2,
      elevation: 2,
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
      borderRadius: 12,
    );
  }

  FFButtonWidget _submitButton() {
    return FFButtonWidget(
      key: Key("AddActivity.submitButton"),
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          if (Validator.textFieldHasValue(activityNameTextController!) &&
              Validator.textFieldHasValue(durationTextController!) &&
              Validator.textFieldHasValue(exerciseTextController!)) {
            Navigator.pop(
                context,
                ActivityCard(
                    icon: Icons.info,
                    duration: _getDuration(),
                    name: _getName(),
                    type: _getExercise()));
          } else {
            Toasted.showToast('Ensure all fields are filled');
          }
        } finally {
          setState(() => _loadingButton = false);
        }
      },
      text: 'Submit',
      options: _ffButtonOptions(),
      loading: _loadingButton,
    );
  }

  InkWell _goBackButton() {
    return InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 125),
                reverseDuration: Duration(milliseconds: 125),
                child: NavBarPage(initialPage: 3),
              ));
        },
        child: Text('< Go Back', style: FlutterFlowTheme.subtitle2));
  }

  Padding textField(TextEditingController? controller, Key key) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please provide a value";
          }
          return null;
        },
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FlutterFlowTheme.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: FlutterFlowTheme.bodyText1,
      ),
    );
  }

  Padding _activityNameTextField() {
    return textField(
        activityNameTextController, Key("AddActivity.activityNameTextField"));
  }

  Padding _totalCalTextField() {
    return textField(
        totalCalTextController, Key("AddActivity.totalCalTextField"));
  }

  Padding _exerciseTextField() {
    return textField(
        exerciseTextController, Key("AddActivity.exerciseTextField"));
  }

  Padding _durationTextField() {
    return textField(
        durationTextController, Key("AddActivity.durationTextField"));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 20),
                    child: _goBackButton(),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 0),
                      child: _header(
                          text: 'Add New Activity',
                          style: FlutterFlowTheme.title1)),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                    child: _header(
                        text: 'Name of Activity',
                        style: FlutterFlowTheme.title3),
                  ),
                  _activityNameTextField(),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                  //   child: _header(
                  //       text: 'Calories Burned',
                  //       style: FlutterFlowTheme.title3),
                  // ),
                  // _totalCalTextField(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                    child: _header(
                        text: 'Type of Exercise',
                        style: FlutterFlowTheme.title3),
                  ),
                  _exerciseTextField(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                    child: _header(
                        text: 'Duration', style: FlutterFlowTheme.title3),
                  ),
                  _durationTextField(),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                      child: _submitButton(),
                    ),
                  )
                ]),
          ))),
    );
  }
}
