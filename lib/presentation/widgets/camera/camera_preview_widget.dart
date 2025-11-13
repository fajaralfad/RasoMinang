import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatefulWidget {
  final CameraController? controller;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
  });

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  bool _hasError = false;

  @override
  void didUpdateWidget(CameraPreviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset error state when controller changes
    if (widget.controller != oldWidget.controller) {
      _hasError = false;
    }
  }

  bool get _isControllerValid {
    if (widget.controller == null) return false;
    
    try {
      return widget.controller!.value.isInitialized;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || !_isControllerValid) {
      return _buildErrorState();
    }

    return _buildCameraPreviewWithErrorBoundary();
  }

  Widget _buildCameraPreviewWithErrorBoundary() {
    try {
      final size = MediaQuery.of(context).size;
      var scale = 1.0;

      if (widget.controller!.value.aspectRatio < size.aspectRatio) {
        scale = size.aspectRatio / widget.controller!.value.aspectRatio;
      }

      return Transform.scale(
        scale: scale,
        child: Center(
          child: CameraPreview(widget.controller!),
        ),
      );
    } catch (e) {
      // Set error state to prevent repeated errors
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
      });
      
      return _buildErrorState();
    }
  }

  Widget _buildErrorState() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videocam_off,
              color: Colors.white,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'Kamera sedang dimuat...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}