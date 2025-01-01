// import 'dart:io';
// import 'package:credbud/views/profile_screen/qr_code_generator.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../state/profile/models/profile_model.dart';
//
// String formatDataFromMilliseconds(int seconds, int nanoseconds) {
//   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
//       seconds * 1000 + (nanoseconds / 1000000).round());
//
//   String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
//   return formattedDate;
// }
//
// Map<String, String> evaluateAssignments(Map<String, List<int>> assignmentData) {
//
//   final assignmentEvaluationMap = <String, String>{'Subject': 'Completed'};
//
//   for (final entry in assignmentData.entries) {
//     final key = entry.key;
//     final assignments = entry.value;
//
//     // Check if all assignments are greater than 0
//     final allPositive = assignments.every((element) => element > 0);
//
//     assignmentEvaluationMap[key] = allPositive ? 'Yes' : 'No';
//   }
//
//   return assignmentEvaluationMap;
// }
//
// List<List<String>> processUTDataForTable(Map<String, UTSubject> utData) {
//   final tableData = <List<String>>[
//     ['Subject'], // Name
//     ['Marks'], // Marks
//     ['Status'], // Status
//   ];
//
//   // Add data for each category
//   for (final entry in utData.entries) {
//     final subject = entry.value;
//     tableData[0].add(subject.name);
//     tableData[1].add(subject.marks.toString());
//     tableData[2].add(subject.status);
//   }
//
//   return tableData;
// }
//
// List<List<String>> processPrelimDataForTable(
//     Map<String, PrelimSubject> prelimData) {
//   final tableData = <List<String>>[
//     ['Subject'], // Name
//     ['Marks'], // Marks
//     ['Status'], // Status
//   ];
//
//   // Add data for each category
//   for (final entry in prelimData.entries) {
//     final subject = entry.value;
//     tableData[0].add(subject.name);
//     tableData[1].add(subject.marks.toString());
//     tableData[2].add(subject.status);
//   }
//
//   return tableData;
// }
//
// Future<void> generateAndOpenPDF(
//     Profile profile,
//     Map<String, String> assignmentsData,
//     List<List<String>> utData,
//     List<List<String>> prelimData) async {
//   final pdf = pw.Document();
//
//   String qrData = '{"uid":"${profile.id}","sem":${profile.currentSem}}';
//   final qrImageData = await generateQrCode(qrData);
//   final qrImage = pw.MemoryImage(qrImageData);
//
//   final imageData = await rootBundle.load(
//       'assets/images/sinhgad_logo.png'); // Replace 'your_image.png' with the actual image path
//   // final image = PdfImage.file(
//   //   pdf.document,
//   //   bytes: imageData.buffer.asUint8List(),
//   // );
//
//   final image = pw.MemoryImage(
//     imageData.buffer.asUint8List(),
//   );
//
//   // Assignments Table
//   final assignmentsTable = pw.TableHelper.fromTextArray(data: <List<String>>[
//     [...assignmentsData.keys],
//     [...assignmentsData.values],
//   ], cellAlignment: pw.Alignment.center);
//
//   // Unit Tests Table
//   final utTable = pw.TableHelper.fromTextArray(
//       data: utData, cellAlignment: pw.Alignment.center);
//
//   // Prelims Table
//   final prelimsTable = pw.TableHelper.fromTextArray(
//       data: prelimData, cellAlignment: pw.Alignment.center);
//
//   // Extras Table
//   // ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//   final feeClearanceData =
//       profile.grantProfileExtras.entries.elementAt(7).value.feeClearance;
//   final nptelData = profile.grantProfileExtras.entries.elementAt(7).value.nptel;
//
//   final List<List<String>> extrasData = [
//     ['Fee Clearance', feeClearanceData.toString()],
//     ['NPTEL', nptelData.toString()],
//   ];
//
//   final extrasTable = pw.TableHelper.fromTextArray(
//       data: extrasData, cellAlignment: pw.Alignment.center);
//
//   //Remark
//   // ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//   final remarkBy = profile.grantProfileExtras.entries.elementAt(7).value.remarks.createdBy;
//   final remarkMessage = profile.grantProfileExtras.entries.elementAt(7).value.remarks.message;
//   final remarkSeconds = profile.grantProfileExtras.entries.elementAt(7).value.remarks.createdAt.seconds;
//   final remarkNanoSeconds = profile.grantProfileExtras.entries.elementAt(7).value.remarks.createdAt.nanoseconds;
//   final remarkDate = formatDataFromMilliseconds(remarkSeconds, remarkNanoSeconds);
//
//   final List<List<String>> remarkData = [
//     ['Remark By', remarkBy],
//     ['Remark', remarkMessage],
//     ['Date', remarkDate],
//   ];
//
//   final remarkTable = pw.TableHelper.fromTextArray(
//       data: remarkData, cellAlignment: pw.Alignment.center);
//
// // Add the table to the document.
//   pdf.addPage(pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return pw.Column(children: [
//           pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Align(
//                         alignment: pw.Alignment.topLeft,
//                         child: pw.Text('Name: ${profile.name}'),
//                       ),
//                       pw.Align(
//                         alignment: pw.Alignment.topLeft,
//                         child: pw.Text('Unique Id: ${profile.id}'),
//                       ),
//                       pw.Align(
//                         alignment: pw.Alignment.topLeft,
//                         child: pw.Text(
//                             'Div: ${profile.division}    Sem: ${profile.currentSem}'),
//                       ),
//                     ]),
//                 pw.Container(
//                   width: 50, // Adjust the width as needed
//                   height: 50, // Adjust the height as needed
//                   child: pw.Image(qrImage),
//                 ),
//                 pw.Center(
//                   child: pw.Image(image,
//                       width: 100, height: 100), // Adjust size as needed
//                 ),
//               ]),
//
//           pw.SizedBox(height: 1 * PdfPageFormat.cm),
//           pw.Text('Grant Sheet',
//               style:
//                   pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
//           pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
//
//           pw.Align(
//             alignment: pw.Alignment.topLeft,
//             child: pw.Text('Assignments',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//           pw.Center(child: assignmentsTable),
//           pw.SizedBox(height: 0.9 * PdfPageFormat.cm),
//           pw.Align(
//             alignment: pw.Alignment.topLeft,
//             child: pw.Text('Unit Tests',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//           pw.Center(child: utTable),
//           pw.SizedBox(height: 0.9 * PdfPageFormat.cm),
//           pw.Align(
//             alignment: pw.Alignment.topLeft,
//             child: pw.Text('Prelims',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//           pw.Center(child: prelimsTable),
//
//           pw.SizedBox(height: 0.9 * PdfPageFormat.cm),
//
//           pw.Align(
//             alignment: pw.Alignment.topLeft,
//             child: pw.Text('Extras',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//           // pw.Center(child: extrasTable),
//
//           pw.Align(
//               alignment: pw.Alignment.topLeft,
//               child: pw.SizedBox(
//                   width: 10 * PdfPageFormat.cm, child: extrasTable)),
//
//           pw.SizedBox(height: 0.9 * PdfPageFormat.cm),
//
//           pw.Align(
//             alignment: pw.Alignment.topLeft,
//             child: pw.Text('Remark',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//           ),
//           pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
//           // pw.Center(child: extrasTable),
//
//           pw.Align(
//               alignment: pw.Alignment.topLeft,
//               child: remarkTable),
//
//
//
//         ]); // Center the table
//       }));
//
//   final status = await Permission.manageExternalStorage.request();
//
//     final directory = await getTemporaryDirectory();
//   final file = File('${directory.path}/Grant Sheet.pdf');
//
//   await file.writeAsBytes(await pdf.save());
//
//   await OpenFile.open(file.path);
// }


