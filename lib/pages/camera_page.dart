import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'timeline/home_page.dart';
import '../utils/custom_toast.dart';
import '../components/camera/index.dart';
import '../services/camera_permission_service.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isPhotoTaken = false;
  bool _showUploadModal = false;
  List<XFile> _capturedPhotos = [];
  bool _isInitialized = false;
  bool _hasPermission = false;
  double _currentZoom = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // When app becomes active again, check if camera permission was granted
    if (state == AppLifecycleState.resumed && !_isInitialized) {
      _checkPermissionAndInitialize();
    }
  }

  Future<void> _checkPermissionAndInitialize() async {
    bool hasPermission = await CameraPermissionService.checkCameraPermission();
    setState(() {
      _hasPermission = hasPermission;
    });
    if (hasPermission && !_isInitialized) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose().then((_) {
      // Ensure controller is properly disposed
    }).catchError((e) {
      print('Error disposing camera controller: $e');
    });
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    // Request camera permission using the service
    bool hasPermission = await CameraPermissionService.requestCameraPermission(context);
    
    setState(() {
      _hasPermission = hasPermission;
    });
    
    if (!hasPermission) {
      return;
    }
    
    // Initialize camera
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(
          cameras[0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _controller!.initialize();
        setState(() {
          _isInitialized = true;
        });
      } else {
        CustomToast.showTopToast(
          context,
          'No camera found on this device',
          type: ToastType.error,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      CustomToast.showTopToast(
        context,
        'Failed to initialize camera: $e',
        type: ToastType.error,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Show permission widget if permission not granted
          if (!_hasPermission)
            CameraPermissionWidget(
              onPermissionGranted: () {
                setState(() {
                  _hasPermission = true;
                });
                _initializeCamera();
              },
            )
          else ...[
            // Camera preview
            CameraPreviewWidget(
              controller: _controller,
              isInitialized: _isInitialized,
            ),
            
            // Camera header with close button and thumbnails
            CameraHeader(
              onClose: () => Navigator.pop(context),
              capturedPhotos: _capturedPhotos,
              onDeletePhoto: _deletePhoto,
            ),
            
            // Camera controls
            CameraControls(
              isPhotoTaken: _isPhotoTaken,
              hasCapturedPhotos: _capturedPhotos.isNotEmpty,
              onTakePhoto: _takePhoto,
              onShowUploadOptions: _showUploadOptions,
              currentZoom: _currentZoom,
              onZoomChanged: _onZoomChanged,
            ),
            
            // Upload modal
            if (_showUploadModal)
              UploadModal(
                photoCount: _capturedPhotos.length,
                onClose: () {
                  setState(() {
                    _showUploadModal = false;
                  });
                },
              ),
          ],
        ],
      ),
    );
  }



  Future<void> _takePhoto() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        // Add delay to prevent buffer overflow
        await Future.delayed(const Duration(milliseconds: 500));
        
        final XFile photo = await _controller!.takePicture();
        setState(() {
          _isPhotoTaken = true;
          _capturedPhotos.add(photo);
        });
      } catch (e) {
        print('Error taking photo: $e');
        // Show error toast
        CustomToast.showTopToast(
          context,
          'Failed to take photo. Please try again.',
          type: ToastType.error,
        );
      }
    }
  }

  void _showUploadOptions() {
    setState(() {
      _showUploadModal = true;
    });
  }

  void _deletePhoto(int index) {
    setState(() {
      _capturedPhotos.removeAt(index);
      if (_capturedPhotos.isEmpty) {
        _isPhotoTaken = false;
      }
    });
  }

  void _onZoomChanged(double zoom) async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        await _controller!.setZoomLevel(zoom);
        setState(() {
          _currentZoom = zoom;
        });
      } catch (e) {
        print('Error setting zoom: $e');
        CustomToast.showTopToast(
          context,
          'Failed to change zoom level',
          type: ToastType.error,
        );
      }
    }
  }
} 