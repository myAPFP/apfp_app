import 'package:apfp/util/validator/validator.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../util/goals/other_goal.dart';
import '../../util/goals/exercise_time_goal.dart';
import '../../util/goals/goal.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../activity_card/activity_card.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AddActivityWidget extends StatefulWidget {
  AddActivityWidget({Key? key}) : super(key: key);

  @override
  _AddActivityWidgetState createState() => _AddActivityWidgetState();
}

class _AddActivityWidgetState extends State<AddActivityWidget> {
  String? duration;
  String? unitOfTime = 'Minutes';
  String? exercisetype = 'Cardio';
  String? OtherGoalName = "";

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

  TextEditingController? activityNameTextController;
  TextEditingController? exerciseTextController;
  TextEditingController? durationTextController;

  bool _loadingButton = false;

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    activityNameTextController = TextEditingController();
    exerciseTextController = TextEditingController();
    durationTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    activityNameTextController!.dispose();
    exerciseTextController!.dispose();
    durationTextController!.dispose();
  }

  Text _header({required String text, TextStyle? style}) {
    return Text(text, style: style);
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
                    type: exercisetype,
                    timestamp: DateTime.now().toIso8601String()));
            var activitySnapShot = {
              DateTime.now().toIso8601String(): [name, exercisetype, duration]
            };

            Goal.userProgressCyclingGoalWeekly +=
                OtherGoal.calcGoalSums(activitySnapShot, goalType: "Cycling");

            Goal.userProgressRowingGoalWeekly +=
                OtherGoal.calcGoalSums(activitySnapShot, goalType: "Rowing");

            Goal.userProgressStepMillGoalWeekly += OtherGoal.calcGoalSums(
                activitySnapShot,
                goalType: "Step-Mill");

            Goal.userProgressEllipticalGoalWeekly += OtherGoal.calcGoalSums(
                activitySnapShot,
                goalType: "Elliptical");

            Goal.userProgressResistanceStrengthGoalWeekly +=
                OtherGoal.calcGoalSums(activitySnapShot,
                    goalType: "Resistance");

            Goal.userProgressExerciseTimeWeekly +=
                ExerciseGoal.totalTimeInMinutes(activitySnapShot);
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
        onTap: () => Navigator.pop(context),
        child: Text('< Go Back', style: FlutterFlowTheme.subtitle2));
  }

  bool _noRadioButtonSelected() {
    return (OtherGoalName != "Cycling" &&
        OtherGoalName != "Rowing" &&
        OtherGoalName != "Step Mill");
  }

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
              if (!Validator.isValidActivity(value)) {
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

  Column _OtherGoalRadioButtons() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Cycling'),
          leading: Radio(
            toggleable: true,
            value: 'Cycling',
            groupValue: OtherGoalName,
            onChanged: (value) {
              setState(() {
                OtherGoalName = value.toString();
                activityNameTextController!.text =
                    OtherGoalName != "null" ? OtherGoalName! : "";
                exercisetype = 'Aerobic';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Rowing'),
          leading: Radio(
            toggleable: true,
            value: 'Rowing',
            groupValue: OtherGoalName,
            onChanged: (value) {
              setState(() {
                OtherGoalName = value.toString();
                activityNameTextController!.text =
                    OtherGoalName != "null" ? OtherGoalName! : "";
                exercisetype = 'Total-Body';
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Step Mill'),
          leading: Radio(
            toggleable: true,
            value: 'Step Mill',
            groupValue: OtherGoalName,
            onChanged: (value) {
              setState(() {
                OtherGoalName = value.toString();
                activityNameTextController!.text =
                    OtherGoalName != "null" ? OtherGoalName! : "";
                exercisetype = 'Aerobic';
              });
            },
          ),
        )
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _header(
                          text: 'Type of Exercise',
                          style: FlutterFlowTheme.title3),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                        child: FlutterFlowDropDown(
                          initialOption: exercisetype,
                          options: _noRadioButtonSelected()
                              ? exerciseTypes
                              : [exercisetype!],
                          onChanged: (val) =>
                              setState(() => exercisetype = val),
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
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _header(
                          text: 'Duration', style: FlutterFlowTheme.title3),
                    ),
                    Row(
                      children: [
                        _durationTextField(),
                        FlutterFlowDropDown(
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
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
                      child: _header(
                          text: 'Other Activities',
                          style: FlutterFlowTheme.title3),
                    ),
                    _OtherGoalRadioButtons(),
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
