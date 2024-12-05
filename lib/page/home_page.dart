import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  Future<void> _setupCameraController() async {
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      setState(() {
        cameras = _cameras;
        cameraController =
            CameraController(_cameras.first, ResolutionPreset.high);
      });
      cameraController?.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
        child: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * .8,
              child: CameraPreview(cameraController!)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.camera,
                color: Colors.red,
              ))
        ],
      ),
    ));
  }
}
