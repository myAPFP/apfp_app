import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_youtube_player.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseVideoWidget extends StatefulWidget {
  final String url;
  ExerciseVideoWidget({Key key, @required this.url}) : super(key: key);

  @override
  _ExerciseVideoWidgetState createState() => _ExerciseVideoWidgetState();
}

class _ExerciseVideoWidgetState extends State<ExerciseVideoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Text videoTitle, videoSource, exerciseType;
  Text difficulty, descriptionHeader, descriptionBody;

  InkWell _goBackToAllVideos() {
    return InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NavBarPage(initialPage: 'AtHomeExercises'),
              ));
        },
        child: Text('< Back to All Videos',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Open Sans',
              color: FlutterFlowTheme.secondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )));
  }

  void _setVideoTitle(String vTitle) {
    setState(() {
      videoTitle = Text(vTitle,
          style: _bodyText1Style(fontSize: 30, fontWeight: FontWeight.bold));
    });
  }

  void _setVideoSource(String vSource) {
    setState(() {
      videoSource = Text(vSource,
          style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
    });
  }

  void _setExerciseType(String eType) {
    setState(() {
      exerciseType = Text(eType,
          style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
    });
  }

  void _setDifficulty(String diff) {
    setState(() {
      difficulty = Text(diff,
          style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
    });
  }

  void _setDiscriptionHeader(String dHeader) {
    setState(() {
      descriptionHeader = Text(dHeader,
          style: _bodyText1Style(fontSize: 20, fontWeight: FontWeight.bold));
    });
  }

  void _setDiscriptionBody(String dBody) {
    setState(() {
      descriptionBody = Text(dBody,
          style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
    });
  }

  TextStyle _bodyText1Style({double fontSize, FontWeight fontWeight}) {
    return FlutterFlowTheme.bodyText1.override(
      fontFamily: 'Open Sans',
      color: FlutterFlowTheme.primaryColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  FlutterFlowYoutubePlayer _youtubePlayer() {
    return FlutterFlowYoutubePlayer(
      url: widget.url,
      autoPlay: false,
      looping: true,
      mute: false,
      showControls: true,
      showFullScreen: true,
    );
  }

  @override
  void initState() {
    super.initState();
    _setVideoTitle('Example Video Title');
    _setVideoSource("Video Source");
    _setExerciseType("Type of Exercise");
    _setDifficulty("Difficulty: example");
    _setDiscriptionHeader("Description");
    _setDiscriptionBody('Lorem ipsum dolor sit amet, consectetur adipiscing elit.' +
        'Nullam cursus eu arcu vitae mattis' +
        'Nullam sed gravida odio, nec ullamcorper justo. Ut ut finibus mauris.');
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
              padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
              child: _goBackToAllVideos(),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 25, 10, 0),
              child: _youtubePlayer(),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
              child: videoTitle,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
              child: videoSource,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
              child: exerciseType,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
              child: difficulty,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
              child: descriptionHeader,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
              child: descriptionBody,
            )
          ],
        ),
      ),
    );
  }
}
