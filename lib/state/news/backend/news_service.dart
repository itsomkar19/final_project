import 'package:credbud/state/news/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  final String apiKey = '45099c579b144a378f86a312c27feced';
  // 76f47c26382646c68d1076f552136674
  // b2f359f05de24f01af3b8db2888c2a1a
  // 45099c579b144a378f86a312c27feced
  // e0d128bbd8164346884a397825826eb3
  // 8922c63857fd49658fbc4a34d92dfb41
  // 37763cccde5346389d4bf8e1792a2bb1
  // 26e31cada05c4572982029fd9e327919
  List<NewsArticle> articles = [];
  NewsService();

  Future<List<NewsArticle>> fetchArticles(
      {int pageNumber = 1,
      String queryParameters =
          'coding OR devops OR ML OR AI OR (data AND science) OR algorithm OR (web AND development) OR (mobile AND development) OR (cloud AND computing) OR (version AND control) OR testing OR debugging OR Java OR Python OR JavaScript OR React OR Angular OR RUST OR Dart OR Flutter OR Vue OR React OR Svelte OR Django OR API OR software design OR automation OR (data AND analysis) OR NLP OR computer vision OR deep learning OR neural networks OR cybersecurity OR blockchain technology'}) async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$queryParameters&page=${pageNumber.toString()}&pageSize=100&apiKey=$apiKey"));
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    for (final item in data['articles']) {
      articles.add(NewsArticle.fromJson(item));
    }

    return articles;
  }
}
