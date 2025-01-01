import 'package:credbud/state/news/backend/news_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../backend/news_pagination.dart';

final newsDataSciencePaginationControllerProvider =
StateNotifierProvider<NewsDataSciencePaginationController, NewsPagination>((ref) {
  final newsService = NewsService();
  return NewsDataSciencePaginationController(newsService);
});

class NewsDataSciencePaginationController extends StateNotifier<NewsPagination> {
  NewsDataSciencePaginationController(this._newsService, [NewsPagination? state])
      : super(state ?? NewsPagination.initial()) {
    getDataScienceArticles();
  }

  final NewsService _newsService;

  Future<void> getDataScienceArticles(
      {String queryParameters =
      '(machine AND learning) OR (artificial AND intelligence) OR (data AND science) OR NLP OR (computer AND vision) OR deep OR (neural AND networks) OR classification OR clustering OR predictive OR modeling OR SVM OR LSTM OR GAN OR LLM OR (generative AND AI) OR reinforcement OR Bayesian OR k-means OR time-series OR analysis OR Q-learning OR object OR sentiment OR mining OR chatbots OR robotics OR preprocessing OR visualization OR EDA OR integration OR warehousing OR (data AND analytics)'}) async {
    try {
      print('getArticles DataScience AI ML Called');
      final articles = await _newsService.fetchArticles(
          pageNumber: state.page, queryParameters: queryParameters);
      final uniqueArticles = {...state.articles, ...articles};
      state = state.copyWith(
          articles: uniqueArticles.toList(), page: state.page + 1);
      print('articles state DataScience AI ML update');
    } catch (e) {
      print(e.toString());
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
