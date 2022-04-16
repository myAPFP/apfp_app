// Copyright 2022 The myAPFP Authors. All rights reserved.

import '/util/validator/validator.dart';

import '../activity_card/activity_card.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';

import 'package:flutter/material.dart';

class AddActivityWidget extends StatefulWidget {
  AddActivityWidget({Key? key}) : super(key: key);

  @override
  _AddActivityWidgetState createState() => _AddActivityWidgetState();
}

class _AddActivityWidgetState extends State<AddActivityWidget> {
  /// Activity duration's unit of time. Set to 'Minutes' by default.
  ///
  /// Possible values:
  /// - Seconds
  /// - Minute
  /// - Minutes
  /// - Hour
  /// - Hours
  String? unitOfTime = 'Minutes';

  /// Activity's exercise type. Set to 'Cardio' by default.
  ///
  /// Possible values are included in the [exerciseTypes] list.
  String? _exerciseType = 'Cardio';

  /// Holds the value of the currently selected radio button.
  String? _radioButtonValue = "";

  /// A list of exercise types a user can choose from.
  List<String> exerciseTypes = [
    "Aerobic",
    'Body-Composition',
    'Cardio',
    'Endurance',
    'Flexibility',
    'Kinesthetic',
    'Speed',
    'Resistance-Strength',
    "Total-Body"
  ];

  /// [TextEditingController] for [_durationTextField].
  TextEditingController? durationTextController;

  /// [TextEditingController] for [_activityNameTextField].
  TextEditingController? activityNameTextController;

  /// Controls the [CircularProgressIndicator] loading animation of a button.
  bool _loadingButton = false;

