import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/routes/routes.dart';
import 'package:my_book_store/src/core/ui/widgets/app_loader.dart';
import 'package:my_book_store/src/core/ui/widgets/app_navigation_bar.dart';
import 'package:my_book_store/src/core/ui/widgets/app_tab_navigation_item.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';
import 'package:my_book_store/src/features/books/admin/list/page/books_admin_page.dart';
import 'package:my_book_store/src/features/employees/list/page/employees_page.dart';
import 'package:my_book_store/src/features/home/page/home_page.dart';
import 'package:my_book_store/src/features/profile/overview/page/profile_overview_page.dart';
import 'package:my_book_store/src/features/books/saved/page/saved_books_page.dart';

class AppNavigationPage extends StatefulWidget {
  const AppNavigationPage({super.key});

  @override
  State<AppNavigationPage> createState() => _AppNavigationPageState();
}

class _AppNavigationPageState extends State<AppNavigationPage> {
  UserModel? _user;
  int _currentPage = 0;
  late final _pageController = PageController(initialPage: _currentPage);

  List<Widget> getTabs(UserModel user) {
    if (user.isAdmin) {
      return [
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.home,
          routes: {'/': (context) => HomePage(user: user)},
        ),
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.employees,
          routes: {'/': (context) => EmployeesPage()},
        ),
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.books,
          routes: {'/': (context) => BooksPage()},
        ),
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.profile,
          routes: {'/': (context) => ProfileOverviewPage(user: user)},
        ),
      ];
    } else {
      return [
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.home,
          routes: {'/': (context) => HomePage(user: user)},
        ),
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.savedBooks,
          routes: {'/': (context) => SavedBooksPage()},
        ),
        AppTabNavigationItem(
          navigatorKey: NavigatorKeys.profile,
          routes: {'/': (context) => ProfileOverviewPage(user: user)},
        ),
      ];
    }
  }

  List<BottomNavigationBarItem> getItems(UserModel user) {
    if (user.isAdmin) {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Funcionários',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_rounded),
          label: 'Livros',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Meu Perfil',
        ),
      ];
    } else {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline),
          label: 'Salvos',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Meu Perfil',
        ),
      ];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_user != null) return;
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! UserModel) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
        (route) => false,
      );
      return;
    }

    setState(() {
      _user = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final user = _user;
            if (user == null) {
              return const AppLoader();
            }
            return Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: getTabs(user),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppNavigationBar(
                    selectedIndex: _currentPage,
                    onTap: (index) {
                      setState(() {
                        _pageController.jumpToPage(index);
                        _currentPage = index;
                      });
                    },
                    items: getItems(user),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
