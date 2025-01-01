
import 'package:credbud/state/attendance/providers/attendance_provider.dart';
import 'package:credbud/views/attendance_mark_screen/attendance_success_screen.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

import '../components/animated_slider/animated_slider.dart';

class ScannerView extends ConsumerStatefulWidget {
  const ScannerView({super.key});

  @override
  ConsumerState<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends ConsumerState<ScannerView> {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    useNewCameraSelector: true,
  );
  double _zoomFactor = 0.0;

  @override
  void initState() {
    super.initState();
    cameraController.start();
  }

  Widget _buildZoomScaleSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56.0),
      child: AnimatedSlider(
        value: _zoomFactor,
        onChange: (value) {
          setState(() {
            _zoomFactor = value;
            cameraController.setZoomScale(value);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MobileScanner(
          // fit: BoxFit.contain,
          controller: cameraController,
          fit: BoxFit.cover,
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;

            for (final barcode in barcodes) {
              print(barcode.rawValue);

              final rawValue = barcode.rawValue!;

              final resp = await ref
                  .read(attendanceRepositoryProvider)
                  .markAttendance(rawValue);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (ctx) => const AttendanceSuccessScreen()));

              if (resp['statusCode'] == 200) {
                cameraController.dispose();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const AttendanceSuccessScreen()));
              } else {
                const snackBar = SnackBar(
                  content: Text('Something went wrong :('),
                  backgroundColor: Colors.red,
                  dismissDirection: DismissDirection.horizontal,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
        ),
        QRScannerOverlay(
          imagePath: "assets/images/qr_overlay.png",
          scanAreaSize: const Size(250, 250),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                Strings.scanToMarkAttendance,
                style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.displayMedium?.fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 630,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildZoomScaleSlider(),
            const SizedBox(
              height: 120,
            )
          ],
        )
      ],
    ));
  }
}
