import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/app_config.dart';

class AppInitializer {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: AppConfig.envFileName);
      print('Environment variables loaded successfully');
    } catch (e) {
      print('Error loading .env file: $e');
      print('Make sure .env file exists in project root');
    }
  }
}