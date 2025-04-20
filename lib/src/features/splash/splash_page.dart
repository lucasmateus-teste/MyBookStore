import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/environment/environment.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/routes/routes.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/theme/app_theme.dart';
import 'package:my_book_store/src/features/auth/login/bloc/login_bloc.dart';
import 'package:my_book_store/src/features/auth/login/page/login_page.dart';
import 'package:my_book_store/src/features/auth/register/bloc/register_store_bloc.dart';
import 'package:my_book_store/src/features/auth/register/page/register_store_page.dart';
import 'package:my_book_store/src/features/navigation/app_navigation_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        if (!Environment.isProduction) {
          return Banner(
            message: 'QA',
            textStyle: context.textStyles.link.x.copyWith(
              color: context.colors.grayScale.bg,
            ),
            location: BannerLocation.topStart,
            color: context.colors.primary.df,
            child: child!,
          );
        }
        return child!;
      },
      theme: AppTheme.theme,
      initialRoute: Routes.login,
      navigatorKey: NavigatorKeys.main,
      routes: {
        Routes.login: (context) => LoginPage(loginBloc: getIt.get<LoginBloc>()),
        Routes.registerStore:
            (context) => RegisterStorePage(
              registerStoreBloc: getIt.get<RegisterStoreBloc>(),
            ),
        Routes.navigation: (context) => const AppNavigationPage(),
      },
    );
  }
}
