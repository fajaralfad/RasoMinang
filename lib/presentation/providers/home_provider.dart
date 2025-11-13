import 'package:flutter/foundation.dart';
import '../../data/services/home_service.dart';

class HomeProvider with ChangeNotifier {
  final HomeService _homeService = HomeService();
  
  bool _isInitializing = false;
  String? _errorMessage;

  bool get isInitializing => _isInitializing;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  Future<void> initializeApp() async {
    _updateInitializing(true);
    _errorMessage = null;
    
    try {
      await _homeService.initializeApp();
      notifyListeners();
    } catch (e) {
      _handleError('Gagal menginisialisasi aplikasi: $e');
    } finally {
      _updateInitializing(false);
    }
  }

  Future<void> logInteraction(String interactionType) async {
    try {
      await _homeService.logUserInteraction(interactionType);
    } catch (e) {
      debugPrint('Error logging interaction: $e');
    }
  }

  void _updateInitializing(bool initializing) {
    _isInitializing = initializing;
    notifyListeners();
  }

  void _handleError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}