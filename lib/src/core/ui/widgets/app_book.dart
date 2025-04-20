import 'package:flutter/material.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

class AppBook extends StatefulWidget {
  const AppBook({super.key, required this.book});

  final BookModel book;

  @override
  State<AppBook> createState() => _AppBookState();
}

class _AppBookState extends State<AppBook> {
  BookModel get book => widget.book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/livro.png', height: 215, fit: BoxFit.fill),
        const SizedBox(height: 16),
        Text(
          book.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Text(
          book.author,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Row(
          children: [
            Icon(Icons.star_border_outlined),
            const SizedBox(width: 8),
            Text(
              book.rating.toString(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
