
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class VideoPlayerApp extends StatefulWidget {
  final url, fileName;

  VideoPlayerApp(this.url, this.fileName);

  @override
  _VideoPlayerApp createState() => _VideoPlayerApp(this.url, this.fileName);
}

class _VideoPlayerApp extends State<VideoPlayerApp> {
  var _url, _fileName;
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  bool startedPlaying = false;
  int _stackViewIndex = 1;

  _VideoPlayerApp(this._url, this._fileName);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(_url)
    // this is the evil part : issue between chewie & video_player
      ..initialize().then((_) {
        setState(() {
          _stackViewIndex = 0;
          _controller!.pause();
        });
      });
    //

    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      allowFullScreen: true,
      showOptions: true,
      looping: true,
      autoPlay: false,
      hideControlsTimer: const Duration(seconds: 1),
      customControls:  MaterialControls(
        showPlayButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _stackViewIndex, children: [
        Container(
          color: Colors.black,
          child: Center(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller!),
                    VideoProgressIndicator(_controller!, allowScrubbing: true),
                  ],
                ),
              )),
        ),
        Container(
            child: SafeArea(
              child: Container(child: Center(child: CircularProgressIndicator())),
            )),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            _controller!.value.isPlaying
                ? _controller!.pause()
                : _controller!.play();
          });
        },
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }
}
