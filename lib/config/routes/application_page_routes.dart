import 'package:flutter/material.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class ScreenRouter {
  ScreenRouter();

  Route onGeneratedRouter(RouteSettings routeSettings) {
    String? routeName = routeSettings.name;

    switch (routeName) {
      // case BottomLandingScreen.routeName:
      //   return MaterialPageRoute(
      //     settings: RouteSettings(arguments: _routeSettings.arguments),
      //     builder: (_) => const BottomLandingScreen(),
      //   );
      //

      default:
        return errorRoute();
    }
  }

  static Route errorRoute() => MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => const Scaffold(
          body: Center(
            child: LoadingIndicator(
              color: Colors.red,
              strokeWidth: 5,
            ),
          ),
        ),
      );
}
