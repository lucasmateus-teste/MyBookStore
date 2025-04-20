import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_back_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_confirmation_dialog.dart';
import 'package:my_book_store/src/core/ui/widgets/app_star_rating.dart';
import 'package:my_book_store/src/core/ui/widgets/app_toogle.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/features/books/admin/form/page/book_admin_form_page.dart';
import 'package:my_book_store/src/features/books/details/bloc/book_details_bloc.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({
    super.key,
    required this.book,
    required this.showFromAdminPage,
  });

  final BookModel book;
  final bool showFromAdminPage;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  BookModel get book => widget.book;
  late final bloc = getIt.get<BookDetailsBloc>(param1: book);

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookDetailsBloc, BookDetailsState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is BookDetailsFailureState) {
          Alerts.showFailure(context, state.error);
        } else if (state is BookDetailsDeletedState) {
          Navigator.pop(NavigatorKeys.main.currentContext!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Align(alignment: Alignment.topLeft, child: AppBackButton()),
                const SizedBox(height: 32),
                SizedBox(
                  height: 250,
                  child: Image.asset('assets/images/livro.png'),
                ),
                const SizedBox(height: 32),
                Text(state.book.title, style: TextStyles.i.display.mediumBold),
                const SizedBox(height: 8),
                Text(state.book.author, style: TextStyles.i.text.medium),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sinopse', style: TextStyles.i.link.small),
                    Text(state.book.synopsis, style: TextStyles.i.text.small),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Publicado em', style: TextStyles.i.link.small),
                        Text(
                          state.book.year.toString(),
                          style: TextStyles.i.text.small,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Avaliação', style: TextStyles.i.text.x),
                        AppStarRating(
                          initialRating:
                              int.tryParse(state.book.rating.toString()) ?? 0,
                          onRatingChanged: (value) {
                            bloc.add(
                              BookDetailsChangeRatingEvent(rating: value),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        AppToogle(
                          value: state.book.available,
                          onChanged: (value) {
                            bloc.add(BookDetailsChangeIsAvailableEvent());
                          },
                        ),
                        const SizedBox(width: 16),
                        Text('Estoque', style: TextStyles.i.text.small),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 72),
                Visibility(
                  visible: !widget.showFromAdminPage,
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onPressed: () {
                        bloc.add(BookDetailsChangeIsSavedEvent());
                      },
                      child: Text(
                        'Salvar',
                        style: TextStyles.i.link.small.copyWith(
                          color: context.colors.grayScale.bg,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.showFromAdminPage,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          onPressed: () async {
                            final result = await Navigator.push<BookModel>(
                              NavigatorKeys.main.currentContext!,
                              MaterialPageRoute(
                                builder: (context) => BookFormPage(book: book),
                              ),
                            );
                            if (result != null) {
                              bloc.add(BookDetailsBookChangedEvent(result));
                            }
                          },
                          child: Text(
                            'Editar',
                            style: context.textStyles.link.small.copyWith(
                              color: context.colors.grayScale.bg,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          AppConfirmationDialog.show(
                            context: NavigatorKeys.main.currentContext!,
                            content: Text.rich(
                              TextSpan(
                                text: 'Deseja deletar o livro\n',
                                style: context.textStyles.display.smallBold
                                    .copyWith(
                                      color: context.colors.grayScale.header,
                                    ),
                                children: [
                                  TextSpan(
                                    text: book.title,
                                    style: context.textStyles.display.smallBold
                                        .copyWith(
                                          color:
                                              context.colors.grayScale.header,
                                        ),
                                  ),
                                  TextSpan(
                                    text: ' ?',
                                    style: context.textStyles.display.smallBold
                                        .copyWith(
                                          color:
                                              context.colors.grayScale.header,
                                        ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onConfirm: () {
                              Navigator.pop(NavigatorKeys.main.currentContext!);
                              bloc.add(BookDetailsDeleteBookEvent(book));
                            },
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Excluir',
                              style: context.textStyles.link.small.copyWith(
                                color: context.colors.primary.df,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
