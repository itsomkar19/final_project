import 'package:credbud/state/news/backend/news_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../backend/news_pagination.dart';

final newsDevOpsPaginationControllerProvider =
    StateNotifierProvider<NewsDevOpsPaginationController, NewsPagination>(
        (ref) {
  final newsService = NewsService();
  return NewsDevOpsPaginationController(newsService);
});

class NewsDevOpsPaginationController extends StateNotifier<NewsPagination> {
  NewsDevOpsPaginationController(this._newsService, [NewsPagination? state])
      : super(state ?? NewsPagination.initial()) {
    getDevOpsArticles();
  }

  final NewsService _newsService;

  Future<void> getDevOpsArticles(
      {String queryParameters =
          'DevOps OR (continuous AND integration) OR (continuous AND deployment) OR CI/CD OR (infrastructure AND as AND code) OR containerization OR Docker OR Kubernetes OR automation OR deployment pipelines OR version control OR Git OR GitHub OR GitLab OR Bitbucket OR Jenkins OR Travis CI OR CircleCI OR TeamCity OR Ansible OR Puppet OR SRE OR microservices architecture OR serverless architecture OR cloud computing OR AWS OR Azure OR Google Cloud Platform OR GCP OR DevSecOps'}) async {
    try {
      print('getDevOpsArticles Called');
      final articles = await _newsService.fetchArticles(
          pageNumber: state.page, queryParameters: queryParameters);
      final uniqueArticles = {...state.articles, ...articles};
      state = state.copyWith(
          articles: uniqueArticles.toList(), page: state.page + 1);
      print('articles state getDevOpsArticles update');
    } catch (e) {
      print(e.toString());
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}
