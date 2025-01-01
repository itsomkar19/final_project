import 'package:credbud/state/auth/models/auth_result.dart';
import 'package:credbud/state/auth/models/auth_state.dart';
import 'package:credbud/state/auth/providers/auth_state_provider.dart';
import 'package:credbud/views/components/animations/lottie_animations_view.dart';
import 'package:credbud/views/components/animations/models/lottie_animations.dart';
import 'package:credbud/views/components/loading/loading_screen.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/constants/strings.dart';
import 'package:credbud/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (_, authState) {
      if (authState.result != null) {
        switch (authState.result!) {
          case AuthResult.failure:
            LoadingScreen.instance().hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authState.result!.message),
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 500),
              ),
            );
            ref.read(authStateProvider.notifier).updateAuthState(AuthState(
                result: AuthResult.unknown,
                isLoading: false,
                userId: authState.userId));

          case AuthResult.aborted:
            LoadingScreen.instance().hide();

          case AuthResult.success:
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (Route route) => false);
            LoadingScreen.instance().hide();

          case AuthResult.loggedOut:
          // Ignore
          case AuthResult.unknown:
          // Ignore
        }
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: const ClampingScrollPhysics(
          //     parent: NeverScrollableScrollPhysics()),
          child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  // const SizedBox(
                  //   height: 300,
                  //   child: LottieAnimationView(
                  //     animation: LottieAnimation.gradient,
                  //     repeat: true,
                  //   ),
                  // ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Opacity(
                        opacity: 0.75,
                        child: SizedBox(
                          height: 350,
                          child: LottieAnimationView(
                            animation: LottieAnimation.gradient,
                            repeat: true,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    Strings.hookLine,
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.fontSize),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 55,
                    // width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      // borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.1), // You can adjust the color and opacity here
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(
                              10, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: emailController,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'email@sinhgad.edu',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      // borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.1), // You can adjust the color and opacity here
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(
                              10, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: '* * * * * * * *',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: NeoPopButton(
                          color: AppColors.cornflowerBlue,
                          buttonPosition: Position.fullBottom,
                          depth: 10.0,
                          onTapUp: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              ref
                                  .read(authStateProvider.notifier)
                                  .signInWithEmail(
                                      email: emailController.text.toString(),
                                      password:
                                          passwordController.text.toString());
                              emailController.text = '';
                              passwordController.text = '';
                            }
                          },
                          onTapDown: () {
                            HapticFeedback.heavyImpact();
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 15.0),
                              child: Text(Strings.login,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: NeoPopButton(
                          color: AppColors.mauve,
                          buttonPosition: Position.fullBottom,
                          depth: 10.0,
                          onTapUp: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (emailController.text.isNotEmpty) {
                              ref
                                  .read(authStateProvider.notifier)
                                  .resetPassword(
                                      email: emailController.text.toString());
                              emailController.text = '';
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(Strings.snackBarResetPassword),
                                backgroundColor: Colors.green,
                                duration: Duration(milliseconds: 500),
                              ));
                            }
                          },
                          onTapDown: () {
                            HapticFeedback.heavyImpact();
                          },
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 15.0),
                              child: Text(
                                Strings.activateAccount,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
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
