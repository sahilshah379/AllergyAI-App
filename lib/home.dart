import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

import 'messaging.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.cameras,
  }) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  var messaging = new Messaging();
  String _id = '';
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool _flash = false;
  bool _frontFacing = false;

  @override
  void initState() {
    _readLocal();
    super.initState();
    _cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  void _readLocal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = prefs.getString('id')!;
    });
  }

  void setCamera() async {
    await _cameraController.setFlashMode(FlashMode.off);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget> [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                width: size.width,
                height: size.height - kBottomNavigationBarHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: CameraPreview(_cameraController),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
          top: 60,
          left: 10,
          child: IconButton(
            icon: Icon(
              _flash ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _flash = !_flash;
              });
              _flash ? _cameraController.setFlashMode(FlashMode.always) : _cameraController.setFlashMode(FlashMode.off);
            },
          ),
        ),
        Positioned(
          bottom: 30,
          right: 40,
          child: IconButton(
            icon: Icon(
              Icons.flip_camera_ios_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              setState(() {
                _frontFacing = !_frontFacing;
              });
              int cameraNum = _frontFacing ? 0 : 1;
              _cameraController = CameraController(
                widget.cameras[0],
                ResolutionPreset.max,
                imageFormatGroup: ImageFormatGroup.yuv420,
              );
              _initializeControllerFuture = _cameraController.initialize();
            },
          ),
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
                  File file = File(image.path);
                  var now = DateFormat('_yyyyMMddHHmmss').format(DateTime.now());
                  messaging.uploadFileToFirebase(file, _id + now + '.jpg');
                } catch(e) {
                  print(e);
                }
              },
              child: const Text(''),
            ),
          ),
        ),
      ],
    );
  }
}