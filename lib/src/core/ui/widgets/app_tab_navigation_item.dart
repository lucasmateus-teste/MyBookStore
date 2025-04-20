import 'package:flutter/material.dart';

class AppTabNavigationItem extends StatelessWidget {
  const AppTabNavigationItem({
    super.key,
    required this.navigatorKey,
    required this.routes,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, WidgetBuilder> routes;

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   navigatorKey: navigatorKey,
    //   routes: routes,
    //   theme: AppTheme.theme,
    //   initialRoute: '/',
    // );
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final WidgetBuilder builder = routes[settings.name!]!;
        return MaterialPageRoute(
          builder: (BuildContext context) => builder(context),
          settings: settings,
        );
      },
    );
  }
}
