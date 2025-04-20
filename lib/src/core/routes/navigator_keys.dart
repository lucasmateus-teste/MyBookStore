import 'package:flutter/cupertino.dart';

sealed class NavigatorKeys {
  static final main = GlobalKey<NavigatorState>();
  static final home = GlobalKey<NavigatorState>();
  static final employees = GlobalKey<NavigatorState>();
  static final savedBooks = GlobalKey<NavigatorState>();
  static final books = GlobalKey<NavigatorState>();
  static final profile = GlobalKey<NavigatorState>();
}
