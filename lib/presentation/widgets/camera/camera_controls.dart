// widgets/camera_controls.dart
import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final VoidCallback onCapture;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleFlash;
  final bool isTakingPicture;
  final bool isSwitchingCamera;
  final bool hasMultipleCameras;
  final bool isFlashOn;

  const CameraControls({
    super.key,
    required this.onCapture,
    required this.onSwitchCamera,
    required this.onToggleFlash,
    required this.isTakingPicture,
    required this.isSwitchingCamera,
    required this.hasMultipleCameras,
    required this.isFlashOn,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final captureButtonSize = size.width * 0.2;
    final iconButtonSize = size.width * 0.12;

    return Positioned(
      bottom: size.height * 0.05,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                    onPressed: onToggleFlash,
                    icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
                    size: iconButtonSize,
                    isDisabled: isTakingPicture || isSwitchingCamera,
                  ),
                  _buildCaptureButton(
                    size: captureButtonSize,
                    isTakingPicture: isTakingPicture,
                    isDisabled: isTakingPicture || isSwitchingCamera,
                    onPressed: onCapture,
                  ),
                  _buildIconButton(
                    onPressed: onSwitchCamera,
                    icon: Icons.cameraswitch,
                    size: iconButtonSize,
                    isDisabled: isTakingPicture || 
                               isSwitchingCamera || 
                               !hasMultipleCameras,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                'Tap circle to take photo',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.035,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    required double size,
    bool isDisabled = false,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isDisabled ? 0.5 : 1.0,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.black38,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: isDisabled ? null : onPressed,
          icon: Icon(
            icon,
            color: isDisabled ? Colors.grey : Colors.white,
            size: size * 0.5,
          ),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureButton({
    required double size,
    required bool isTakingPicture,
    required bool isDisabled,
    required VoidCallback onPressed,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isDisabled ? 0.7 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isDisabled ? Colors.grey : Colors.white,
              width: 4,
            ),
            boxShadow: [
              if (!isDisabled)
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDisabled ? Colors.grey : Colors.white,
            ),
            child: isTakingPicture
                ? Padding(
                    padding: EdgeInsets.all(size * 0.15),
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}