import 'dart:io';
import 'package:credbud/views/profile_screen/qr_code_generator.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../state/profile/models/profile_model.dart';

String formatDataFromMilliseconds(int seconds, int nanoseconds) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      seconds * 1000 + (nanoseconds / 1000000).round());

  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  return formattedDate;
}

Map<String, String> evaluateAssignments(Map<String, List<int>> assignmentData) {

  final assignmentEvaluationMap = <String, String>{'Subject': 'Completed'};

  for (final entry in assignmentData.entries) {
    final key = entry.key;
    final assignments = entry.value;

    // Check if all assignments are greater than 0
    final allPositive = assignments.every((element) => element > 0);

    assignmentEvaluationMap[key] = allPositive ? 'Yes' : 'No';
  }

  return assignmentEvaluationMap;
}

List<List<String>> processUTDataForTable(Map<String, UTSubject> utData) {
  final tableData = <List<String>>[
    ['Subject'], // Name
    ['Marks'], // Marks
    ['Status'], // Status
  ];

  // Add data for each category
  for (final entry in utData.entries) {
    final subject = entry.value;
    tableData[0].add(subject.name);
    tableData[1].add(subject.marks.toString());
    tableData[2].add(subject.status);
  }

  return tableData;
}

List<List<String>> processPrelimDataForTable(
    Map<String, PrelimSubject> prelimData) {
  final tableData = <List<String>>[
    ['Subject'], // Name
    ['Marks'], // Marks
    ['Status'], // Status
  ];

  // Add data for each category
  for (final entry in prelimData.entries) {
    final subject = entry.value;
    tableData[0].add(subject.name);
    tableData[1].add(subject.marks.toString());
    tableData[2].add(subject.status);
  }

  return tableData;
}

