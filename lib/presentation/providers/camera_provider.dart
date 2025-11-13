import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import '../../data/services/camera_service.dart';

class CameraProvider with ChangeNotifier {
  final CameraService _cameraService = CameraService();
  
  CameraState _state = CameraState.initial;
  String? _errorMessage;
  bool _isTakingPicture = false;
  bool _isSwitchingCamera = false;

  CameraState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isTakingPicture => _isTakingPicture;
  bool get isSwitchingCamera => _isSwitchingCamera;
  bool get isReady => _state == CameraState.ready;
  bool get hasError => _state == CameraState.error;
  bool get isLoading => _state == CameraState.loading;
  CameraController? get controller => _cameraService.isDisposed ? null : _cameraService.controller;
  bool get hasMultipleCameras => _cameraService.hasMultipleCameras;
  bool get isFlashOn => _cameraService.isFlashOn;
  bool get isDisposed => _cameraService.isDisposed;

  Future<void> initialize() async {
    if (_cameraService.isDisposed || _cameraService.isInitializing) return;
    
    _updateState(CameraState.loading);
    _errorMessage = null;
    
    try {
      await _cameraService.initialize();
      if (!_cameraService.isDisposed) {
        _updateState(CameraState.ready);
      }
    } catch (e) {
      if (!_cameraService.isDisposed) {
        _handleError('Gagal menginisialisasi kamera: $e');
      }
    }
  }

  Future<void> switchCamera() async {
    if (_isSwitchingCamera || !hasMultipleCameras || _cameraService.isDisposed) return;
    
    _isSwitchingCamera = true;
    notifyListeners();
    
    try {
      await _cameraService.switchCamera();
      _isSwitchingCamera = false;
      if (!_cameraService.isDisposed) {
        notifyListeners();
      }
    } catch (e) {
      _isSwitchingCamera = false;
      if (!_cameraService.isDisposed) {
        _handleError('Gagal mengganti kamera: $e');
      }
    }
  }

  Future<void> toggleFlash() async {
    if (!isReady || _cameraService.isDisposed) return;
    
    try {
      await _cameraService.toggleFlash();
      if (!_cameraService.isDisposed) {
        notifyListeners();
      }
    } catch (e) {
      if (!_cameraService.isDisposed) {
        _handleError('Gagal mengatur flash: $e');
      }
    }
  }

  Future<String?> takePicture() async {
    if (!isReady || _isTakingPicture || _cameraService.isDisposed) return null;
    
    _isTakingPicture = true;
    notifyListeners();
    
    try {
      final file = await _cameraService.takePicture();
      _isTakingPicture = false;
      if (!_cameraService.isDisposed) {
        notifyListeners();
      }
      return file.path;
    } catch (e) {
      _isTakingPicture = false;
      if (!_cameraService.isDisposed) {
        _handleError('Gagal mengambil foto: $e');
      }
      return null;
    }
  }

  Future<void> retry() async {
    if (_cameraService.isDisposed) return;
    
    _errorMessage = null;
    await initialize();
  }

  void _updateState(CameraState newState) {
    if (!_cameraService.isDisposed) {
      _state = newState;
      notifyListeners();
    }
  }

  void _handleError(String message) {
    if (!_cameraService.isDisposed) {
      _errorMessage = message;
      _updateState(CameraState.error);
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }
}

enum CameraState {
  initial,
  loading,
  ready,
  error,
}