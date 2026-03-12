import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:itecotesttask/themes/themes.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'core/routes.dart';

final AppRouter _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Iteco Test',
      theme: AppThemes.lightTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => <NavigatorObserver>[
          TalkerRouteObserver(GetIt.I<Talker>())
        ],
      ),
    );
  }
}