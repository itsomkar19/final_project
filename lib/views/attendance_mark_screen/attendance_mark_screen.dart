import 'package:credbud/views/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/animations/lottie_animations_view.dart';
import '../components/animations/models/lottie_animations.dart';
import '../welcome_screen/divider_with_margins.dart';
import 'attendance_qr_scan_screen.dart';

class AttendanceMarkScreen extends ConsumerWidget {
  const AttendanceMarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'The Attendance Gate',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text('Tap below to Scan QR code',
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontSize,
                        fontWeight: FontWeight.w800)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScannerView(),
                      ),
                    );
                  },
                  child: Center(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          height: 240,
                          width: 240,
                          child:
                              Image.asset('assets/images/qr_code_credbud.png')),
                      const LottieAnimationView(
                        animation: LottieAnimation.qrScan,
                        repeat: true,
                      ),
                    ],
                  )),
                ),
                Row(
                  children: [
                    const Expanded(child: DividerWithMargins()),
                    Text(
                      'or',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Expanded(child: DividerWithMargins())
                  ],
                ),
                Container(
                  height: 55,
                  // width: MediaQuery.of(context).size.width / 2.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.1), // You can adjust the color and opacity here
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset:
                            const Offset(10, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    // controller: emailController,
                    // focusNode: _emailFocusNode,
                    // onFieldSubmitted: (value) {
                    //   FocusScope.of(context).requestFocus(_passwordFocusNode);
                    // },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        hintText: 'enter CQID',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.numbers,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            print('button working');

                            // final resp = await ref.read(attendanceRepositoryProvider).markAttendance('COMPUTER539', '80087');
                            // print(resp['data']['message']);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.malibu.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: const Icon(Icons.navigate_next)),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
