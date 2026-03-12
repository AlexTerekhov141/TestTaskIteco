import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itecotesttask/bloc/products/products.dart';
import 'package:itecotesttask/core/injection.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'app.dart';

Future<void> main() async {
  final Talker talker = TalkerFlutter.init();

  FlutterError.onError = (FlutterErrorDetails details) =>
      getIt<Talker>().handle(details.exception, details.stack);

  Bloc.observer = TalkerBlocObserver();

  await runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      setupDependencies(talker);

      getIt<Talker>().debug('started');

      runApp(
        BlocProvider(
          create: (_) => ProductsBloc(getIt())..add(FetchProducts()),
          child: const MyApp(),
        ),
      );
    },
        (Object error, StackTrace stack) {
      getIt<Talker>().handle(error, stack);
    },
  );
}