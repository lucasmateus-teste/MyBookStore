import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:my_book_store/src/data/models/book_model.dart';

class AnalyticsService {
  static Future<void> logClickBook({required BookModel book}) async {
    return FirebaseAnalytics.instance.logEvent(
      name: 'click_book',
      parameters: {'id': book.id!, 'title': book.title},
    );
  }
}
