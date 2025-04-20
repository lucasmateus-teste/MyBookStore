import 'package:flutter/widgets.dart';

class BookModel {
  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.synopsis,
    required this.year,
    required this.rating,
    required this.available,
    this.isSaved = false,
    this.cover = '',
  });

  final int? id;
  final String title;
  final String author;
  final String synopsis;
  final int year;
  final int rating;
  final bool available;
  final bool isSaved;
  final String cover;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'synopsis': synopsis,
      'year': year,
      'rating': rating,
      'available': available,
      'cover': cover,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      synopsis: map['synopsis'] ?? '',
      year: map['year'] ?? 0,
      rating: map['rating'] ?? 0,
      available: map['available'] ?? false,
      cover: map['cover'] ?? '',
    );
  }

  BookModel copyWith({
    ValueGetter<int?>? id,
    String? title,
    String? author,
    String? synopsis,
    int? year,
    int? rating,
    bool? available,
    bool? isSaved,
    String? cover,
  }) {
    return BookModel(
      id: id != null ? id() : this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      synopsis: synopsis ?? this.synopsis,
      year: year ?? this.year,
      rating: rating ?? this.rating,
      available: available ?? this.available,
      isSaved: isSaved ?? this.isSaved,
      cover: cover ?? this.cover,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookModel &&
        other.id == id &&
        other.title == title &&
        other.author == author &&
        other.synopsis == synopsis &&
        other.year == year &&
        other.rating == rating &&
        other.available == available &&
        other.isSaved == isSaved &&
        other.cover == cover;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        synopsis.hashCode ^
        year.hashCode ^
        rating.hashCode ^
        available.hashCode ^
        isSaved.hashCode ^
        cover.hashCode;
  }
}
