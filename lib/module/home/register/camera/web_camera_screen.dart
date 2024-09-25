import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:likeplay/module/home/home.dart';
import 'package:likeplay/utils/sharedpref/preferences.dart';
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import 'cammera_button.dart';

class CameraScreenNew extends StatefulWidget {
  const CameraScreenNew({Key? key}) : super(key: key);

  @override
  _CameraScreenNewState createState() => _CameraScreenNewState();
}

class _CameraScreenNewState extends State<CameraScreenNew>
    with WidgetsBindingObserver {
  var isLoading = false;
  late final CameraScreenController _controller =
      CameraScreenController(context: context);
  String path = '';
  bool secondImage = false;

  Widget _CaptureButton() {
    return InkWell(
      onTap: () async {
        String ImagePath = await _controller.captureScreen();
        CammeraButton.path.toString();
        print("Helloo${CammeraButton.path}");
        CammeraButton.path = ImagePath;
        path = ImagePath;
        // _imagePath = await _controller.captureScreen();
        if (kDebugMode) {
          print("path is :$path");
        }
        secondImage = false;
        setState(() {});
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _controller.image,
        builder: (BuildContext context, bool value, Widget? child) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Colors.white,
            child: SizedBox(
              height: 60,
              width: 60,
              child: Icon(
                value ? Icons.stop : Icons.circle_outlined,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _toggleCameraButton() {
    return InkWell(
      onTap: _controller.toggleCamera,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: Colors.white,
        child: const SizedBox(
          height: 65,
          width: 65,
          child: Icon(
            Icons.switch_camera_outlined,
            size: 35,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _controller.initializeCamera(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Camera is not supporting!',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ValueListenableBuilder<CameraLensDirection>(
                  valueListenable: _controller.activeCamera,
                  builder: (
                    BuildContext context,
                    CameraLensDirection value,
                    Widget? child,
                  ) {
                    return CameraPreview(_controller.cameraController!);
                  },
                ),
              ),
              path.isNotEmpty
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _CaptureButton(),
                              _toggleCameraButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
              path.isNotEmpty
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Image.file(
                            File(path.toString()),
                            fit: BoxFit.fill,
                          ),
                        ),
                        path.isNotEmpty
                            ? Positioned(
                                bottom: 10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        color: Colors.white,
                                        child: GestureDetector(
                                          onTap: () {
                                            secondImage = true;
                                            SessionManager.setString(Preferences.camera_photo, path);
                                            // Navigator.pop(context);
                                      Navigator.pushReplacement(context,
                                                MaterialPageRoute(builder: (context)=>HomeScreen( viewType:21,comesFrom: "CameraScreen",)));
                                          },
                                          child: SizedBox(
                                            height: 65,
                                            width: 65,
                                            child: Icon(
                                              Icons.check,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          path = '';
                                          secondImage = false;
                                        });
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        color: Colors.white,
                                        child: const SizedBox(
                                          height: 65,
                                          width: 65,
                                          child: Icon(
                                            Icons.close,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            : Container(),
                      ],
                    )
                  : Container(),
              secondImage == true && path != ''
                  ? Container(
                      color: Colors.blue,
                      // child:Image.file(File(path),fit: BoxFit.fill,)):Container(),
                      child: Icon(Icons.add))
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CameraController cameraController = _controller.cameraController!;

    if (!cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _controller.initializeCamera(
          cameraDescription: cameraController.description);
    }
  }
}

class CameraScreenController {
  final BuildContext context;
  CameraController? cameraController;
  List<CameraDescription>? _availableCameras;
  final ValueNotifier<CameraLensDirection> activeCamera =
      ValueNotifier<CameraLensDirection>(CameraLensDirection.back);
  final ValueNotifier<Duration> recordDuration =
      ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<bool> recording = ValueNotifier<bool>(false);
  final ValueNotifier<bool> image = ValueNotifier<bool>(false);
  Timer? _timerGravacao;
  final ValueNotifier<FlashMode> flashMode =
      ValueNotifier<FlashMode>(FlashMode.off);

  CameraScreenController({
    required this.context,
  });

  Future<void> initializeCamera({CameraDescription? cameraDescription}) async {
    _availableCameras ??= await availableCameras();
    cameraController = CameraController(
      cameraDescription ?? _availableCameras!.first,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await cameraController!.initialize();
    if (!kIsWeb) {
      await cameraController!.setFlashMode(FlashMode.off);
    }
    cameraController!.addListener(() {
      recording.value = cameraController!.value.isRecordingVideo;
    });
  }

  Future<void> toggleCamera() async {
    if (!recording.value) {
      CameraLensDirection camera = activeCamera.value;
      if (activeCamera.value == CameraLensDirection.back) {
        await initializeCamera(cameraDescription: _availableCameras!.last);
        camera = _availableCameras!.last.lensDirection;
      } else {
        await initializeCamera(cameraDescription: _availableCameras!.first);
        camera = _availableCameras!.first.lensDirection;
      }
      activeCamera.value = camera;
    }
  }

/*
  void captureScreen() {
      // captureScreen().then((value) => print("caputre screen $value"));
    print("inside capture screen");
    cameraController!.takePicture().then((value){
      var data=value.path??"";
     print("inside the camera controller"+value.path);
     // cameraController=null;
    }).onError((error, stackTrace) { print("on errro $error");});

    // image.value =cameraController!.value.isTakingPicture;
    // if(image.value.toString().isNotEmpty){
    //   cameraController!.takePicture();
    //   cameraController?.dispose();
    //
    // }
    // else{
    //
    //   cameraController!.initialize();
    //   cameraController!.takePicture();
    // }

  }*/

  Future<String> captureScreen() async {
    return cameraController!
        .takePicture()
        .then((value) => value.path)
        .onError((error, stackTrace) => '');
  }

  void dispose() {
    cameraController?.dispose();
    _timerGravacao?.cancel();
    recording.dispose();
    recordDuration.dispose();
    image.dispose();
  }
}
