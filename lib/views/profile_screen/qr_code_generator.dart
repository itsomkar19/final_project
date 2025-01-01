import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<Uint8List> generateQrCode(String data) async {
  try {
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode!,
      // color: Colors.black,
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    final picData = await painter.toImageData(2048);
    return picData!.buffer.asUint8List();
  } catch (e) {
    print(e.toString());
    return Uint8List(0);
  }
}

// Save QR Code Image to Gallery
Future<void> saveQrCodeImage({required String data}) async {
  final status = await Permission.manageExternalStorage.request();
  Uint8List qrCodeImage = await generateQrCode(data);
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/qrcode.jpg');
  await file.writeAsBytes(qrCodeImage);
  await OpenFile.open(file.path);
}
