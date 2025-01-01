import 'package:credbud/state/news/providers/news_pagination_controller.dart';
import 'package:credbud/views/news_screen/news_data_science_screen.dart';
import 'package:credbud/views/news_screen/news_mobile_app_development_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../components/animations/lottie_animations_view.dart';
import '../components/animations/models/lottie_animations.dart';
import '../components/news/news_tile.dart';
import '../constants/app_colors.dart';
import 'news_devops_screen.dart';
import 'news_web_development_screen.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen(this.showNavigation, this.hideNavigation, {super.key});

  final VoidCallback showNavigation;
  final VoidCallback hideNavigation;

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        ref.read(newsPaginationControllerProvider.notifier).getArticles();
      }

      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        widget.showNavigation();
      } else {
        widget.hideNavigation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginationController = ref.watch(newsPaginationControllerProvider);
    final paginationState =
        ref.watch(newsPaginationControllerProvider.notifier).state;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          // extendBody: true,
          appBar: AppBar(
            title: const Text(
              'The Skill Forge',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
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
                                    newsPaginationControllerProvider.notifier)
                                .getArticles();
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
                      .refresh(newsPaginationControllerProvider.notifier)
                      .getArticles();
                },
                child: ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 5.0,
                        children: [
                          ActionChip(
                            avatar: const Icon(Icons.settings),
                            backgroundColor: AppColors.malibu,
                            label: const Text('Data Science & AI/ML'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const NewsDataScienceScreen()));
                            },
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.web_sharp),
                            backgroundColor: AppColors.mauve,
                            label: const Text('Web Development'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          const NewsWebDevelopmentScreen()));
                            },
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.android),
                            backgroundColor: AppColors.mauve,
                            label: const Text('Mobile App Development'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                      const NewsMobileAppDevelopmentScreen()));
                            },
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.cloud_done),
                            backgroundColor: AppColors.malibu,
                            label: const Text('DevOps'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                      const NewsDevOpsScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paginationState.articles.length,
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl:
                              paginationState.articles[index].urlToImage ?? "",
                          title: paginationState.articles[index].title ?? "",
                          desc:
                              paginationState.articles[index].description ?? "",
                          content:
                              paginationState.articles[index].content ?? "",
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
      ),
    );
  }
}
