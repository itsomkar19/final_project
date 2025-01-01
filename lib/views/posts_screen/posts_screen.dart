import 'dart:ui';

import 'package:credbud/state/profile/providers/profile_providers.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/posts_screen/post_card.dart';
import 'package:credbud/views/posts_screen/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/animations/lottie_animations_view.dart';
import '../components/animations/models/lottie_animations.dart';

class PostsScreen extends ConsumerStatefulWidget {
  final VoidCallback showNavigation;
  final VoidCallback hideNavigation;

  const PostsScreen(this.showNavigation, this.hideNavigation, {super.key});

  @override
  ConsumerState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<PostsScreen> {
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
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
    final postsStream = ref.watch(postsProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
          // backgroundColor: AppColors.mauve.withAlpha(40),
          // appBar: AppBar(
          //   title: const Text(
          //     "Post",
          //     style: TextStyle(fontWeight: FontWeight.w600),
          //   ),
          //   centerTitle: true,
          //   // backgroundColor: Colors.transparent,
          //   // scrolledUnderElevation: 0,
          // ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.read(postsProvider.future);
            },
            child: postsStream.when(
              data: (posts) => ListView(
                controller: scrollController,
                children: [
                  GlassyAppBar(
                    userName:
                        ref.watch(profileStateProvider).valueOrNull?.name ??
                            'User',
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: posts.length,
                    controller: scrollController1,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return PostCard(
                          data: post,
                          urlEndsWith: post.imageUrl
                              .substring(post.imageUrl.length - 4));
                    },
                  ),
                ],
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
      ),
    );
  }
}

class GlassyAppBar extends StatelessWidget {
  final String userName;
  const GlassyAppBar({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: AppColors.cornflowerBlue.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        softWrap: true,
                        'Welcome to CredBud,',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        softWrap: true,
                        '$userName! 🚀✨',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Image.asset(
                  //   'assets/images/profile.png',
                  //   height: 45,
                  //   width: 45,
                  // ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 45,
                      width: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
