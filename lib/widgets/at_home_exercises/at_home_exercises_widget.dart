import 'dart:async';

import 'package:apfp/firebase/firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../confimation_dialog/confirmation_dialog.dart';
import '../exercise_video/exercise_video_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AtHomeExercisesWidget extends StatefulWidget {
  AtHomeExercisesWidget({Key? key}) : super(key: key);

  @override
  _AtHomeExercisesWidgetState createState() => _AtHomeExercisesWidgetState();
}

class _AtHomeExercisesWidgetState extends State<AtHomeExercisesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _index = 0;
  Timer? timer;
  List<Widget> videoList = [];
  bool _isVideosLoaded = false;

  @override
  void initState() {
    super.initState();
    preloadAllVideos();
    timer =
        Timer.periodic(Duration(minutes: 30), (Timer t) => preloadAllVideos());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<Padding> _paddedHeaderText() {
    return [
      Padding(
        key: Key('Exercises.header'),
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          AutoSizeText(
            'At-Home Exercises',
            style: FlutterFlowTheme.title1,
            overflow: TextOverflow.fade,
          )
        ]),
      ),
      Padding(
          key: Key('Exercises.description'),
          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 24, 10),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: Text(
                    'The following videos are some exercises that can be done at home.' +
                        ' Please remember to be safe when exercising.',
                    style: FlutterFlowTheme.bodyText1))
          ]))
    ];
  }

  Padding _videoTrainingCard(
      {required int index,
      required String author,
      required String url,
      required String title,
      required Video video}) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
        child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseVideoWidget(video: video),
                ),
              );
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1),
                          Text("$_index", style: FlutterFlowTheme.title3),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleRow(title),
                            _sourceRow(author),
                            _lengthRow(video)
                          ]),
                    ],
                  ),
                ))));
  }

  Row _titleRow(String title) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: FlutterFlowTheme.title3,
            overflow: TextOverflow.ellipsis,
            minFontSize: 18,
          ))
    ]);
  }

  Row _sourceRow(String author) {
    return Row(children: [
      Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: AutoSizeText.rich(
          TextSpan(
              text: 'Source: ',
              style: FlutterFlowTheme.title3Red,
              children: [
                TextSpan(text: '$author', style: FlutterFlowTheme.bodyText1)
              ]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          minFontSize: 14,
        ),
      )
    ]);
  }

  Row _lengthRow(Video video) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: AutoSizeText.rich(
            TextSpan(
                text: 'Video Length: ',
                style: FlutterFlowTheme.title3Red,
                children: video.duration!.inMinutes > 1
                    ? [
                        TextSpan(
                            text: '${video.duration!.inMinutes} minutes',
                            style: FlutterFlowTheme.bodyText1)
                      ]
                    : [
                        TextSpan(
                            text: '${video.duration!.inSeconds} seconds',
                            style: FlutterFlowTheme.bodyText1)
                      ]),
            overflow: TextOverflow.ellipsis,
            minFontSize: 14,
          ))
    ]);
  }

  void preloadAllVideos() {
    _getPlaylistIDs().then((ids) => ids.forEach((id) => _preloadPlaylist(id)));
    _getVideoUrls().then((urls) => urls.forEach((url) => _preloadVideo(url)));
    _isVideosLoaded = true;
  }

  Future<List<String>> _getVideoUrls() async {
    List<String> urls = [];
    await FireStore.getVideoUrls().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        urls.add(doc["url"]);
      });
    });
    return urls;
  }

  Future<List<String>> _getPlaylistIDs() async {
    List<String> ids = [];
    await FireStore.getPlaylistIDs().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        ids.add(doc["id"]);
      });
    });
    return ids;
  }

  void _preloadVideo(String url) async {
    YoutubeExplode yt = YoutubeExplode();
    Video video = await yt.videos.get(url);
    _index++;
    _addVideoToList(_videoTrainingCard(
        index: _index,
        author: video.author,
        url: video.url,
        title: video.title,
        video: video));
    yt.close();
  }

  void _preloadPlaylist(String id) async {
    YoutubeExplode yt = YoutubeExplode();
    Playlist playlist = await yt.playlists.get(id);
    await for (Video video in yt.playlists.getVideos(playlist.id)) {
      _index++;
      _addVideoToList(_videoTrainingCard(
          index: _index,
          author: video.author,
          url: video.url,
          title: video.title,
          video: video));
    }
    yt.close();
  }

  void _addVideoToList(Padding videoTrainingCard) {
    setState(() {
      videoList.add(videoTrainingCard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ConfirmationDialog.showExitAppDialog(context);
        return false;
      },
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _paddedHeaderText()[0],
                  _paddedHeaderText()[1],
                  !_isVideosLoaded
                      ? Text("Loading Videos...",
                          style: FlutterFlowTheme.subtitle3)
                      : Text("Video Count: ${videoList.length}",
                          style: FlutterFlowTheme.subtitle3),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: videoList,
              ),
              SizedBox(height: 10)
            ]),
          ))),
    );
  }
}
