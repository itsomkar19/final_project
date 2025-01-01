import 'dart:async';

import 'package:credbud/views/components/animations/lottie_animations_view.dart';
import 'package:credbud/views/components/loading/loading_screen_controller.dart';
import 'package:credbud/views/constants/strings.dart';
import 'package:flutter/material.dart';

import '../animations/models/lottie_animations.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({required BuildContext context, String text = Strings.loading}) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay(
      {required BuildContext context, required String text}) {
    final state = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (state == null) {
      return null;
    }

    final textController = StreamController<String>();
    textController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(150),
        child: Center(
           child: ClipRRect(
             borderRadius: BorderRadius.circular(size.width * 0.4), // Set radius based on width
             child: Container(
               decoration: const BoxDecoration(
                 color: Colors.white,
               ),
               child: SizedBox(
                 height: size.height*0.15,
                 width: size.height*0.15,
                 child: const LottieAnimationView(
                   animation: LottieAnimation.loading,
                   repeat: true,
                 ),
               ),
             ),
           ),
        ),
      );
    });

    state.insert(overlay);
    return LoadingScreenController(close: () {
      textController.close();
      overlay.remove();
      return true;
    }, update: (text) {
      textController.add(text);
      return true;
    });
  }
}
