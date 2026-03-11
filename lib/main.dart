import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:itecotesttask/bloc/products/products.dart';
import 'package:itecotesttask/repository/products_repository.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import 'app.dart';

Future<void> main() async {
  final Talker talker = TalkerFlutter.init();
  final Dio dio = Dio();

  GetIt.I.registerSingleton<Talker>(talker);
  GetIt.I.registerSingleton<Dio>(dio);

  FlutterError.onError = (FlutterErrorDetails details) =>
      GetIt.I<Talker>().handle(details.exception, details.stack);

  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver();

  await runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        GetIt.I<Talker>().debug('started');
        GetIt.I.registerLazySingleton<ProductsRepository>(() => ProductsRepository(dio: GetIt.I<Dio>()));
        runApp(
          BlocProvider(
            create: (_) => ProductsBloc(GetIt.I<ProductsRepository>())..add(FetchProducts()),
            child: const MyApp(),
          )
        );
      },
      (Object error, StackTrace stack) {
        GetIt.I<Talker>().handle(error, stack);
      },
  );
}

