import 'package:auto_route/auto_route.dart';
import 'package:itecotesttask/core/routes.gr.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: ScrollingRoute.page),
    AutoRoute(page: SplashRoute.page, initial: true)
  ];

}
