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
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_search_field.dart';
import 'package:my_book_store/src/core/ui/widgets/app_star_rating.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';
import 'package:my_book_store/src/core/ui/widgets/app_toogle.dart';
import 'package:my_book_store/src/core/ui/widgets/app_book_grid_view.dart';
import 'package:my_book_store/src/core/ui/widgets/app_books_list_view.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';
import 'package:my_book_store/src/features/home/bloc/home_bloc.dart';
import 'package:my_book_store/src/services/analytics_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});

  final UserModel user;
  // final HomeBloc homeBloc;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = getIt.get<HomeBloc>();

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  showFilterBottomSheet() {
    showModalBottomSheet(
      context: NavigatorKeys.main.currentContext!,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.grayScale.bg,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'Filtrar',
                        style: context.textStyles.display.smallBold,
                      ),
                      Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context); // Fecha o BottomSheet
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                AppTextInput(labelText: 'Filtrar por título'),
                const SizedBox(height: 16),
                AppTextInput(labelText: 'Filtrar por autor'),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Avaliação', style: context.textStyles.text.x),
                    AppStarRating(
                      initialRating: 0,
                      onRatingChanged: (value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status', style: context.textStyles.text.x),
                    AppToogle(
                      value: true,
                      onChanged: (value) {},
                      label: 'Estoque',
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    child: Text(
                      'Filtrar',
                      style: context.textStyles.link.small.copyWith(
                        color: context.colors.grayScale.bg,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeBloc.add(HomeGetBooks());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBockStoreIcon(size: Size(56, 42), withLabel: false),
            const SizedBox(height: 24),
            Text(
              'Olá, ${widget.user.name}',
              style: context.textStyles.display.hugeBold.copyWith(
                color: context.colors.grayScale.header,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: AppSearchField(
                    hintText: 'Buscar',
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    showFilterBottomSheet();
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                ),
              ],
            ),
            const SizedBox(height: 40),
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeFailure) {
                  Alerts.showFailure(context, state.error);
                }
              },
              bloc: homeBloc,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const AppLoader();
                } else if (state is HomeLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Livros Salvos',
                        style: context.textStyles.link.large.copyWith(
                          color: context.colors.grayScale.header,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppBooksListView(
                        books: state.savedBooks,
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

                          homeBloc.add(HomeGetBooks());
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Todos os Livros',
                        style: context.textStyles.link.large.copyWith(
                          color: context.colors.grayScale.header,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppBookGridView(
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

                          homeBloc.add(HomeGetBooks());
                        },
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
