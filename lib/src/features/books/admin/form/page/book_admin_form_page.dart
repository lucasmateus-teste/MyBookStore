import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_header.dart';
import 'package:my_book_store/src/core/ui/widgets/app_tab.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/features/books/admin/form/bloc/book_admin_form_bloc.dart';
import 'package:my_book_store/src/features/books/admin/form/widgets/book_design_form.dart';
import 'package:my_book_store/src/features/books/admin/form/widgets/book_details_form.dart';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key, this.book});

  final BookModel? book;

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  int _currentPage = 0;
  late final controller = PageController(initialPage: _currentPage);
  late final TextEditingController titleController;
  late final TextEditingController authorController;
  late final TextEditingController synopsisController;
  late final TextEditingController dateController;
  late int rating = widget.book?.rating ?? 0;
  late bool isAvailable = widget.book?.available ?? false;
  String? imageBase64;

  late final bloc = getIt.get<BookAdminFormBloc>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book?.title);
    authorController = TextEditingController(text: widget.book?.author);
    synopsisController = TextEditingController(text: widget.book?.synopsis);
    dateController = TextEditingController(text: widget.book?.year.toString());
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    synopsisController.dispose();
    dateController.dispose();
    controller.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: SizedBox(
            width: double.infinity,
            child: AppButton(
              child: Text(
                'Salvar',
                style: context.textStyles.link.small.copyWith(
                  color: context.colors.grayScale.bg,
                ),
              ),
              onPressed: () {
                if (widget.book != null) {
                  final book = widget.book!.copyWith(
                    title: titleController.text,
                    author: authorController.text,
                    synopsis: synopsisController.text,
                    year: int.tryParse(dateController.text) ?? 0,
                    rating: rating,
                    available: isAvailable,
                    cover: imageBase64,
                  );
                  bloc.add(BookAdminFormUpdateEvent(book: book));
                } else {
                  final book = BookModel(
                    title: titleController.text,
                    author: authorController.text,
                    synopsis: synopsisController.text,
                    year: int.tryParse(dateController.text) ?? 0,
                    rating: rating,
                    available: isAvailable,
                    cover: imageBase64 ?? '',
                  );
                  bloc.add(BookAdminFormCreateEvent(book: book));
                }
              },
            ),
          ),
        ),
      ],
      body: BlocListener<BookAdminFormBloc, BookAdminFormState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is BookAdminFormUpdatedState) {
            Alerts.showSuccess(context, 'Livro atualizado com sucesso!');
            Navigator.pop(NavigatorKeys.main.currentContext!, state.book);
          } else if (state is BookAdminFormCreatedState) {
            Alerts.showSuccess(context, 'Livro cadastrado com sucesso!');
            Navigator.pop(NavigatorKeys.main.currentContext!, state.book);
          } else if (state is BookAdminFormFailureState) {
            Alerts.showFailure(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                AppHeader(
                  title:
                      widget.book == null
                          ? 'Cadastro de Livro'
                          : 'Editar Livro',
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTab(
                      label: 'Dados do Livro',
                      isSelected: _currentPage == 0,
                      onPressed: () {
                        setState(() {
                          _currentPage = 0;
                          controller.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        });
                      },
                    ),
                    AppTab(
                      label: 'Design do Livro',
                      isSelected: _currentPage == 1,
                      onPressed: () {
                        setState(() {
                          _currentPage = 1;
                          controller.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 800,
                  child: PageView(
                    controller: controller,
                    children: [
                      BookDetailsForm(
                        formKey: GlobalKey<FormState>(),
                        titleController: titleController,
                        authorController: authorController,
                        synopsisController: synopsisController,
                        dateController: dateController,
                        rating: rating,
                        isAvailable: isAvailable,
                        onRatingChanged: (value) {
                          rating = value;
                        },
                        onStatusChanged: (value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),
                      BookDesignForm(
                        imageBase64: imageBase64,
                        onImageChanged: (value) => imageBase64 = value,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
