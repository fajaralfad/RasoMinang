import 'package:klasifikasi_makanan_minang/domain/entities/prediction_entity.dart';

class HistoryService {
  List<PredictionEntity> _predictionHistory = [];

  List<PredictionEntity> get predictionHistory => _predictionHistory;

  Future<void> loadPredictionHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _predictionHistory = [];
  }

  Future<void> savePrediction(PredictionEntity prediction) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _predictionHistory.insert(0, prediction);
  }

  Future<void> clearPredictionHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _predictionHistory.clear();
  }

  Future<void> deletePrediction(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _predictionHistory.removeWhere((prediction) => prediction.id == id);
  }
}