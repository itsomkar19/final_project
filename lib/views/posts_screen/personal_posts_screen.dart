
import 'package:credbud/views/posts_screen/post_card.dart';
import 'package:credbud/views/posts_screen/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/animations/lottie_animations_view.dart';
import '../components/animations/models/lottie_animations.dart';

class PersonalPostsScreen extends ConsumerStatefulWidget {

  const PersonalPostsScreen({super.key});

  @override
  ConsumerState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<PersonalPostsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final personalPostsStream = ref.watch(personalPostsProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: AppColors.mauve.withAlpha(40),
        appBar: AppBar(
          title: const Text(
            "Your Posts",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // scrolledUnderElevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(personalPostsProvider.future);
          },
          child: personalPostsStream.when(
            data: (posts) => ListView.builder(
              controller: scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCardWithDelete(
                    data: post,
                    urlEndsWith:
                    post.imageUrl.substring(post.imageUrl.length - 4));
              },
            ),
            error: (error, stackTrace) => Padding(
                padding: const EdgeInsets.all(16),
                child: Center(child: Text('Error: $error'))),
            loading: () => Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const LottieAnimationView(
                    animation: LottieAnimation.loading,
                    repeat: true,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
