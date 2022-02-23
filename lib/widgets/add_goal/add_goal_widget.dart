import 'package:apfp/firebase/firestore.dart';
import 'package:apfp/util/toasted/toasted.dart';
import 'package:apfp/util/validator/validator.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AddGoalWidget extends StatefulWidget {
  AddGoalWidget({
    Key? key,
  }) : super(key: key);

  @override
  _AddGoalWidgetState createState() => _AddGoalWidgetState();
}

class _AddGoalWidgetState extends State<AddGoalWidget> {
  bool _loadingButton = false;
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? exerciseGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getStoredEndGoals();
  }

  @override
  void dispose() {
    super.dispose();
    exerciseGoalController!.dispose();
  }

  void _getStoredEndGoals() async {
    var doc = await FireStore.getHealthDocument().get();
    var docEntries = doc.data()!.entries;
    docEntries.forEach((element) {
      if (element.key == "exerciseTimeEndGoal") {
        if (element.value == 0.0) {
          exerciseGoalController!.text = '';
        } else {
          exerciseGoalController!.text = element.value.round().toString();
        }
      }
    });
  }

  Text _header({required String text, TextStyle? style}) {
    return Text(text, style: style);
  }

  double _getExerciseEndGoal() {
    return double.parse(exerciseGoalController!.text.toString());
  }

  FFButtonWidget _setExerciseGoalButton() {
    return FFButtonWidget(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          setState(() {
            _loadingButton = true;
          });
          await FireStore.updateHealthData(
                  FireStore.exerciseTimeEndGoalToMap(_getExerciseEndGoal()))
              .then((value) {
            FireStore.updateHealthData(FireStore.exerciseGoalBoolToMap(true));
            Toasted.showToast("Goal has been set");
            setState(() => _loadingButton = false);
          });
        }
      },
      text: 'Set Goal',
      options: _ffButtonOptions(),
      loading: _loadingButton,
    );
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

  InkWell _goBackButton() {
    return InkWell(
        onTap: () => Navigator.pop(context),
        child: Text('< Go Back', style: FlutterFlowTheme.subtitle2));
  }

  Padding _exerciseGoalTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        child: TextFormField(
          validator: (value) {
            if (!Validator.isInt(value!)) {
              return "Please use whole numbers (1+) only";
            }
            if (double.parse(value) < 10) {
              return "Goal must be at least 10 min";
            }
            if (double.parse(value) > 300) {
              return "300 min is max limit";
            }
            return null;
          },
          controller: exerciseGoalController,
          obscureText: false,
          decoration: InputDecoration(
            hintText: "Total Minutes",
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
                            text: 'Daily Goals',
                            style: FlutterFlowTheme.title1)),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 30, 0, 5),
                      child: _header(
                          text: 'Exercise Goal',
                          style: FlutterFlowTheme.title3),
                    ),
                    Row(
                      children: [
                        _exerciseGoalTextField(),
                        _setExerciseGoalButton(),
                        Expanded(
                            child: InkWell(
                                onTap: () async {
                                  await FireStore.updateHealthData(
                                          FireStore.exerciseTimeEndGoalToMap(0.0))
                                      .then((value) {
                                    FireStore.updateHealthData(
                                        FireStore.exerciseGoalBoolToMap(false));
                                    exerciseGoalController!.text = '';
                                    Toasted.showToast("Goal has been reset");
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 45,
                                  color: FlutterFlowTheme.secondaryColor,
                                )))
                      ],
                    ),
                  ]),
            ),
          ))),
    );
  }
}
