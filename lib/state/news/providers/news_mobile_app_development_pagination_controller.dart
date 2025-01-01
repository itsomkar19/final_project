import 'package:credbud/state/news/backend/news_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../backend/news_pagination.dart';

final newsMobileAppDevelopmentPaginationControllerProvider =
    StateNotifierProvider<NewsMobileAppDevelopmentPaginationController,
        NewsPagination>((ref) {
  final newsService = NewsService();
  return NewsMobileAppDevelopmentPaginationController(newsService);
});

class NewsMobileAppDevelopmentPaginationController
    extends StateNotifier<NewsPagination> {
  NewsMobileAppDevelopmentPaginationController(this._newsService,
      [NewsPagination? state])
      : super(state ?? NewsPagination.initial()) {
    getMobileAppDevelopmentArticles();
  }

  final NewsService _newsService;

  Future<void> getMobileAppDevelopmentArticles(
      {String queryParameters =
          '(mobile AND application AND development) OR iOS OR Android OR Swift OR Kotlin OR Java OR (React AND Native) OR Flutter OR Xamarin OR Firebase OR MBaaS OR push notifications OR (in-app AND purchases)'}) async {
    try {
      print('getMobileAppDevelopmentArticles Called');
      final articles = await _newsService.fetchArticles(
          pageNumber: state.page, queryParameters: queryParameters);
      final uniqueArticles = {...state.articles, ...articles};
      state = state.copyWith(
          articles: uniqueArticles.toList(), page: state.page + 1);
      print('articles state getMobileAppDevelopmentArticles update');
    } catch (e) {
      print(e.toString());
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
