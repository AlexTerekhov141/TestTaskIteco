import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:itecotesttask/repository/products_repository.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies(Talker talker) {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 200),
      receiveTimeout: const Duration(milliseconds: 200),
      sendTimeout: const Duration(milliseconds: 200),
    ),
  );

  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  );

  getIt.registerSingleton<Talker>(talker);
  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<ProductsRepository>(
        () => ProductsRepository(dio: getIt<Dio>()),
  );
}