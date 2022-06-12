import 'package:flutter/material.dart';
import 'package:shopping_app/cart/screen/cart_screen.dart';
import 'package:shopping_app/home/screens/product_details_screen.dart';
import 'package:shopping_app/my_order/screen/my_order_screen.dart';
import 'package:shopping_app/product_management/screen/product_management_screen.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class ScreenRouter {
  ScreenRouter();

  Route onGeneratedRouter(RouteSettings routeSettings) {
    String? routeName = routeSettings.name;

    switch (routeName) {
      case ProductManagementScreen.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: routeSettings.arguments),
          builder: (_) => const ProductManagementScreen(),
        );
      //
      case CartScreen.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: routeSettings.arguments),
          builder: (_) => const CartScreen(),
        );
      //
      case MyOrderScreen.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: routeSettings.arguments),
          builder: (_) => const MyOrderScreen(),
        );
//
      case ProductDetailsScreen.routeName:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: routeSettings.arguments),
          builder: (_) => const ProductDetailsScreen(),
        );
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
