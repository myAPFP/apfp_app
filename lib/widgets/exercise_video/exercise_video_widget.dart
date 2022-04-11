import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ExerciseVideoWidget extends StatefulWidget {
  /// Stores YT video to be played.
  final Video video;

  ExerciseVideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  _ExerciseVideoWidgetState createState() => _ExerciseVideoWidgetState();
}

class _ExerciseVideoWidgetState extends State<ExerciseVideoWidget> {
  
  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Title of the YT video.
  Text? _videoTitle;

  /// URL of the YT video.
  Text? _videoSource;

  /// 'Description' label displayed above [_descriptionBody]
  Text? _descriptionLabel;

  /// Description of the YT video.
  Text? _descriptionBody;

  @override
  void initState() {
    super.initState();
    _allowLandscape();
    _loadVideoData();
  }

  /// Sets title, source (url), and description of the video being passed to 
  /// this class.
  void _loadVideoData() {
    setState(() {
      _setVideoTitle(widget.video.title);
      _setVideoSource(widget.video.author);
      _setDescriptionLabel("Description");
      _setDescriptionBody(widget.video.description.isEmpty
          ? "No Description Provided."
          : widget.video.description);
    });
  }

  /// Allows a users to view this page in landscape mode, providing a better
  /// YT video viewing experience.
  void _allowLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp
    ]);
  }

  /// Locks the app in portrait mode.
  void _lockPortait() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  /// Acts as a back button for this page.
  /// 
  /// Returns the user the available list of exercise videos when pressed.
  InkWell _goBackToAllVideos() {
    return InkWell(
        onTap: () async {
          _lockPortait();
          Navigator.pop(context);
        },
        child: Text('< Back to All Videos',
            textAlign: TextAlign.start, style: FlutterFlowTheme.subtitle2));
  }

  /// Sets video title.
  void _setVideoTitle(String vTitle) {
    _videoTitle = Text(vTitle, style: FlutterFlowTheme.title1);
  }

  /// Sets video source (url).
  void _setVideoSource(String vSource) {
    _videoSource = Text(vSource, style: FlutterFlowTheme.bodyText1);
  }

  /// Sets description label.
  void _setDescriptionLabel(String dHeader) {
    _descriptionLabel = Text(dHeader, style: FlutterFlowTheme.subtitle1);
  }

  /// Sets video description.
  void _setDescriptionBody(String dBody) {
    _descriptionBody = Text(dBody, style: FlutterFlowTheme.bodyText1);
  }

  /// Player used to view YT videos.
  FlutterFlowYoutubePlayer _youtubePlayer() {
    return FlutterFlowYoutubePlayer(
      url: widget.video.url,
      autoPlay: false,
      looping: true,
      mute: false,
      showControls: true,
      showFullScreen: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _lockPortait();
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
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
                    key: Key('Video.videoTitle'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
                    child: _videoTitle,
                  ),
                  Padding(
                    key: Key('Video.videoSource'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                    child: _videoSource,
                  ),
                  Padding(
                    key: Key('Video.videoDescriptionHeader'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                    child: _descriptionLabel,
                  ),
                  Padding(
                    key: Key('Video.videoDescriptionBody'),
                    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
                    child: _descriptionBody,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
