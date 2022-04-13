// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:async';

import '/flutter_flow/flutter_flow_theme.dart';
import '/util/internet_connection/internet.dart';
import '../exercise_video/exercise_video_widget.dart';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AtHomeExercisesWidget extends StatefulWidget {
  /// The APFP YouTube url collection stream.
  final Stream<QuerySnapshot<Object?>> videoStream;

  /// The APFP YouTube playlist id collection stream.
  final Stream<QuerySnapshot<Object?>> playlistStream;

  AtHomeExercisesWidget(
      {Key? key, required this.playlistStream, required this.videoStream})
      : super(key: key);

  @override
  _AtHomeExercisesWidgetState createState() => _AtHomeExercisesWidgetState();
}

class _AtHomeExercisesWidgetState extends State<AtHomeExercisesWidget> {
  /// Serves as key for the [Scaffold] found in [build].
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Returns true if all YouTube videos are loaded.
  bool _isVideosLoaded = false;

  /// A list of APFP YouTube video urls.
  List<String> videoURLs = [];

  /// Backup of APFP YouTube video urls.
  List<Widget> videoBackup = [];

  /// A list of APFP YouTube playlist ids.
  List<String> playlistIDs = [];

  /// Backup of APFP YouTube playlist ids.
  List<Widget> playlistBackup = [];

  /// A list of APFP YouTube videos available for viewing.
  List<Widget> videoList = [];

  @override
  void initState() {
    super.initState();
    preloadAllVideos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Returns the header text which is displayed at the top of the
  /// Exercises screen.
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

  /// Creates a video card which displays the video's info.
  Padding _videoCard(
      {required String author,
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
                height: MediaQuery.of(context).size.height * 0.15,
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
                              width: MediaQuery.of(context).size.width * 0.07),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleRow(title),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005),
                            _sourceRow(author),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005),
                            _videoLengthRow(video)
                          ]),
                    ],
                  ),
                ))));
  }

  /// Creates a video title row used in a [_videoCard].
  Row _titleRow(String title) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85),
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: FlutterFlowTheme.title3,
            overflow: TextOverflow.ellipsis,
            minFontSize: 18,
          ))
    ]);
  }

  /// Creates a video source row used in a [_videoCard].
  Row _sourceRow(String author) {
    return Row(children: [
      Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
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

  /// Creates a video length row used in a [_videoCard].
  Row _videoLengthRow(Video video) {
    return Row(children: [
      Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85),
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

  /// Preloads all APFP YouTube videos if the user is connected to the internet.
  /// 
  /// If there is no internet connection, this method will be called recursively until
  /// one is established.
  void preloadAllVideos() async {
    await (Internet.isConnected()).then((value) async => {
          if (value)
            {
              setState(() {
                _populateVideos();
                _populatePlaylists();
              })
            }
          else
            {Timer(Duration(seconds: 1), preloadAllVideos)}
        });
    _isVideosLoaded = true;
  }

  /// Adds each video url from the video stream to [videoList].
  void _populateVideos() {
    widget.videoStream.forEach((snapshot) {
      for (Widget element in videoBackup) {
        if (videoList.contains(element)) {
          videoList.remove(element);
        }
      }
      videoBackup.clear();
      snapshot.docs.forEach((document) {
        _preloadVideo(document["url"]);
      });
    });
  }

  /// Adds each playlist id from the video stream to [videoList].
  void _populatePlaylists() {
    widget.playlistStream.forEach((snapshot) {
      for (Widget element in playlistBackup) {
        if (videoList.contains(element)) {
          videoList.remove(element);
        }
      }
      playlistBackup.clear();
      snapshot.docs.forEach((document) {
        _preloadPlaylist(document["id"]);
      });
    });
  }

  /// Converts a YouTube url into a [_videoCard] and adds it to [videoList].
  void _preloadVideo(String url) async {
    YoutubeExplode yt = YoutubeExplode();
    Video video = await yt.videos.get(url);
    Padding videoCard = _videoCard(
        author: video.author, url: video.url, title: video.title, video: video);
    _addVideoToList(videoCard);
    videoBackup.add(videoCard);
    yt.close();
  }

  /// Converts a YouTube playlist id into a [_videoCard] and adds it to [videoList].
  void _preloadPlaylist(String id) async {
    YoutubeExplode yt = YoutubeExplode();
    Playlist playlist = await yt.playlists.get(id);
    await for (Video video in yt.playlists.getVideos(playlist.id)) {
      Padding videoCard = _videoCard(
          author: video.author,
          url: video.url,
          title: video.title,
          video: video);
      _addVideoToList(videoCard);
      playlistBackup.add(videoCard);
    }
    yt.close();
  }

  /// Adds a video card to [videoList].
  void _addVideoToList(Padding videoCard) {
    setState(() {
      videoList.add(videoCard);
    });
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
        )));
  }
}
