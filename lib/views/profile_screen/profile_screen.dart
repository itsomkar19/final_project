import 'package:credbud/state/auth/providers/auth_state_provider.dart';
import 'package:credbud/state/profile/models/profile_model.dart';
import 'package:credbud/state/profile/providers/profile_providers.dart';
import 'package:credbud/views/components/animations/models/lottie_animations.dart';
import 'package:credbud/views/posts_screen/personal_posts_screen.dart';
import 'package:credbud/views/profile_screen/cred_points_screen.dart';
import 'package:credbud/views/profile_screen/grant_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../components/animations/lottie_animations_view.dart';
import '../constants/app_colors.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final VoidCallback showNavigation;
  final VoidCallback hideNavigation;

  const ProfileScreen(this.showNavigation, this.hideNavigation, {super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  ScrollController scrollController = ScrollController();

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

  // bool checkGrantSheet(Map<String, List<int>> data) {
  //   // Iterate over each list and check if all elements are greater than 0
  //   for (List<int> list in data.values) {
  //     for (int value in list) {
  //       if (value <= 0) {
  //         return false; // If any value is <= 0, return false
  //       }
  //     }
  //   }
  //   return true; // All values are greater than 0
  // }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileStateProvider);
    return RefreshIndicator(
        onRefresh: () => ref.refresh(profileStateProvider.future),
        child: switch (profileState) {
          AsyncValue<Profile>(:final valueOrNull?) =>
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              child: SafeArea(
                bottom: false,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Profile',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    scrolledUnderElevation: 0,
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () async {
                            ref.read(authStateProvider.notifier).logOut();
                          },
                        ),
                      ),
                    ],
                  ),
                  body: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/images/profile.png',
                                    height: 90,
                                    width: 90,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Wrap(
                                            // space between chips
                                            spacing: 5,
                                            // list of chips
                                            children: [
                                              Chip(
                                                label: Text(valueOrNull.name),
                                                avatar: const Icon(
                                                  Icons
                                                      .drive_file_rename_outline,
                                                  color: AppColors.blueRibbon,
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              Chip(
                                                label: Text(valueOrNull.id),
                                                avatar:
                                                    const Icon(Icons.numbers),
                                                backgroundColor: AppColors.mauve
                                                    .withOpacity(0.6),
                                              ),
                                              Chip(
                                                label: Text(
                                                    'DIV ${valueOrNull.division}'),
                                                avatar: const Icon(
                                                  Icons.class_,
                                                  color: Colors.white,
                                                ),
                                                backgroundColor: AppColors
                                                    .cornflowerBlue
                                                    .withOpacity(0.6),
                                              ),
                                              Chip(
                                                label: Text(
                                                    'SEM ${valueOrNull.currentSem}'),
                                                avatar: const Icon(
                                                  Icons.bolt_outlined,
                                                  color:
                                                      AppColors.cornflowerBlue,
                                                ),
                                                backgroundColor: AppColors
                                                    .blueRibbon
                                                    .withOpacity(0.25),
                                              ),
                                              Chip(
                                                label: Text(
                                                    'DEPT ${valueOrNull.department}'),
                                                avatar: const Icon(
                                                  Icons.category,
                                                  color: AppColors.blueRibbon,
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              Chip(
                                                label: Text(
                                                    '+91 ${valueOrNull.contact}'),
                                                avatar: const Icon(
                                                  Icons.phone,
                                                  color: AppColors.blueRibbon,
                                                ),
                                                backgroundColor: AppColors.mauve
                                                    .withOpacity(0.6),
                                              ),
                                              Chip(
                                                label: Text(valueOrNull
                                                    .admissionYear
                                                    .toString()),
                                                avatar: const Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.white,
                                                ),
                                                backgroundColor: AppColors
                                                    .cornflowerBlue
                                                    .withOpacity(0.6),
                                              ),
                                              Chip(
                                                label: Text(
                                                    'CGPA ${valueOrNull.cgpa}'),
                                                avatar: const Icon(
                                                  Icons.calendar_month,
                                                  color:
                                                      AppColors.cornflowerBlue,
                                                ),
                                                backgroundColor: AppColors
                                                    .blueRibbon
                                                    .withOpacity(0.25),
                                              ),
                                              Chip(
                                                label: Text(valueOrNull.email),
                                                avatar: const Icon(
                                                  Icons.alternate_email,
                                                  color: AppColors.blueRibbon,
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                            ])
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            // print('cred points pressed');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CredPointsScreen()));
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('CredPoints',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height: 65,
                                                  width: 65,
                                                  child: Image.asset(
                                                      'assets/images/coin.png')),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                  valueOrNull.credPoints.balance
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 45,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 35,
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            // print('cred points pressed');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalPostsScreen()));
                          },
                          child: const Card(
                            elevation: 5,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Posts',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500))),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text('Manage your posts 📸',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900)),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 35,
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: NeoPopButton(
                                color: AppColors.mauve,
                                bottomShadowColor: AppColors.cornflowerBlue,
                                rightShadowColor: AppColors.cornflowerBlue,
                                depth: 8,
                                onTapUp: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              const GrantSheetScreen()));
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
                                      Text("Grant Sheet",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // An error is available, so we render it.
          AsyncValue(:final error?) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text('Error: $error'),
              ),
            ),
          // No data/error, so we're in loading state.
          _ => Center(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: const LottieAnimationView(
                animation: LottieAnimation.loading,
                repeat: true,
              ),
            )),
        });
  }
}
