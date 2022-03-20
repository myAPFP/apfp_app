import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/util/validator/validator.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
import '../../util/goals/goal.dart';
import '../../util/toasted/toasted.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AddGoalWidget extends StatefulWidget {
  AddGoalWidget({Key? key}) : super(key: key);

  static void launch(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddGoalWidget(),
      ),
    );
  }

  @override
  _AddGoalWidgetState createState() => _AddGoalWidgetState();
}

class _AddGoalWidgetState extends State<AddGoalWidget> {
  String _mode = Goal.isDailyDisplayed ? "Daily" : "Weekly";
  final weekFromNow = DateTime.now().add(const Duration(days: 7));
  bool _loadingButton = false;
  bool _isCustomGoalsDisplayed = false;
  final _exerciseFormKey = GlobalKey<FormState>();
  final _exerciseWeeklyFormKey = GlobalKey<FormState>();
  final _cyclingFormKey = GlobalKey<FormState>();
  final _cyclingWeeklyFormKey = GlobalKey<FormState>();
  final _rowingFormKey = GlobalKey<FormState>();
  final _rowingWeeklyFormKey = GlobalKey<FormState>();
  final _stepMillFormKey = GlobalKey<FormState>();
  final _stepMillWeeklyFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _caloriesFormKey = GlobalKey<FormState>();
  final _milesFormKey = GlobalKey<FormState>();
  final _stepFormKey = GlobalKey<FormState>();

