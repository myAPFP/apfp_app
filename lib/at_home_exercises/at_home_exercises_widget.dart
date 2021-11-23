import '../exercise_video/exercise_video_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AtHomeExercisesWidget extends StatefulWidget {
  AtHomeExercisesWidget({Key? key}) : super(key: key);

  @override
  _AtHomeExercisesWidgetState createState() => _AtHomeExercisesWidgetState();
}

class _AtHomeExercisesWidgetState extends State<AtHomeExercisesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> videoList = [];

  List<Widget> _getVideoList() => videoList;

  @override
  void initState() {
    super.initState();
    _preloadExistingVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [_paddedHeaderText()[0], _paddedHeaderText()[1]],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: _getVideoList(),
            ),
          ]),
        )));
  }

  List<Padding> _paddedHeaderText() {
    return [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Text('At-Home Exercises',
              style: FlutterFlowTheme.title1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ))
        ]),
      ),
      Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 24, 24),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: Text(
                    'The following videos are some exercises you could try at home. They range in exersise type, difficulty and duration.',
                    style: FlutterFlowTheme.bodyText2.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )))
          ]))
    ];
  }

  Padding _videoTrainingCard(
      {required String exercises,
      required String difficultyLevel,
      required String url,
      required String label}) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 8, 10, 0),
        child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseVideoWidget(url: url),
                ),
              );
            },
            child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: FlutterFlowTheme.primaryColor,
                  ),
                ),
                child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Stack(children: [
                            Align(
                                alignment: AlignmentDirectional(-0.1, -0.5),
                                child: Text(label,
                                    style: FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            Align(
                                alignment: AlignmentDirectional(2.64, 0.55),
                                child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Text(
                                        'Includes: $exercises\nDifficulty Level: $difficultyLevel',
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ))))
                          ])),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: AlignmentDirectional(0.05, 0),
                              child: Icon(Icons.chevron_right,
                                  color: Color(0xFF95A1AC), size: 28)))
                    ])))));
  }

  void _preloadExistingVideos() {
    _addVideoToList(_videoTrainingCard(
        label: 'High Intensity Interval Training',
        exercises: "Squats, Push-ups",
        difficultyLevel: "2",
        url: "https://youtu.be/pGMGIslVihU"));

    _addVideoToList(_videoTrainingCard(
        label: 'High Intensity Interval Training',
        exercises: "Calf Raises, Knee to chest",
        difficultyLevel: "1",
        url: "https://youtu.be/4bIS0Kz7lKE"));

    _addVideoToList(_videoTrainingCard(
        label: 'High Intensity Interval Training',
        exercises: "Step-ups, Lateral Lunges",
        difficultyLevel: "3",
        url: "https://youtu.be/js-MHdWF-so"));

    _addVideoToList(_videoTrainingCard(
        label: 'High Intensity Interval Training',
        exercises: "Squats/Shoulder Press, Face-pulls",
        difficultyLevel: "5",
        url: "https://youtu.be/yxf6knAo4Sk"));
  }

  void _addVideoToList(Padding videoTrainingCard) {
    setState(() {
      videoList.add(videoTrainingCard);
    });
  }
}
