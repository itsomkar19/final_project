import 'package:credbud/views/components/animations/lottie_animations_view.dart';
import 'package:credbud/views/components/animations/models/lottie_animations.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class GrantSheetSuccessScreen extends StatelessWidget {
  const GrantSheetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route route) => false);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LottieAnimationView(
                animation: LottieAnimation.success,
                repeat: false,
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                            (Route route) => false);
                  },
                  onTapDown: () {
                    HapticFeedback.heavyImpact();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Go back!",
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
        ),
      ),
    );
  }
}
