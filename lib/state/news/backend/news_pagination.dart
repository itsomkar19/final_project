
import 'package:flutter/foundation.dart';

import '../models/news_model.dart';

class NewsPagination {
  final List<NewsArticle> articles;
  final int page;
  final String errorMessage;

  NewsPagination({
    required this.articles,
    required this.page,
    required this.errorMessage,
  });

  NewsPagination.initial(): articles = [], page = 1, errorMessage = '';

  bool get refreshError => errorMessage != '' && articles.length <= 10;

  NewsPagination copyWith({
    List<NewsArticle>? articles,
    int? page,
    String? errorMessage,
  }) {
    return NewsPagination(
      articles: articles ?? this.articles,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsPagination &&
        listEquals(other.articles, articles) &&
        other.page == page &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => articles.hashCode ^ page.hashCode ^ errorMessage.hashCode;
}