  TextEditingController? _exerciseGoalController = TextEditingController();
  TextEditingController? _exerciseWeeklyGoalController =
      TextEditingController();
  TextEditingController? _cyclingGoalController = TextEditingController();
  TextEditingController? _cyclingWeeklyGoalController = TextEditingController();
  TextEditingController? _rowingGoalController = TextEditingController();
  TextEditingController? _rowingWeeklyGoalController = TextEditingController();
  TextEditingController? _stepMillGoalController = TextEditingController();
  TextEditingController? _stepMillWeeklyGoalController =
      TextEditingController();
  TextEditingController? _caloriesGoalController = TextEditingController();
  TextEditingController? _milesGoalController = TextEditingController();
  TextEditingController? _stepGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getStoredEndGoals();
  }

  @override
  void dispose() {
    super.dispose();
    _exerciseGoalController!.dispose();
    _exerciseWeeklyGoalController!.dispose();
    _cyclingGoalController!.dispose();
    _rowingGoalController!.dispose();
    _stepMillGoalController!.dispose();
    _cyclingWeeklyGoalController!.dispose();
    _rowingWeeklyGoalController!.dispose();
    _stepMillWeeklyGoalController!.dispose();
    _caloriesGoalController!.dispose();
    _milesGoalController!.dispose();
    _stepGoalController!.dispose();
  }

  void setText(MapEntry<String, dynamic> element, String fieldName,
      TextEditingController? contr) {
    if (element.key == fieldName) {
      if (element.value == 0.0) {
        contr!.text = '';
      } else {
        contr!.text = element.value.round().toString();
      }
    }
  }

  void _getStoredEndGoals() async {
    var doc = await FireStore.getHealthDocument().get();
    var docEntries = doc.data()!.entries;
    docEntries.forEach((element) {
      setText(element, 'exerciseTimeEndGoal', _exerciseGoalController);
      setText(element, 'cyclingEndGoal', _cyclingGoalController);
      setText(element, 'rowingEndGoal', _rowingGoalController);
      setText(element, 'stepMillEndGoal', _stepMillGoalController);
      setText(element, "calEndGoal", _caloriesGoalController);
      setText(element, "milesEndGoal", _milesGoalController);
      setText(element, "stepEndGoal", _stepGoalController);

      setText(element, "exerciseTimeEndGoal_w", _exerciseWeeklyGoalController);
      setText(element, "cyclingEndGoal_w", _cyclingWeeklyGoalController);
      setText(element, "rowingEndGoal_w", _rowingWeeklyGoalController);
      setText(element, "stepMillEndGoal_w", _stepMillWeeklyGoalController);
    });
  }

  Text _header({required String text, TextStyle? style}) {
    return Text(text, style: style);
  }

  InkWell _goBackButton() {
    return InkWell(
        onTap: () => Navigator.pop(context),
        child: Text('< Go Back', style: FlutterFlowTheme.subtitle2));
  }

  Padding _switchGoalViewBTN() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 40),
      child: FFButtonWidget(
        onPressed: () => setState(() {
          _isCustomGoalsDisplayed = !_isCustomGoalsDisplayed;
        }),
        text: _isCustomGoalsDisplayed
            ? 'View Regular Goals'
            : 'View Custom Goals',
        options: FFButtonOptions(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          color: FlutterFlowTheme.secondaryColor,
          textStyle: FlutterFlowTheme.title2,
          elevation: 2,
          borderSide: BorderSide(
            color: FlutterFlowTheme.secondaryColor,
          ),
          borderRadius: 8,
        ),
      ),
    );
  }

  FFButtonWidget _setGoalButton(GlobalKey<FormState> formKey, Function onTap) {
    return FFButtonWidget(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          setState(() {
            _loadingButton = true;
          });
          onTap();
          Toasted.showToast("Goal has been set");
          setState(() => _loadingButton = false);
        }
      },
      text: 'Set Goal',
      options: _ffButtonOptions(),
      loading: _loadingButton,
    );
  }

  Expanded _deleteGoalIcon({required Function onDelete}) {
    return Expanded(
        child: InkWell(
            onTap: () {
              ConfirmationDialog.showConfirmationDialog(
                  context: context,
                  title: Text('Reset Goal'),
                  content: Text('Are you sure you want to reset this goal?'),
                  onSubmitTap: () {
                    onDelete();
                    Navigator.of(context).pop();
                    Toasted.showToast("Goal has been reset");
                  },
                  onCancelTap: () => Navigator.of(context).pop(),
                  submitText: "Reset",
                  cancelText: "Back");
            },
            child: Icon(
              Icons.delete,
              size: 45,
              color: FlutterFlowTheme.secondaryColor,
            )));
  }

  FFButtonOptions _ffButtonOptions() {
    return FFButtonOptions(
      width: MediaQuery.of(context).size.width / 3,
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

  Padding _goalTextField(
      {required String hintText,
      required TextEditingController contr,
      String unitOfMeasure = "min"}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        child: new TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please provide a value";
            }
            if (!Validator.isInt(value)) {
              return "Integers (1+) only";
            }
            int minimum;
            int maximum;
            switch (unitOfMeasure) {
              case "calories":
                minimum = 100;
                maximum = 15000;
                break;
              case "steps":
                minimum = 100;
                maximum = 15000;
                break;
              case "miles":
                minimum = 1;
                maximum = 30;
                break;
              default:
                minimum = 10;
                maximum = 180;
            }
            if (double.parse(value) < minimum) {
              return "$minimum $unitOfMeasure is minimum";
            }
            if (double.parse(value) > maximum) {
              return "$maximum $unitOfMeasure is max limit";
            }
            return null;
          },
          controller: contr,
          obscureText: false,
          decoration: InputDecoration(
            hintText: hintText,
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

  List<Widget> _dailyGoalsUI() {
    return !_isCustomGoalsDisplayed
        ? [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child: _header(
                  text: 'Exercise Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _exerciseFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Total Minutes",
                      contr: _exerciseGoalController!),
                  _setGoalButton(_exerciseFormKey, () async {
                    await FireStore.updateHealthData({
                      "exerciseTimeEndGoal": double.parse(
                          _exerciseGoalController!.text.toString()),
                      "isExerciseTimeGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData({
                      "exerciseTimeEndGoal": 0.0,
                      "isExerciseTimeGoalSet": false
                    }).then((value) {
                      _exerciseGoalController!.text = '';
                    });
                  })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child: _header(
                  text: 'Calories Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _caloriesFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Calories",
                      contr: _caloriesGoalController!,
                      unitOfMeasure: "calories"),
                  _setGoalButton(_caloriesFormKey, () async {
                    await FireStore.updateHealthData({
                      "calEndGoal": double.parse(
                          _caloriesGoalController!.text.toString()),
                      "isCalGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData(
                            {"calEndGoal": 0.0, "isCalGoalSet": false})
                        .then((value) {
                      _caloriesGoalController!.text = '';
                    });
                  })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child:
                  _header(text: 'Miles Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _milesFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Miles",
                      contr: _milesGoalController!,
                      unitOfMeasure: "miles"),
                  _setGoalButton(_milesFormKey, () async {
                    await FireStore.updateHealthData({
                      "mileEndGoal":
                          double.parse(_milesGoalController!.text.toString()),
                      "isMileGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData(
                            {"mileEndGoal": 0.0, "isMileGoalSet": false})
                        .then((value) {
                      _milesGoalController!.text = '';
                    });
                  })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child:
                  _header(text: 'Steps Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _stepFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Steps",
                      contr: _stepGoalController!,
                      unitOfMeasure: "steps"),
                  _setGoalButton(_stepFormKey, () async {
                    await FireStore.updateHealthData({
                      "stepEndGoal":
                          double.parse(_stepGoalController!.text.toString()),
                      "isStepGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData(
                            {"stepEndGoal": 0.0, "isStepGoalSet": false})
                        .then((value) {
                      _stepGoalController!.text = '';
                    });
                  })
                ],
              ),
            )
          ]
        : [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child:
                  _header(text: 'Cycling Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _cyclingFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Total Minutes",
                      contr: _cyclingGoalController!),
                  _setGoalButton(_cyclingFormKey, () async {
                    await FireStore.updateHealthData({
                      "cyclingEndGoal":
                          double.parse(_cyclingGoalController!.text.toString()),
                      "isCyclingGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData(
                            {"cyclingEndGoal": 0, "isCyclingGoalSet": false})
                        .then((value) {
                      _cyclingGoalController!.text = '';
                    });
                  })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child:
                  _header(text: 'Rowing Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _rowingFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Total Minutes", contr: _rowingGoalController!),
                  _setGoalButton(_rowingFormKey, () async {
                    await FireStore.updateHealthData({
                      "rowingEndGoal":
                          double.parse(_rowingGoalController!.text.toString()),
                      "isRowingGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData(
                            {"rowingEndGoal": 0, "isRowingGoalSet": false})
                        .then((value) {
                      _rowingGoalController!.text = '';
                    });
                  })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
              child: _header(
                  text: 'Step Mill Goal', style: FlutterFlowTheme.title3),
            ),
            Form(
              key: _stepMillFormKey,
              child: Row(
                children: [
                  _goalTextField(
                      hintText: "Total Minutes",
                      contr: _stepMillGoalController!),
                  _setGoalButton(_stepMillFormKey, () async {
                    await FireStore.updateHealthData({
                      "stepMillEndGoal": double.parse(
                          _stepMillGoalController!.text.toString()),
                      "isStepMillGoalSet": true
                    });
                  }),
                  _deleteGoalIcon(onDelete: () async {
                    await FireStore.updateHealthData(
                            {"stepMillEndGoal": 0, "isStepMillGoalSet": false})
                        .then((value) {
                      _stepMillGoalController!.text = '';
                    });
                  })
                ],
              ),
            ),
          ];
  }

  List<Widget> _weeklyGoalsUI() {
    return [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
        child: _header(text: 'Exercise Goal', style: FlutterFlowTheme.title3),
      ),
      Form(
        key: _exerciseWeeklyFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes",
                contr: _exerciseWeeklyGoalController!),
            _setGoalButton(_exerciseWeeklyFormKey, () async {
              await FireStore.updateHealthData({
                "exerciseWeekDeadline":
                    "${weekFromNow.month}/${weekFromNow.day}/${weekFromNow.year}",
                "exerciseTimeEndGoal_w": double.parse(
                    _exerciseWeeklyGoalController!.text.toString()),
                "isExerciseTimeGoalSet_w": true
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({
                "exerciseWeekDeadline": "0/00/0000",
                "exerciseTimeGoalProgressWeekly": 0,
                "exerciseTimeEndGoal_w": 0,
                "isExerciseTimeGoalSet_w": false
              }).then((value) {
                _exerciseWeeklyGoalController!.text = '';
              });
            })
          ],
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
        child: _header(text: 'Cycling Goal', style: FlutterFlowTheme.title3),
      ),
      Form(
        key: _cyclingWeeklyFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes",
                contr: _cyclingWeeklyGoalController!),
            _setGoalButton(_cyclingWeeklyFormKey, () async {
              await FireStore.updateHealthData({
                "cyclingWeekDeadline":
                    "${weekFromNow.month}/${weekFromNow.day}/${weekFromNow.year}",
                "cyclingEndGoal_w":
                    double.parse(_cyclingWeeklyGoalController!.text.toString()),
                "isCyclingGoalSet_w": true
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({
                "cyclingWeekDeadline": "0/00/0000",
                "cyclingGoalProgressWeekly": 0,
                "cyclingEndGoal_w": 0,
                "isCyclingGoalSet_w": false
              }).then((value) {
                _cyclingWeeklyGoalController!.text = '';
              });
            })
          ],
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
        child: _header(text: 'Rowing Goal', style: FlutterFlowTheme.title3),
      ),
      Form(
        key: _rowingWeeklyFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes", contr: _rowingWeeklyGoalController!),
            _setGoalButton(_rowingWeeklyFormKey, () async {
              await FireStore.updateHealthData({
                "rowingWeekDeadline":
                    "${weekFromNow.month}/${weekFromNow.day}/${weekFromNow.year}",
                "rowingEndGoal_w":
                    double.parse(_rowingWeeklyGoalController!.text.toString()),
                "isRowingGoalSet_w": true
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({
                "rowingWeekDeadline": "0/00/0000",
                "rowingGoalProgressWeekly": 0,
                "rowingEndGoal_w": 0,
                "isRowingGoalSet_w": false
              }).then((value) {
                _rowingWeeklyGoalController!.text = '';
              });
            })
          ],
        ),
      ),
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
        child: _header(text: 'Step Mill Goal', style: FlutterFlowTheme.title3),
      ),
      Form(
        key: _stepMillWeeklyFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes",
                contr: _stepMillWeeklyGoalController!),
            _setGoalButton(_stepMillWeeklyFormKey, () async {
              await FireStore.updateHealthData({
                "stepMillWeekDeadline":
                    "${weekFromNow.month}/${weekFromNow.day}/${weekFromNow.year}",
                "stepMillEndGoal_w": double.parse(
                    _stepMillWeeklyGoalController!.text.toString()),
                "isStepMillGoalSet_w": true
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({
                "stepMillWeekDeadline": "0/00/0000",
                "stepMillGoalProgressWeekly": 0,
                "stepMillEndGoal_w": 0,
                "isStepMillGoalSet_w": false
              }).then((value) {
                _stepMillWeeklyGoalController!.text = '';
              });
            })
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            backgroundColor: FlutterFlowTheme.secondaryColor,
            child: _mode == "Daily"
                ? Text("W", style: TextStyle(fontSize: 25))
                : Text("D", style: TextStyle(fontSize: 25)),
            onPressed: () async {
              switch (_mode) {
                case "Daily":
                  setState(() => _mode = "Weekly");
                  break;
                case "Weekly":
                  setState(() => _mode = "Daily");
                  break;
              }
            },
          ),
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
                          text: '$_mode Goals',
                          style: FlutterFlowTheme.title1)),
                  Column(
                    children:
                        _mode == "Daily" ? _dailyGoalsUI() : _weeklyGoalsUI(),
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _switchGoalViewBTN(),
                    ],
                  )
                ]),
          ))),
    );
  }
}
