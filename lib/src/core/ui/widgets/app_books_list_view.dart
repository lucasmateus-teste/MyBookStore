import 'package:flutter/material.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/core/ui/widgets/app_book.dart';

class AppBooksListView extends StatefulWidget {
  const AppBooksListView({super.key, required this.books, required this.onTap});

  final List<BookModel> books;
  final void Function(BookModel book) onTap;

  @override
  State<AppBooksListView> createState() => _AppBooksListViewState();
}

class _AppBooksListViewState extends State<AppBooksListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.books.isEmpty ? 0 : 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.books.length,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final book = widget.books[index];
          return SizedBox(
            width: (MediaQuery.of(context).size.width / 2) - 36,
            child: GestureDetector(
              child: AppBook(book: book),
              onTap: () {
                widget.onTap(book);
              },
            ),
          );
        },
      ),
    );
  }
}
