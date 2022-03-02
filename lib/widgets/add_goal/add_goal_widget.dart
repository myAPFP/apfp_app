import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/flutter_flow/flutter_flow_util.dart';
import 'package:apfp/util/validator/validator.dart';
import 'package:apfp/widgets/confimation_dialog/confirmation_dialog.dart';
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
  final _rowingFormKey = GlobalKey<FormState>();
  final _stepMillFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? exerciseGoalController = TextEditingController();
  TextEditingController? exerciseWeeklyGoalController = TextEditingController();
  TextEditingController? cyclingGoalController = TextEditingController();
  TextEditingController? rowingGoalController = TextEditingController();
  TextEditingController? stepMillGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getStoredEndGoals();
  }

  @override
  void dispose() {
    super.dispose();
    exerciseGoalController!.dispose();
    exerciseWeeklyGoalController!.dispose();
    cyclingGoalController!.dispose();
    rowingGoalController!.dispose();
    stepMillGoalController!.dispose();
  }

  void setText(MapEntry<String, dynamic> element, String fieldName,
      TextEditingController? controller) {
    if (element.key == fieldName) {
      if (element.value == 0.0) {
        controller!.text = '';
      } else {
        controller!.text = element.value.round().toString();
      }
    }
  }

  void _getStoredEndGoals() async {
    var doc = await FireStore.getHealthDocument().get();
    var docEntries = doc.data()!.entries;
    docEntries.forEach((element) {
      setText(element, 'exerciseTimeEndGoal', exerciseGoalController);
      setText(element, 'cyclingEndGoal', cyclingGoalController);
      setText(element, 'rowingEndGoal', rowingGoalController);
      setText(element, 'stepMillEndGoal', stepMillGoalController);
      setText(element, "exerciseTimeEndGoal_w", exerciseWeeklyGoalController);
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
          showSnackbar(context, "Goal has been set");
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
                    showSnackbar(context, "Goal has been reset");
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

  Padding _goalTextField(String hintText, TextEditingController controller) {
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
          controller: controller,
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
            _goalTextField("Total Minutes", exerciseGoalController!),
            _setGoalButton(_exerciseFormKey, () async {
              await FireStore.updateHealthData(
                      FireStore.exerciseTimeEndGoalToMap(double.parse(
                          exerciseGoalController!.text.toString())))
                  .then((value) {
                FireStore.updateHealthData(
                    FireStore.exerciseGoalBoolToMap(true));
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData(
                      FireStore.exerciseTimeEndGoalToMap(0.0))
                  .then((value) {
                FireStore.updateHealthData(
                    FireStore.exerciseGoalBoolToMap(false));
                exerciseGoalController!.text = '';
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
            _goalTextField("Total Minutes", cyclingGoalController!),
            _setGoalButton(_cyclingFormKey, () async {
              await FireStore.updateHealthData({
                "cyclingEndGoal":
                    double.parse(cyclingGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isCyclingGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"cyclingEndGoal": 0})
                  .then((value) {
                FireStore.updateHealthData({"isCyclingGoalSet": false});
                cyclingGoalController!.text = '';
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
            _goalTextField("Total Minutes", rowingGoalController!),
            _setGoalButton(_rowingFormKey, () async {
              await FireStore.updateHealthData({
                "rowingEndGoal":
                    double.parse(rowingGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isRowingGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"rowingEndGoal": 0})
                  .then((value) {
                FireStore.updateHealthData({"isRowingGoalSet": false});
                rowingGoalController!.text = '';
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
            _goalTextField("Total Minutes", stepMillGoalController!),
            _setGoalButton(_stepMillFormKey, () async {
              await FireStore.updateHealthData({
                "stepMillEndGoal":
                    double.parse(stepMillGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isStepMillGoalSet": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"stepMillEndGoal": 0})
                  .then((value) {
                FireStore.updateHealthData({"isStepMillGoalSet": false});
                stepMillGoalController!.text = '';
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
            _goalTextField("Total Minutes", exerciseWeeklyGoalController!),
            _setGoalButton(_exerciseWeeklyFormKey, () async {
              await FireStore.updateHealthData({
                "exerciseTimeEndGoal_w":
                    double.parse(exerciseWeeklyGoalController!.text.toString())
              }).then((value) {
                FireStore.updateHealthData({"isExerciseTimeGoalSet_w": true});
              });
            }),
            _deleteGoalIcon(onDelete: () async {
              await FireStore.updateHealthData({"exerciseTimeEndGoal_w": 0})
                  .then((value) {
                FireStore.updateHealthData({"isExerciseTimeGoalSet_w": false});
                exerciseWeeklyGoalController!.text = '';
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
