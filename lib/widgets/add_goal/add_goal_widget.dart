import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/flutter_flow/flutter_flow_util.dart';
import 'package:apfp/util/validator/validator.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
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
  String mode = "Daily";
  bool _loadingButton = false;
  final _exerciseFormKey = GlobalKey<FormState>();
  final _exerciseWeeklyFormKey = GlobalKey<FormState>();
  final _cyclingFormKey = GlobalKey<FormState>();
  final _cyclingWeeklyFormKey = GlobalKey<FormState>();
  final _rowingFormKey = GlobalKey<FormState>();
  final _rowingWeeklyFormKey = GlobalKey<FormState>();
  final _stepMillFormKey = GlobalKey<FormState>();
  final _stepMillWeeklyFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
      {required String hintText, required TextEditingController contr}) {
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
            if (double.parse(value) < 10) {
              return "Goal must be at least 10 min";
            }
            if (double.parse(value) > 180) {
              return "180 min is max limit";
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
    return [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
        child: _header(text: 'Exercise Goal', style: FlutterFlowTheme.title3),
      ),
      Form(
        key: _exerciseFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes", contr: _exerciseGoalController!),
            _setGoalButton(_exerciseFormKey, () async {
              await FireStore.updateHealthData({
                "exerciseTimeEndGoal":
                    double.parse(_exerciseGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isExerciseTimeGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"exerciseTimeEndGoal": 0.0})
                  .then((value) {
                FireStore.updateHealthData({"isExerciseTimeGoalSet": false});
                _exerciseGoalController!.text = '';
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
        key: _cyclingFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes", contr: _cyclingGoalController!),
            _setGoalButton(_cyclingFormKey, () async {
              await FireStore.updateHealthData({
                "cyclingEndGoal":
                    double.parse(_cyclingGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isCyclingGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"cyclingEndGoal": 0})
                  .then((value) {
                FireStore.updateHealthData({"isCyclingGoalSet": false});
                _cyclingGoalController!.text = '';
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
        key: _rowingFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes", contr: _rowingGoalController!),
            _setGoalButton(_rowingFormKey, () async {
              await FireStore.updateHealthData({
                "rowingEndGoal":
                    double.parse(_rowingGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isRowingGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"rowingEndGoal": 0})
                  .then((value) {
                FireStore.updateHealthData({"isRowingGoalSet": false});
                _rowingGoalController!.text = '';
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
        key: _stepMillFormKey,
        child: Row(
          children: [
            _goalTextField(
                hintText: "Total Minutes", contr: _stepMillGoalController!),
            _setGoalButton(_stepMillFormKey, () async {
              await FireStore.updateHealthData({
                "stepMillEndGoal":
                    double.parse(_stepMillGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isStepMillGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"stepMillEndGoal": 0})
                  .then((value) {
                FireStore.updateHealthData({"isStepMillGoalSet": false});
                _stepMillGoalController!.text = '';
              });
            })
          ],
        ),
      )
    ];
  }

  List<Widget> _weeklyGoalUI() {
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
                "exerciseTimeEndGoal_w":
                    double.parse(_exerciseWeeklyGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isExerciseTimeGoalSet_w": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"exerciseTimeEndGoal_w": 0})
                  .then((value) {
                FireStore.updateHealthData({"isExerciseTimeGoalSet_w": false});
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
                "cyclingEndGoal_w":
                    double.parse(_cyclingWeeklyGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isCyclingGoalSet_w": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"cyclingEndGoal_w": 0})
                  .then((value) {
                FireStore.updateHealthData({"isCyclingGoalSet_w": false});
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
                "rowingEndGoal_w":
                    double.parse(_rowingWeeklyGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isRowingGoalSet_w": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"rowingEndGoal_w": 0})
                  .then((value) {
                FireStore.updateHealthData({"isRowingGoalSet_w": false});
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
                "stepMillEndGoal_w":
                    double.parse(_stepMillWeeklyGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isStepMillGoalSet_w": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"stepMillEndGoal_w": 0})
                  .then((value) {
                FireStore.updateHealthData({"isStepMillGoalSet_w": false});
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
            child: Icon(Icons.code),
            onPressed: () async {
              switch (mode) {
                case "Daily":
                  setState(() => mode = "Weekly");
                  break;
                case "Weekly":
                  setState(() => mode = "Daily");
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
                          text: '$mode Goals', style: FlutterFlowTheme.title1)),
                  Column(
                    children:
                        mode == "Daily" ? _dailyGoalsUI() : _weeklyGoalUI(),
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ]),
          ))),
    );
  }
}
