// providers/history_provider.dart
import 'package:flutter/foundation.dart';
import '../../data/services/history_service.dart';
import '../../domain/entities/prediction_entity.dart';

class HistoryProvider with ChangeNotifier {
  final HistoryService _historyService = HistoryService();
  
  List<PredictionEntity> _predictions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PredictionEntity> get predictions => _predictions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get isEmpty => _predictions.isEmpty;

  Future<void> loadPredictionHistory() async {
    _updateLoading(true);
    _errorMessage = null;
    
    try {
      await _historyService.loadPredictionHistory();
      _predictions = _historyService.predictionHistory;
      notifyListeners();
    } catch (e) {
      _handleError('Gagal memuat riwayat: $e');
    } finally {
      _updateLoading(false);
    }
  }

  Future<void> clearPredictionHistory() async {
    try {
      await _historyService.clearPredictionHistory();
      _predictions.clear();
      notifyListeners();
    } catch (e) {
      _handleError('Gagal menghapus riwayat: $e');
    }
  }

  Future<void> addPrediction(PredictionEntity prediction) async {
    try {
      await _historyService.savePrediction(prediction);
      _predictions.insert(0, prediction);
      notifyListeners();
    } catch (e) {
      _handleError('Gagal menyimpan prediksi: $e');
    }
  }

  void _updateLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _handleError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    _historyService.clearPredictionHistory();
    super.dispose();
  }
}