Future<void> generateAndOpenPDF(
    Profile profile,
    Map<String, String> assignmentsData,
    List<List<String>> utData,
    List<List<String>> prelimData) async {
  final pdf = pw.Document();

  String qrData = '{"uid":"${profile.id}","sem":${profile.currentSem}}';
  final qrImageData = await generateQrCode(qrData);
  final qrImage = pw.MemoryImage(qrImageData);

  final imageData = await rootBundle.load(
      'assets/images/sinhgad_logo.png'); // Replace 'your_image.png' with the actual image path
  // final image = PdfImage.file(
  //   pdf.document,
  //   bytes: imageData.buffer.asUint8List(),
  // );

  final image = pw.MemoryImage(
    imageData.buffer.asUint8List(),
  );

  // Assignments Table
  final assignmentsTable = pw.TableHelper.fromTextArray(data: <List<String>>[
    [...assignmentsData.keys],
    [...assignmentsData.values],
  ], cellAlignment: pw.Alignment.center);

  // Unit Tests Table
  final utTable = pw.TableHelper.fromTextArray(
      data: utData, cellAlignment: pw.Alignment.center);

  // Prelims Table
  final prelimsTable = pw.TableHelper.fromTextArray(
      data: prelimData, cellAlignment: pw.Alignment.center);

  // Extras Table
  // ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
  final feeClearanceData =
      profile.grantProfileExtras.entries.elementAt(7).value.feeClearance;
  final nptelData = profile.grantProfileExtras.entries.elementAt(7).value.nptel;

  final List<List<String>> extrasData = [
    ['Fee Clearance', feeClearanceData.toString()],
    ['NPTEL', nptelData.toString()],
  ];

  final extrasTable = pw.TableHelper.fromTextArray(
      data: extrasData, cellAlignment: pw.Alignment.center);

  //Remark
  // ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
  final remarkBy = profile.grantProfileExtras.entries.elementAt(7).value.remarks?.createdBy;
  final remarkMessage = profile.grantProfileExtras.entries.elementAt(7).value.remarks?.message;
  final remarkSeconds = profile.grantProfileExtras.entries.elementAt(7).value.remarks?.createdAt.seconds;
  final remarkNanoSeconds = profile.grantProfileExtras.entries.elementAt(7).value.remarks?.createdAt.nanoseconds;
  final remarkDate = formatDataFromMilliseconds(remarkSeconds!, remarkNanoSeconds!);

  final List<List<String>> remarkData = [
    ['Remark By', remarkBy!],
    ['Remark', remarkMessage!],
    ['Date', remarkDate],
  ];

  final remarkTable = pw.TableHelper.fromTextArray(
      data: remarkData, cellAlignment: pw.Alignment.center);

// Add the table to the document.
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: pw.Text('Name: ${profile.name}'),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: pw.Text('Unique Id: ${profile.id}'),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topLeft,
                        child: pw.Text(
                            'Div: ${profile.division}    Sem: ${profile.currentSem}'),
                      ),
                    ]),
                pw.Container(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: pw.Image(qrImage),
                ),
                pw.Center(
                  child: pw.Image(image,
                      width: 100, height: 100), // Adjust size as needed
                ),
              ]),

          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          pw.Text('Grant Sheet',
              style:
              pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 0.3 * PdfPageFormat.cm),

          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text('Assignments',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
          pw.Center(child: assignmentsTable),
          pw.SizedBox(height: 0.9 * PdfPageFormat.cm),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text('Unit Tests',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
          pw.Center(child: utTable),
          pw.SizedBox(height: 0.9 * PdfPageFormat.cm),
          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text('Prelims',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
          pw.Center(child: prelimsTable),

          pw.SizedBox(height: 0.9 * PdfPageFormat.cm),

          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text('Extras',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
          // pw.Center(child: extrasTable),

          pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.SizedBox(
                  width: 10 * PdfPageFormat.cm, child: extrasTable)),

          pw.SizedBox(height: 0.9 * PdfPageFormat.cm),

          pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Text('Remark',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
          // pw.Center(child: extrasTable),

          pw.Align(
              alignment: pw.Alignment.topLeft,
              child: remarkTable),



        ]); // Center the table
      }));

  final status = await Permission.manageExternalStorage.request();

  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/Grant Sheet.pdf');

  await file.writeAsBytes(await pdf.save());

  await OpenFile.open(file.path);
}
