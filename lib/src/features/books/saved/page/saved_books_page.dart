import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_bock_store_icon.dart';
import 'package:my_book_store/src/core/ui/widgets/app_loader.dart';
import 'package:my_book_store/src/features/books/details/page/book_details_page.dart';
import 'package:my_book_store/src/core/ui/widgets/app_book_grid_view.dart';
import 'package:my_book_store/src/features/books/saved/bloc/saved_books_bloc.dart';
import 'package:my_book_store/src/services/analytics_service.dart';

class SavedBooksPage extends StatefulWidget {
  const SavedBooksPage({super.key});

  @override
  State<SavedBooksPage> createState() => _SavedBooksPageState();
}

class _SavedBooksPageState extends State<SavedBooksPage> {
  late final bloc = getIt.get<SavedBooksBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(SavedBooksGetBooksEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              AppBockStoreIcon(size: Size(56, 42), withLabel: false),
              const SizedBox(height: 24),
              Text(
                'Livros Salvos',
                style: context.textStyles.display.hugeBold.copyWith(
                  color: context.colors.grayScale.header,
                ),
              ),
              const SizedBox(height: 32),
              BlocConsumer<SavedBooksBloc, SavedBooksState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is SavedBooksFailureState) {
                    Alerts.showFailure(context, state.error);
                  }
                },
                builder: (context, state) {
                  if (state is SavedBooksLoadingState) {
                    return const AppLoader();
                  } else if (state is SavedBooksLoadedState) {
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
                                  showFromAdminPage: false,
                                ),
                          ),
                        );
                        bloc.add(SavedBooksGetBooksEvent());
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
