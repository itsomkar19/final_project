import 'package:credbud/state/news/backend/news_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../backend/news_pagination.dart';

final newsWebDevelopmentPaginationControllerProvider = StateNotifierProvider<
    NewsWebDevelopmentPaginationController, NewsPagination>((ref) {
  final newsService = NewsService();
  return NewsWebDevelopmentPaginationController(newsService);
});

class NewsWebDevelopmentPaginationController
    extends StateNotifier<NewsPagination> {
  NewsWebDevelopmentPaginationController(this._newsService,
      [NewsPagination? state])
      : super(state ?? NewsPagination.initial()) {
    getWebDevelopmentArticles();
  }

  final NewsService _newsService;

  Future<void> getWebDevelopmentArticles(
      {String queryParameters =
          'web OR development OR frontend OR backend OR full-stack OR HTML OR CSS OR JavaScript OR TypeScript OR React OR Angular OR Vue OR Node.js OR Express OR Django OR Flask OR (Ruby AND on AND Rails) OR Laravel OR ASP.NET OR Spring OR Bootstrap OR jQuery OR Sass OR WebAssembly OR WebRTC OR GraphQL OR RESTful OR API OR microservices OR serverless OR (Progressive AND Web AND Apps) OR PWA OR (responsive AND design) OR (web AND design) OR UX OR UI OR HTTPS'}) async {
    try {
      print('getWebDevelopmentArticles Called');
      final articles = await _newsService.fetchArticles(
          pageNumber: state.page, queryParameters: queryParameters);
      final uniqueArticles = {...state.articles, ...articles};
      state = state.copyWith(
          articles: uniqueArticles.toList(), page: state.page + 1);
      print('articles state getWebDevelopmentArticles update');
    } catch (e) {
      print(e.toString());
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
