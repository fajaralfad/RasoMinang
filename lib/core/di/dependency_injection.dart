// core/di/dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/history_provider.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klasifikasi_makanan_minang/core/network/api_client.dart';
import 'package:klasifikasi_makanan_minang/data/datasources/food_classification_remote_data_source.dart';
import 'package:klasifikasi_makanan_minang/data/repositories/food_classification_repository.dart';
import 'package:klasifikasi_makanan_minang/domain/usecases/classify_food_usecase.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/classification_provider.dart';
import 'package:klasifikasi_makanan_minang/presentation/providers/camera_provider.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {

    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    getIt.registerLazySingleton<ApiClient>(() => ApiClient());

    getIt.registerLazySingleton<FoodClassificationRemoteDataSource>(
      () => FoodClassificationRemoteDataSourceImpl(
        apiClient: getIt<ApiClient>(),
      ),
    );

    getIt.registerLazySingleton<FoodClassificationRepository>(
      () => FoodClassificationRepository(
        remoteDataSource: getIt<FoodClassificationRemoteDataSource>(),
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    );

    getIt.registerLazySingleton<ClassifyFoodUseCase>(
      () => ClassifyFoodUseCase(
        repository: getIt<FoodClassificationRepository>(),
      ),
    );

    getIt.registerFactory<ClassificationProvider>(
      () => ClassificationProvider(
        classifyFoodUseCase: getIt<ClassifyFoodUseCase>(),
        repository: getIt<FoodClassificationRepository>(),
      ),
    );

    getIt.registerFactory<CameraProvider>(
      () => CameraProvider(),
    );
    getIt.registerFactory<HistoryProvider>(
      () => HistoryProvider(),
    );
    getIt.registerFactory<HomeProvider>(
      () => HomeProvider(),
    );
  }

  static T get<T extends Object>() => getIt.get<T>();
}