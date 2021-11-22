import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';

class AddActivityWidget extends StatefulWidget {
  AddActivityWidget({Key? key}) : super(key: key);

  @override
  _AddActivityWidgetState createState() => _AddActivityWidgetState();
}

class _AddActivityWidgetState extends State<AddActivityWidget> {
  String? exercisetype;
  TextEditingController? activityNameTextController;
  String? duration;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> durationOptions = [];
  List<String> exerciseTypeOptions = [];

  @override
  void initState() {
    super.initState();
    activityNameTextController = TextEditingController();
    _populateDurationOptions();
    _populateExcerciseOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    style: _bodyText1Style(
                        fontSize: 30, fontWeight: FontWeight.bold))),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
              child: _header(
                  text: 'Name of Activity',
                  style: _bodyText1Style(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            _activityNameTextField(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
              child: _header(
                  text: 'Type of Exercise',
                  style: _bodyText1Style(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            _dropDown(exerciseTypeOptions, exercisetype),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 5),
              child: _header(
                  text: 'Duration',
                  style: _bodyText1Style(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            _dropDown(durationOptions, duration),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                child: _submitButton(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _header({required String text, TextStyle? style}) {
    return Text(text, style: style);
  }

  void _populateExcerciseOptions() {
    setState(() {
      exerciseTypeOptions.add("Option 1");
      exerciseTypeOptions.add("Option 2");
    });
  }

  void _populateDurationOptions() {
    setState(() {
      durationOptions.add("Option 1");
      durationOptions.add("Option 2");
    });
  }

  TextStyle _bodyText1Style({double? fontSize, FontWeight? fontWeight}) {
    return FlutterFlowTheme.bodyText1.override(
      fontFamily: 'Open Sans',
      color: FlutterFlowTheme.primaryColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  Padding _dropDown(List<String> options, String? valueToChange) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: FlutterFlowDropDown(
        initialOption: valueToChange ??= 'Select a option',
        options: options,
        onChanged: (val) => setState(() => valueToChange = val),
        width: MediaQuery.of(context).size.width,
        height: 50,
        textStyle: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal),
        fillColor: Colors.white,
        elevation: 2,
        borderColor: FlutterFlowTheme.primaryColor,
        borderWidth: 0,
        borderRadius: 10,
        margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
        hidesUnderline: true,
      ),
    );
  }

  FFButtonWidget _submitButton() {
    return FFButtonWidget(
      onPressed: () async {
        setState(() => _loadingButton = true);
        try {
          await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 125),
                reverseDuration: Duration(milliseconds: 125),
                child: NavBarPage(initialPage: 'Activity'),
              ));
        } finally {
          setState(() => _loadingButton = false);
        }
      },
      text: 'Submit',
      options: FFButtonOptions(
        width: 120,
        height: 50,
        color: FlutterFlowTheme.secondaryColor,
        textStyle: FlutterFlowTheme.subtitle2.override(
          fontFamily: 'Open Sans',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: 12,
      ),
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
                child: NavBarPage(initialPage: 'Activity'),
              ));
        },
        child: Text('< Go Back',
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )));
  }

  Padding _activityNameTextField() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      child: TextFormField(
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
        style: _bodyText1Style(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
