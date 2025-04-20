import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_loader.dart';
import 'package:my_book_store/src/features/books/admin/list/bloc/book_admin_bloc.dart';
import 'package:my_book_store/src/features/books/details/page/book_details_page.dart';
import 'package:my_book_store/src/core/ui/widgets/app_book_grid_view.dart';
import 'package:my_book_store/src/features/books/admin/form/page/book_admin_form_page.dart';
import 'package:my_book_store/src/services/analytics_service.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late final bloc = getIt.get<BookAdminBloc>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(BookAdminGetBooksEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 68),
        child: FloatingActionButton(
          heroTag: 'registerBook',
          onPressed: () async {
            await Navigator.push(
              NavigatorKeys.main.currentContext!,
              MaterialPageRoute(builder: (context) => BookFormPage()),
            );
            bloc.add(BookAdminGetBooksEvent());
          },
          backgroundColor: context.colors.primary.df,
          child: Icon(Icons.add, color: context.colors.primary.bg, size: 24),
        ),
      ),
      body: BlocConsumer<BookAdminBloc, BookAdminState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is BookAdminFailureState) {
            Alerts.showFailure(context, state.error);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Livros',
                    style: context.textStyles.display.hugeBold.copyWith(
                      color: context.colors.grayScale.header,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Builder(
                    builder: (context) {
                      if (state is BookAdminLoadingState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [const AppLoader()],
                        );
                      } else if (state is BookAdminLoadedState) {
                        return AppBookGridView(
                          books: state.books,
                          onTap: (book) async {
                            await AnalyticsService.logClickBook(book: book);
                            await Navigator.push(
                              NavigatorKeys.main.currentContext!,
                              MaterialPageRoute(
                                builder:
                                    (context) => BookDetailsPage(
                                      book: book,
                                      showFromAdminPage: true,
                                    ),
                              ),
                            );
                            bloc.add(BookAdminGetBooksEvent());
                          },
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
