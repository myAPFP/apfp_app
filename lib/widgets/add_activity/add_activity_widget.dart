import 'package:apfp/util/validator/validator.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
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
  String? unitOfTime = 'Min';
  String? exercisetype = 'Cardio';

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

  String _getName() {
    return activityNameTextController!.text.toString().trim();
  }

  String _getDuration() {
    return durationTextController!.text.toString().trim();
  }

  List<String> _exerciseTypes() {
    return const [
      'Cardio',
      'Endurance',
      'Strength',
      'Flexibility',
      'Body-Composition',
      'Speed',
      'Kinesthetic'
    ].toList();
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
            Navigator.pop(
                context,
                ActivityCard(
                    icon: Icons.info,
                    duration: '${_getDuration()} $unitOfTime',
                    name: _getName().replaceAll(RegExp(' +'), '-'),
                    type: exercisetype));
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

  Padding _activityNameTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          key: Key("AddActivity.activityNameTextField"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please provide a value";
            }
            if (value.length > 15) {
              return "15 character max limit.  Current count: ${value.length}";
            }
            if (!Validator.isValidActivity(value)) {
              return 'Alphabet letters only';
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
            if (!Validator.isValidDuration(value) || double.parse(value) < 1) {
              return 'Positive numbers (1+) only';
            }

            if (double.parse(value) > 99) {
              return '99 is max limit';
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
                          initialOption: 'Cardio',
                          options: _exerciseTypes(),
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
                          initialOption: 'Min',
                          options: ['Sec', 'Min', 'Hr'],
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