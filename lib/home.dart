import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this. camera,
  }) : super(key: key);
  final CameraDescription camera;

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;


  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.height / size.width;
    return Stack(
      children: <Widget> [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Transform.scale(
                    scale: deviceRatio/_cameraController.value.aspectRatio,
                    child: CameraPreview(_cameraController)
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                minimumSize: Size(80.0, 80.0),
                side: BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 8.0,
                ),
              ),
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _cameraController.takePicture();
                } catch(e) {
                  print(e);
                }
              },
              child: const Text(""),
            ),
          ),
        ),
      ],
    );
  }
}