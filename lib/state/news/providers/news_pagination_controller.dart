import 'package:credbud/state/news/backend/news_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../backend/news_pagination.dart';

final newsPaginationControllerProvider =
    StateNotifierProvider<NewsPaginationController, NewsPagination>((ref) {
  final newsService = NewsService();
  return NewsPaginationController(newsService);
});

class NewsPaginationController extends StateNotifier<NewsPagination> {
  NewsPaginationController(this._newsService, [NewsPagination? state])
      : super(state ?? NewsPagination.initial()) {
    getArticles();
  }

  final NewsService _newsService;

  // Future<void> getArticles() async {
  //   try {
  //     print('called from news pagination controller');
  //     final articles = await _newsService.fetchArticles(state.page);
  //     state = state.copyWith(
  //         articles: [...state.articles, ...articles], page: state.page + 1);
  //     print('articles state update');
  //   } catch (e) {
  //     print(e.toString());
  //     state = state.copyWith(errorMessage: e.toString());
  //   }
  // }
  Future<void> getArticles(
      {String queryParameters =
          'coding OR devops OR ML OR AI OR (data AND science) OR algorithm OR (web AND development) OR (mobile AND development) OR (cloud AND computing) OR (version AND control) OR testing OR debugging OR Java OR Python OR JavaScript OR React OR Angular OR RUST OR Dart OR Flutter OR Vue OR React OR Svelte OR Django OR API OR software design OR automation OR (data AND analysis) OR NLP OR computer vision OR deep learning OR neural networks OR cybersecurity OR blockchain technology'}) async {
    try {
      print('getArticles Called');
      final articles = await _newsService.fetchArticles(
          pageNumber: state.page, queryParameters: queryParameters);
      final uniqueArticles = {...state.articles, ...articles};
      state = state.copyWith(
          articles: uniqueArticles.toList(), page: state.page + 1);
      print('articles state update');
    } catch (e) {
      print(e.toString());
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
