import 'package:credbud/state/news/providers/news_data_science_pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../components/animations/lottie_animations_view.dart';
import '../components/animations/models/lottie_animations.dart';
import '../components/news/news_tile.dart';
import '../constants/app_colors.dart';

class NewsDataScienceScreen extends ConsumerStatefulWidget {
  const NewsDataScienceScreen({super.key});

  @override
  ConsumerState<NewsDataScienceScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsDataScienceScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        ref
            .read(newsDataSciencePaginationControllerProvider.notifier)
            .getDataScienceArticles();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginationController =
        ref.watch(newsDataSciencePaginationControllerProvider);
    final paginationState =
        ref.watch(newsDataSciencePaginationControllerProvider.notifier).state;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // extendBody: true,
        appBar: AppBar(
          title: const Text(
            'Skill Forge: DS & AI/ML',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        body: Builder(
          builder: (context) {
            if (paginationState.refreshError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong :(',
                      style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.fontSize),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: NeoPopButton(
                        color: AppColors.mauve,
                        bottomShadowColor: AppColors.cornflowerBlue,
                        rightShadowColor: AppColors.cornflowerBlue,
                        // animationDuration: kButtonAnimationDuration,
                        depth: 8,
                        onTapUp: () {
                          ref
                              .refresh(
                                  newsDataSciencePaginationControllerProvider
                                      .notifier)
                              .getDataScienceArticles();
                        },
                        onTapDown: () {
                          HapticFeedback.heavyImpact();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Refresh",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (paginationState.articles.isEmpty) {
              return Center(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
                child: const LottieAnimationView(
                  animation: LottieAnimation.loading,
                  repeat: true,
                ),
              ));
            }
            return RefreshIndicator(
              onRefresh: () {
                return ref
                    .refresh(
                        newsDataSciencePaginationControllerProvider.notifier)
                    .getDataScienceArticles();
              },
              child: ListView(
                controller: scrollController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paginationState.articles.length,
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl:
                            paginationState.articles[index].urlToImage ?? "",
                        title: paginationState.articles[index].title ?? "",
                        desc: paginationState.articles[index].description ?? "",
                        content: paginationState.articles[index].content ?? "",
                        articleUrl: paginationState.articles[index].url ?? "",
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
