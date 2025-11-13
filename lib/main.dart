// main.dart
import 'package:flutter/material.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/camera_provider.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/classification_provider.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/history_provider.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:klasifikasi_makanan_minang/core/di/dependency_injection.dart';
import 'package:klasifikasi_makanan_minang/core/theme/app_theme.dart';
import 'package:klasifikasi_makanan_minang/core/utils/app_initializer.dart';
import 'package:klasifikasi_makanan_minang/core/config/app_config.dart';
import 'package:klasifikasi_makanan_minang/presentation/screens/home_screen.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app
  await AppInitializer.initialize();

  // Setup dependency injection
  await DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Classification Provider
        ChangeNotifierProvider(
          create:
              (context) => DependencyInjection.get<ClassificationProvider>(),
        ),
        // Camera Provider
        ChangeNotifierProvider(
          create: (context) => DependencyInjection.get<CameraProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => DependencyInjection.get<HistoryProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => DependencyInjection.get<HomeProvider>(),
        ),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: AppConfig.debugMode,
      ),
    );
  }
}
