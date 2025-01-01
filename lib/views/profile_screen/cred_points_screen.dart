import 'dart:ui';

import 'package:credbud/state/profile/providers/profile_providers.dart';
import 'package:credbud/views/components/animations/lottie_animations_view.dart';
import 'package:credbud/views/components/animations/models/lottie_animations.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CredPointsScreen extends ConsumerStatefulWidget {
  const CredPointsScreen({super.key});

  @override
  ConsumerState createState() => _CredPointsScreenState();
}

class _CredPointsScreenState extends ConsumerState<CredPointsScreen> {
  String formatDataFromMilliseconds(int seconds, int nanoseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + (nanoseconds / 1000000).round());

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileStateProvider);

    return profileState.when(
        data: (profile) => AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Manage CredPoints',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
                  // backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                ),
                floatingActionButton: FloatingActionButton.large(
                    onPressed: () {},
                    child: const Icon(Icons.shopping_cart_rounded)),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                body: Column(
                  children: [
                    GlassyCredPointsDisplay(
                      balance: profile.credPoints.balance,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: <Widget>[
                            const TabBar(
                              tabs: [
                                Tab(text: 'Gained'),
                                Tab(text: 'Redeem'),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  ListView.builder(
                                      itemCount: profile
                                          .credPoints.profitHistory.length,
                                      itemBuilder: (context, index) {
                                        return CredPointsItem(
                                          date: formatDataFromMilliseconds(
                                              profile
                                                  .credPoints
                                                  .profitHistory[index]
                                                  .date
                                                  .seconds,
                                              profile
                                                  .credPoints
                                                  .profitHistory[index]
                                                  .date
                                                  .nanoseconds),
                                          source: profile.credPoints
                                              .profitHistory[index].task,
                                          points: profile.credPoints
                                              .profitHistory[index].amount,
                                          isRedeem: false,
                                        );
                                      }),
                                  ListView.builder(
                                      itemCount: profile
                                          .credPoints.redeemHistory.length,
                                      itemBuilder: (context, index) {
                                        return CredPointsItem(
                                          date: formatDataFromMilliseconds(
                                              profile
                                                  .credPoints
                                                  .redeemHistory[index]
                                                  .date
                                                  .seconds,
                                              profile
                                                  .credPoints
                                                  .redeemHistory[index]
                                                  .date
                                                  .nanoseconds),
                                          source: profile.credPoints
                                              .redeemHistory[index].task,
                                          points: profile.credPoints
                                              .redeemHistory[index].amount,
                                          isRedeem: true,
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => Center(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              child: const LottieAnimationView(
                animation: LottieAnimation.loading,
                repeat: true,
              ),
            )));
  }
}

class CredPointsItem extends StatelessWidget {
  final String date;
  final String source;
  final int points;
  final bool isRedeem;

  const CredPointsItem(
      {super.key,
      required this.date,
      required this.source,
      required this.points,
      this.isRedeem = false});

  @override
  Widget build(BuildContext context) {
    Color textColor = isRedeem ? Colors.red : Colors.green;
    String sign = isRedeem ? '-' : '+';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: textColor,
        child: Text(sign, style: TextStyle(color: Colors.white)),
      ),
      title: Text(date),
      subtitle: Text(
        source,
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
      trailing: Text('$sign$points',
          style: TextStyle(color: textColor, fontSize: 18)),
    );
  }
}

class GlassyCredPointsDisplay extends StatelessWidget {
  final int balance;
  const GlassyCredPointsDisplay({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Balance: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    balance.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/images/coin.png',
                    height: 45,
                    width: 45,
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
