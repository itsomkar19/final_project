import 'package:credbud/views/components/animations/lottie_animations_view.dart';
import 'package:credbud/views/components/animations/models/lottie_animations.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/constants/strings.dart';
import 'package:credbud/views/login_screen/login_screen.dart';
import 'package:credbud/views/welcome_screen/divider_with_margins.dart';
import 'package:credbud/views/welcome_screen/welcome_screen_privacy_policy_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';

class WelcomeScreenView extends ConsumerWidget {
  const WelcomeScreenView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              transform: GradientRotation(0),
              stops: [0.001, 0.7],
              colors: AppColors.welcomeLinearGradientColors,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Strings.welcomeTo,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.fontSize)),
                Text('${Strings.appName}!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.displayMedium?.fontSize,
                    )),
                const ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.85,
                    child: LottieAnimationView(
                      animation: LottieAnimation.collaborating,
                      repeat: true,
                    ),
                  ),
                ),
                const DividerWithMargins(),
                Text(
                  Strings.letsGetStarted,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(height: 1.5),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: NeoPopTiltedButton(
                        isFloating: true,
                        onTapUp: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => LoginScreen()));
                        },
                        onTapDown: () {
                          HapticFeedback.heavyImpact();
                        },
                        decoration: const NeoPopTiltedButtonDecoration(
                          color: AppColors.welcomeButtonColor,
                          plunkColor: AppColors.welcomeButtonColor,
                          shadowColor: AppColors.welcomeButtonShadowColor,
                          showShimmer: true,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70.0,
                            vertical: 15,
                          ),
                          child: Center(
                              child: Text(
                            Strings.continueButton,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                const DividerWithMargins(),
                const WelcomeScreenPrivacyPolicyLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
