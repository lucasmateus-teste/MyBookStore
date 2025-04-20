import 'package:flutter/material.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/core/ui/widgets/app_book.dart';

class AppBookGridView extends StatefulWidget {
  const AppBookGridView({super.key, required this.books, required this.onTap});

  final List<BookModel> books;
  final ValueChanged<BookModel> onTap;

  @override
  State<AppBookGridView> createState() => _AppBookGridViewState();
}

class _AppBookGridViewState extends State<AppBookGridView> {
  static const itemHeight = 300.0;
  final appBarHeight = kBottomNavigationBarHeight;
  late final gridViewHeight =
      ((widget.books.length / 2).ceil() * itemHeight) + appBarHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gridViewHeight,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.5,
          mainAxisExtent: itemHeight,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          return GestureDetector(
            onTap: () => widget.onTap(book),
            child: SizedBox(height: itemHeight, child: AppBook(book: book)),
          );
        },
      ),
    );
  }
}
