
import 'package:credbud/state/auth/models/auth_result.dart';
import 'package:credbud/state/auth/providers/auth_state_provider.dart';
import 'package:credbud/state/providers/homescreen_navbar_provider.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/news_screen/news_home_screen.dart';
import 'package:credbud/views/profile_screen/profile_screen.dart';
import 'package:credbud/views/welcome_screen/welcome_screen_view.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../attendance_mark_screen/attendance_mark_screen.dart';
import '../create_post_screen/create_post_screen.dart';
import '../posts_screen/posts_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(authStateProvider, (_, authState) {
      switch (authState.result!) {
        case AuthResult.failure:
        //Ignore

        case AuthResult.aborted:
        //Ignore

        case AuthResult.success:
        //Ignore

        case AuthResult.loggedOut:
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const WelcomeScreenView()),
              (Route route) => false);

        case AuthResult.unknown:
        // Ignore
      }
    });

    final bodies = [
      PostsScreen(showNavbar, hideNavbar),
      const AttendanceMarkScreen(),
      const CreatePostScreen(),
      NewsScreen(showNavbar, hideNavbar),
      ProfileScreen(showNavbar, hideNavbar)
    ];
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);
    final visibilityBottomNavbar = ref.watch(visibilityBottomNavbarProvider);
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: const Text('CreBud: The Ultimate Student Platform'),
      // ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        height: visibilityBottomNavbar ? kBottomNavigationBarHeight + 45 : 0,
        child: Wrap(
          children: [
            DotNavigationBar(
              enablePaddingAnimation: true,
              splashColor: Colors.transparent,
              marginR: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              paddingR: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              backgroundColor: AppColors.mauve.withOpacity(0.35),
              currentIndex: indexBottomNavbar,
              onTap: (value) {
                ref
                    .read(indexBottomNavbarProvider.notifier)
                    .update((state) => value);
              },
              dotIndicatorColor: AppColors.blueRibbon,
              enableFloatingNavBar: true,
              items: [
                /// Posts Screen
                DotNavigationBarItem(
                  icon: const Icon(Icons.home),
                  selectedColor: AppColors.blueRibbon,
                  unselectedColor: AppColors.mauve,
                ),

                /// Attendance
                DotNavigationBarItem(
                  icon: const Icon(Icons.check_circle),
                  selectedColor: AppColors.blueRibbon,
                  unselectedColor: AppColors.mauve,
                ),

                /// Attendance
                DotNavigationBarItem(
                  icon: const Icon(Icons.add_circle_outlined),
                  selectedColor: AppColors.blueRibbon,
                  unselectedColor: AppColors.mauve,
                ),

                /// News
                DotNavigationBarItem(
                  icon: const Icon(Icons.newspaper_rounded),
                  selectedColor: AppColors.blueRibbon,
                  unselectedColor: AppColors.mauve,
                ),

                /// Profile
                DotNavigationBarItem(
                  icon: const Icon(Icons.person_2_rounded),
                  selectedColor: AppColors.blueRibbon,
                  unselectedColor: AppColors.mauve,
                ),
              ],
            )
          ],
        ),
      ),
      body: bodies[indexBottomNavbar],
    );
  }

  void hideNavbar() {
    ref.read(visibilityBottomNavbarProvider.notifier).update((state) => false);
  }

  void showNavbar() {
    ref.read(visibilityBottomNavbarProvider.notifier).update((state) => true);
  }
}
