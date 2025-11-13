// screens/camera_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/camera_provider.dart';
import '../../presentation/widgets/camera/camera_preview_widget.dart';
import '../../presentation/widgets/camera/camera_controls.dart';
import '../../presentation/widgets/camera/camera_error_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/loading_overlay.dart';

class CameraScreen extends StatefulWidget {
  final Function(String) onImageCaptured;

  const CameraScreen({super.key, required this.onImageCaptured});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final provider = context.read<CameraProvider>();

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      // Don't dispose here, let provider handle it
    } else if (state == AppLifecycleState.resumed && provider.hasError) {
      // Retry when app resumes with error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.retry();
      });
    }
  }

  Future<void> _initializeCamera() async {
    await Provider.of<CameraProvider>(context, listen: false).initialize();
  }

  Future<void> _handleImageCapture() async {
    final provider = context.read<CameraProvider>();
    final imagePath = await provider.takePicture();

    if (imagePath != null && mounted) {
      widget.onImageCaptured(imagePath);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<CameraProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              // Camera Preview or Error State
              if (provider.hasError)
                CameraErrorWidget(
                  errorMessage: provider.errorMessage,
                  onRetry: provider.retry,
                  onBack: () => Navigator.pop(context),
                )
              else
                CameraPreviewWidget(controller: provider.controller),

              // App Bar
              if (!provider.hasError)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _CameraAppBar(),
                ),

              // Camera Controls
              if (provider.isReady && !provider.hasError)
                CameraControls(
                  onCapture: _handleImageCapture,
                  onSwitchCamera: provider.switchCamera,
                  onToggleFlash: provider.toggleFlash,
                  isTakingPicture: provider.isTakingPicture,
                  isSwitchingCamera: provider.isSwitchingCamera,
                  hasMultipleCameras: provider.hasMultipleCameras,
                  isFlashOn: provider.isFlashOn,
                ),

              // Loading Overlays
              if (provider.isSwitchingCamera) _buildSwitchingOverlay(),
              if (provider.isLoading && !provider.hasError)
                const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSwitchingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}

class _CameraAppBar extends StatelessWidget {
  const _CameraAppBar();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Camera',
      showBackButton: true,
      onBackPressed: () => Navigator.pop(context),
      backgroundColor: Colors.transparent,
      textColor: Colors.white,
      elevation: 0,
    );
  }
}
