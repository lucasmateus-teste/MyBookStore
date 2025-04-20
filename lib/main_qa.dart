import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_book_store/firebase_options.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/environment/environment.dart';
import 'package:my_book_store/src/features/splash/splash_page.dart';

Future<void> main() async {
  Environment.flavor = Flavor.qa;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupDependencies();

  runApp(const SplashPage());
}
