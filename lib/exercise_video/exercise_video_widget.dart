import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_youtube_player.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ExerciseVideoWidget extends StatefulWidget {
  final String url;
  ExerciseVideoWidget({Key key, @required this.url}) : super(key: key);

  @override
  _ExerciseVideoWidgetState createState() => _ExerciseVideoWidgetState();
}

class _ExerciseVideoWidgetState extends State<ExerciseVideoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Video _video;
  Text _videoTitle, _videoSource, _exerciseType;
  Text _difficulty, _descriptionHeader, _descriptionBody;

  @override
  void initState() {
    super.initState();
    _loadVideoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
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
                  child: _videoTitle,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                  child: _videoSource,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                  child: _exerciseType,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                  child: _difficulty,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                  child: _descriptionHeader,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                  child: _descriptionBody,
                )
              ],
            ),
          ),
        ));
  }

  void _loadVideoData() async {
    YoutubeExplode yt = YoutubeExplode();
    _video = await yt.videos.get(widget.url);
    setVideoData();
    yt.close();
  }

  void setVideoData() {
    setState(() {
      _setVideoTitle(_video.title);
      _setVideoSource(_video.author);
      _setDiscriptionHeader("Description");
      _setDiscriptionBody(_video.description.isEmpty
          ? "No Description Provided."
          : _video.description);
      _setExerciseType("Type of Exercise");
      _setDifficulty("Difficulty: example");
    });
  }

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
    _videoTitle = Text(vTitle,
        style: _bodyText1Style(fontSize: 30, fontWeight: FontWeight.bold));
  }

  void _setVideoSource(String vSource) {
    _videoSource = Text(vSource,
        style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
  }

  void _setExerciseType(String eType) {
    _exerciseType = Text(eType,
        style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
  }

  void _setDifficulty(String diff) {
    _difficulty = Text(diff,
        style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
  }

  void _setDiscriptionHeader(String dHeader) {
    _descriptionHeader = Text(dHeader,
        style: _bodyText1Style(fontSize: 20, fontWeight: FontWeight.bold));
  }

  void _setDiscriptionBody(String dBody) {
    _descriptionBody = Text(dBody,
        style: _bodyText1Style(fontSize: 16, fontWeight: FontWeight.normal));
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
}