  /// Serves as key for the [Form] found in [build].
  ///
  /// Used to validate the current state of the [Form].
  final _formKey = GlobalKey<FormState>();

  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    activityNameTextController = TextEditingController();
    durationTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    activityNameTextController!.dispose();
    durationTextController!.dispose();
  }

  /// Creates a label.
  Text _label({required String text, TextStyle? style}) {
    return Text(text, style: style);
  }

  /// Gets text from [durationTextController].
  String _getDuration() {
    return durationTextController!.text.toString().trim();
  }

  /// Options to be used with the [_submitButton].
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

  /// Validates all user input and creates an Activity Card to be displayed.
  FFButtonWidget _submitButton() {
    return FFButtonWidget(
      key: Key("AddActivity.submitButton"),
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          if (_formKey.currentState!.validate()) {
            String name = activityNameTextController!.text
                .toString()
                .trim()
                .replaceAll(RegExp(' +'), '-');
            String duration = '${_getDuration()} $unitOfTime';
            Navigator.pop(
                context,
                ActivityCard(
                    icon: Icons.info,
                    duration: duration,
                    name: name,
                    type: _exerciseType,
                    timestamp: DateTime.now().toIso8601String()));
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

  /// When pressed, the user is taken back to My Activity.
  InkWell _goBackButton() {
    return InkWell(
        onTap: () => Navigator.pop(context),
        child: Text('< Go Back', style: FlutterFlowTheme.subtitle2));
  }

  /// Returns true if there are no 'Other Activities' radio buttons selected.
  bool _noRadioButtonSelected() {
    return (_radioButtonValue != "Cycling" &&
        _radioButtonValue != "Rowing" &&
        _radioButtonValue != "Step Mill" &&
        _radioButtonValue != "Elliptical" &&
        _radioButtonValue != "Resistance");
  }

  /// Returns a [Padding] which contains the TextFormField used for
  /// handling activity name input.
  Padding _activityNameTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          enabled: _noRadioButtonSelected(),
          key: Key("AddActivity.activityNameTextField"),
          validator: (value) {
            if (_noRadioButtonSelected()) {
              if (value == null || value.isEmpty) {
                return "Please provide a value";
              }
              if (value.length > 15) {
                return "15 character max limit. Current count: ${value.length}";
              }
              if (!Validator.isValidActivityName(value)) {
                return 'Alphabet letters only';
              }
              if (Validator.hasProfanity(value)) {
                return 'Profanity is not allowed';
              }
            }
            return null;
          },
          controller: activityNameTextController,
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
      ),
    );
  }

  /// Returns a [Padding] which contains the TextFormField used for
  /// handling activity duration input.
  Padding _durationTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: TextFormField(
          key: Key("AddActivity.durationTextField"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please provide a value";
            }
            if (!Validator.isInt(value)) {
              return 'Whole numbers (1+) only';
            }
            int minLimit = 0;
            int maxLimit = 0;
            switch (unitOfTime) {
              case 'Seconds':
                minLimit = 30;
                maxLimit = 59;
                break;
              case 'Hours':
                maxLimit = 3;
                break;
              default:
                maxLimit = 59;
                break;
            }
            if (int.parse(value) < minLimit) {
              return '$minLimit ${unitOfTime!.toLowerCase()} is min limit';
            }
            if (int.parse(value) == 1) {
              switch (unitOfTime) {
                case 'Minutes':
                  unitOfTime = 'Minute';
                  break;
                case 'Hours':
                  unitOfTime = 'Hour';
                  break;
              }
            }
            if (int.parse(value) > maxLimit) {
              return '$maxLimit ${unitOfTime!.toLowerCase()} is max limit';
            }
            return null;
          },
          controller: durationTextController,
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
      ),
    );
  }

  /// Dropdown used for selecting a unit of time.
  FlutterFlowDropDown _unitOfTimeDropDown() {
    return FlutterFlowDropDown(
      initialOption: 'Minutes',
      options: ['Seconds', 'Minutes', 'Hours'],
      onChanged: (val) => setState(() => unitOfTime = val),
      width: MediaQuery.of(context).size.width * .55,
      height: 50,
      textStyle: FlutterFlowTheme.bodyText1,
      fillColor: Colors.white,
      elevation: 2,
      borderColor: FlutterFlowTheme.primaryColor,
      borderWidth: 0,
      borderRadius: 10,
      margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
      hidesUnderline: true,
    );
  }

  /// Dropdown used for selecting an exercise type.
  FlutterFlowDropDown _exerciseTypeDropDown() {
    return FlutterFlowDropDown(
      initialOption: _exerciseType,
      options: _noRadioButtonSelected() ? exerciseTypes : [_exerciseType!],
      onChanged: (val) => setState(() => _exerciseType = val),
      width: MediaQuery.of(context).size.width,
      height: 50,
      textStyle: FlutterFlowTheme.bodyText1,
      fillColor: Colors.white,
      elevation: 2,
      borderColor: FlutterFlowTheme.primaryColor,
      borderWidth: 0,
      borderRadius: 10,
      margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
      hidesUnderline: true,
    );
  }

  /// Creates a radio button.
  ///
  /// [exerciseType] will be used to populate the 'Type of Exercise' dropdown.
  Row _radioButton({required String title, required String exerciseType}) {
    return Row(
      children: [
        Radio(
          toggleable: true,
          value: title,
          groupValue: _radioButtonValue,
          onChanged: (v) {
            setState(() {
              _radioButtonValue = v.toString();
              activityNameTextController!.text =
                  _radioButtonValue != "null" ? _radioButtonValue! : "";
              _exerciseType = exerciseType;
            });
          },
        ),
        Expanded(child: Text(title, style: FlutterFlowTheme.bodyText1))
      ],
    );
  }

  /// Returns a column of 'Other Activities' radio buttons.
  Column _otherActivityRadioButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: _radioButton(title: 'Cycling', exerciseType: 'Aerobic'),
              flex: 1,
            ),
            Expanded(
              child: _radioButton(title: 'Rowing', exerciseType: 'Total-Body'),
              flex: 1,
            ),
            Expanded(
              child: _radioButton(title: 'Step Mill', exerciseType: 'Aerobic'),
              flex: 1,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _radioButton(title: 'Elliptical', exerciseType: 'Aerobic'),
            ),
            Expanded(
              flex: 1,
              child: _radioButton(title: 'Resistance', exerciseType: 'Aerobic'),
            ),
          ],
        ),
      ],
    );
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
            child: Form(
              key: _formKey,
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
                        child: _label(
                            text: 'Add New Activity',
                            style: FlutterFlowTheme.title1)),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _label(
                          text: 'Name of Activity',
                          style: FlutterFlowTheme.title3),
                    ),
                    _activityNameTextField(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _label(
                          text: 'Type of Exercise',
                          style: FlutterFlowTheme.title3),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                        child: _exerciseTypeDropDown()),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _label(
                          text: 'Duration', style: FlutterFlowTheme.title3),
                    ),
                    Row(
                      children: [_durationTextField(), _unitOfTimeDropDown()],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _label(
                          text: 'Other Activities',
                          style: FlutterFlowTheme.title3),
                    ),
                    _otherActivityRadioButtons(),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                        child: _submitButton(),
                      ),
                    )
                  ]),
            ),
          ))),
    );
  }
}
