import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/environment/environment.dart';
import 'package:my_book_store/src/features/splash/splash_page.dart';

Future<void> main() async {
  Environment.flavor = Flavor.qa;
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(const SplashPage());
}
