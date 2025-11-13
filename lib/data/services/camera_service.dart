import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  CameraLensDirection _currentLens = CameraLensDirection.back;
  bool _isDisposed = false;
  bool _isInitializing = false;

  CameraController? get controller => _controller;
  List<CameraDescription>? get cameras => _cameras;
  CameraLensDirection get currentLens => _currentLens;
  bool get isInitialized => _isControllerValid;
  bool get hasMultipleCameras => (_cameras?.length ?? 0) > 1;
  bool get isFlashOn => _controller?.value.flashMode == FlashMode.torch;
  bool get isDisposed => _isDisposed;
  bool get isInitializing => _isInitializing;

  bool get _isControllerValid {
    if (_isDisposed || _controller == null) return false;
    try {
      return _controller!.value.isInitialized;
    } catch (e) {
      return false;
    }
  }

  Future<void> initialize() async {
    if (_isDisposed || _isInitializing) return;
    
    _isInitializing = true;
    
    try {
      await _requestPermission();
      await _setupCameras();
      await _initializeBackCamera();
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      if (!result.isGranted) {
        throw Exception('Camera permission denied');
      }
    }
  }

  Future<void> _setupCameras() async {
    if (_isDisposed) return;
    
    _cameras = await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) {
      throw Exception('No cameras available');
    }
  }

  Future<void> _initializeBackCamera() async {
    if (_isDisposed) return;
    
    final backCamera = _cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras!.first,
    );
    await _initializeController(backCamera);
  }

  Future<void> _initializeController(CameraDescription camera) async {
    if (_isDisposed) return;
    
    // Dispose existing controller first
    await _disposeController();

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (_isDisposed) {
        await _disposeController();
        return;
      }
      _currentLens = camera.lensDirection;
    } catch (e) {
      await _disposeController();
      rethrow;
    }
  }

  Future<void> switchCamera() async {
    if (!hasMultipleCameras || _isDisposed || _isInitializing) return;

    final currentIndex = _cameras!.indexWhere(
      (camera) => camera.lensDirection == _currentLens,
    );

    final nextCamera = _cameras![
      (currentIndex + 1) % _cameras!.length
    ];

    await _initializeController(nextCamera);
  }

  Future<void> toggleFlash() async {
    if (!_isControllerValid || _isDisposed) return;

    try {
      final newMode = isFlashOn ? FlashMode.off : FlashMode.torch;
      await _controller!.setFlashMode(newMode);
    } catch (e) {
      debugPrint('Error toggling flash: $e');
    }
  }

  Future<XFile> takePicture() async {
    if (!_isControllerValid || _isDisposed) {
      throw Exception('Camera not initialized or disposed');
    }
    
    try {
      return await _controller!.takePicture();
    } catch (e) {
      debugPrint('Error taking picture: $e');
      rethrow;
    }
  }

  Future<void> _disposeController() async {
    if (_controller != null) {
      try {
        final controllerToDispose = _controller!;
        _controller = null;
        
        if (controllerToDispose.value.isInitialized) {
          await controllerToDispose.dispose();
        }
      } catch (e) {
        debugPrint('Error disposing controller: $e');
      }
    }
  }

  Future<void> dispose() async {
    _isDisposed = true;
    await _disposeController();
  }
}