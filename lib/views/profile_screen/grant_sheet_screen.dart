// import 'package:credbud/state/profile/providers/profile_providers.dart';
// import 'package:credbud/views/components/animations/models/lottie_animations.dart';
// import 'package:credbud/views/components/profile/assignment_card.dart';
// import 'package:credbud/views/profile_screen/qr_code_generator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
// import 'package:open_file/open_file.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// import '../../state/profile/models/profile_model.dart';
// import '../components/animations/lottie_animations_view.dart';
// import '../constants/app_colors.dart';
// import 'cred_points_screen.dart';
// import 'grant_sheet_pdf.dart';
//
// class GrantSheetScreen extends ConsumerStatefulWidget {
//   const GrantSheetScreen({super.key});
//
//   @override
//   ConsumerState createState() => _GrantSheetScreenState();
// }
//
// class _GrantSheetScreenState extends ConsumerState<GrantSheetScreen> {
//   String formatDataFromMilliseconds(int seconds, int nanoseconds) {
//     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
//         seconds * 1000 + (nanoseconds / 1000000).round());
//
//     String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
//     return formattedDate;
//   }
//
//   // Map<String, List<int>> processAssignmentIterable(final data) {
//   //   //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//   //   final iterable = data.grantProfile.entries.elementAt(7).value.entries;
//   //
//   //   final resultMap =
//   //       <String, List<int>>{}; // Map with explicit type parameters
//   //
//   //   // Iterate over the iterable, using type assertions for key and value
//   //   for (var i = 0; i < iterable.length; i++) {
//   //     final key = iterable.elementAt(i).key as String; // Assert key as String
//   //     final assignmentsArray = iterable.elementAt(i).value.assignmentsArray
//   //         as List<int>; // Assert assignmentsArray as List<int>
//   //
//   //     resultMap[key] = assignmentsArray;
//   //   }
//   //
//   //   return resultMap;
//   // }
//
//   Map<String, List<int>> processAssignmentIterable(final data) {
//     //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//     final iterable = data.grantProfile.entries.elementAt(7).value.entries;
//
//     final resultMap = <String, List<int>>{};
//
//     for (var i = 0; i < iterable.length; i++) {
//       final key = iterable.elementAt(i).key as String;
//       final assignmentsArray =
//           iterable.elementAt(i).value.assignmentsArray as List<int>;
//
//       // Check if assignmentsArray is not empty before adding
//       if (assignmentsArray.isNotEmpty) {
//         resultMap[key] = assignmentsArray;
//       }
//     }
//
//     return resultMap;
//   }
//
//   String _determinePrelimStatus(
//       int prelimMarks, bool isFailed, bool isReappeared) {
//     if (prelimMarks > 28 && !isFailed && !isReappeared) {
//       return 'Pass';
//     } else if (isFailed && !isReappeared) {
//       return 'Fail';
//     } else if (prelimMarks > 0 &&
//         prelimMarks < 28 &&
//         isFailed &&
//         isReappeared) {
//       return 'Waiting for Approval';
//     } else if (prelimMarks > 28 && isFailed && isReappeared) {
//       return 'Pass after Retest';
//     } else {
//       // throw ArgumentError('Invalid combination of prelimMarks, isFailed, and isReappeared');
//       return 'Invalid combination of prelimMarks, isFailed, and isReappeared';
//     }
//   }
//
//   Map<String, PrelimSubject> processPrelimData(final data) {
//     //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//     final iterable = data.grantProfile.entries.elementAt(7).value.entries;
//
//     final resultMap = <String, PrelimSubject>{};
//
//     for (var i = 0; i < iterable.length; i++) {
//       final key = iterable.elementAt(i).key as String;
//       final prelimTotal =
//           iterable.elementAt(i).value.prelimData.prelimTotal as int;
//       final prelimMarks =
//           iterable.elementAt(i).value.prelimData.prelimMarks as int;
//       final isFailed = iterable.elementAt(i).value.prelimData.isFailed as bool;
//       final isReappeared =
//           iterable.elementAt(i).value.prelimData.isReappeared as bool;
//
//       // Check conditions for prelimTotal and status
//       if (prelimTotal > 0) {
//         final status =
//             _determinePrelimStatus(prelimMarks, isFailed, isReappeared);
//         resultMap[key] =
//             PrelimSubject(name: key, marks: prelimMarks, status: status);
//       }
//     }
//
//     return resultMap;
//   }
//
//   Map<String, UTSubject> processUTData(final data) {
//     //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//     final iterable = data.grantProfile.entries.elementAt(7).value.entries;
//
//     final resultMap = <String, UTSubject>{};
//
//     for (var i = 0; i < iterable.length; i++) {
//       final key = iterable.elementAt(i).key as String;
//       final utTotal = iterable.elementAt(i).value.utData.utTotal as int;
//       final utMarks = iterable.elementAt(i).value.utData.utMarks as int;
//       final isFailed = iterable.elementAt(i).value.utData.isFailed as bool;
//       final isReappeared =
//           iterable.elementAt(i).value.utData.isReappeared as bool;
//
//       // Check conditions for utTotal and status
//       if (utTotal > 0) {
//         final status = _determineUTStatus(utMarks, isFailed, isReappeared);
//         resultMap[key] = UTSubject(name: key, marks: utMarks, status: status);
//       }
//     }
//
//     return resultMap;
//   }
//
//   String _determineUTStatus(int utMarks, bool isFailed, bool isReappeared) {
//     if (utMarks > 12 && !isFailed && !isReappeared) {
//       return 'Pass';
//     } else if (isFailed && !isReappeared) {
//       return 'Fail';
//     } else if (utMarks > 0 && utMarks < 12 && isFailed && isReappeared) {
//       return 'Waiting for Approval';
//     } else if (utMarks > 12 && isFailed && isReappeared) {
//       return 'Pass after Retest';
//     } else {
//       // throw ArgumentError('Invalid combination of utMarks, isFailed, and isReappeared');
//       return 'Invalid combination of utMarks, isFailed, and isReappeared';
//     }
//   }
//
//   bool _assignmentsExpanded = false;
//   bool _prelimsExpanded = false;
//   bool _utsExpanded = false;
//   bool _extrasExpanded = false;
//   bool _remarkExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final profileState = ref.watch(profileStateProvider);
//     return RefreshIndicator(
//         onRefresh: () => ref.refresh(profileStateProvider.future),
//         child: switch (profileState) {
//           AsyncValue<Profile>(:final valueOrNull?) =>
//             AnnotatedRegion<SystemUiOverlayStyle>(
//               value: const SystemUiOverlayStyle(
//                   // statusBarColor: Colors.transparent,
//                   // statusBarIconBrightness: Brightness.dark,
//                   ),
//               child: Scaffold(
//                 appBar: AppBar(
//                   title: const Text(
//                     'Grant Sheet',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                   centerTitle: true,
//                   scrolledUnderElevation: 0,
//                 ),
//                 body: ListView(
//                   // controller: scrollController,
//                   children: [
//                     Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _assignmentsExpanded = !_assignmentsExpanded;
//                             });
//                           },
//                           child: Card(
//                             elevation: 5,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(left: 10),
//                                         child: Text(
//                                           'Assignments',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                       Icon(
//                                         _assignmentsExpanded
//                                             ? Icons.keyboard_arrow_up
//                                             : Icons.keyboard_arrow_down,
//                                       ),
//                                     ],
//                                   ),
//                                   // AssignmentCard(data: ,)
//                                   if (_assignmentsExpanded) // Conditionally show AssignmentCard
//                                     AssignmentCard(
//                                         data: processAssignmentIterable(
//                                             valueOrNull)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _utsExpanded = !_utsExpanded;
//                           });
//                         },
//                         child: Card(
//                           elevation: 5,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: Text('Unit Tests',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20)),
//                                     ),
//                                     Icon(
//                                       _utsExpanded
//                                           ? Icons.keyboard_arrow_up
//                                           : Icons.keyboard_arrow_down,
//                                     ),
//                                   ],
//                                 ),
//                                 if (_utsExpanded)
//                                   Column(
//                                     children: processUTData(valueOrNull)
//                                         .entries
//                                         .map((entry) {
//                                       final subject = entry.value;
//                                       Color statusColor =
//                                           (subject.status == 'Pass' ||
//                                                   subject.status ==
//                                                       'Pass after Retest')
//                                               ? Colors.green
//                                               : Colors.red;
//                                       return ListTile(
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 10),
//                                         title: Text(
//                                           '${subject.name}: ${subject.marks} / 30',
//                                           style: const TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                         subtitle: Text(
//                                           'Status: ${subject.status}',
//                                           style: TextStyle(color: statusColor),
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _prelimsExpanded = !_prelimsExpanded;
//                           });
//                         },
//                         child: Card(
//                           elevation: 5,
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: Text('Prelims',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20)),
//                                     ),
//                                     Icon(
//                                       _prelimsExpanded
//                                           ? Icons.keyboard_arrow_up
//                                           : Icons.keyboard_arrow_down,
//                                     ),
//                                   ],
//                                 ),
//                                 if (_prelimsExpanded)
//                                   Column(
//                                     children: processPrelimData(valueOrNull)
//                                         .entries
//                                         .map((entry) {
//                                       final subject = entry.value;
//                                       Color statusColor =
//                                           (subject.status == 'Pass' ||
//                                                   subject.status ==
//                                                       'Pass after Retest')
//                                               ? Colors.green
//                                               : Colors.red;
//                                       return ListTile(
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 horizontal: 10),
//                                         title: Text(
//                                           '${subject.name}: ${subject.marks} / 70',
//                                           style: const TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                         subtitle: Text(
//                                           'Status: ${subject.status}',
//                                           style: TextStyle(color: statusColor),
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _extrasExpanded = !_extrasExpanded;
//                             });
//                           },
//                           child: Card(
//                             elevation: 5,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(left: 10),
//                                         child: Text(
//                                           'Extras',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                       Icon(
//                                         _assignmentsExpanded
//                                             ? Icons.keyboard_arrow_up
//                                             : Icons.keyboard_arrow_down,
//                                       ),
//                                     ],
//                                   ),
//                                   if (_extrasExpanded) // Conditionally show AssignmentCard
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//                                           Row(
//                                             children: [
//                                               const Text(
//                                                 'Fee Clearance: ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                               Text(valueOrNull
//                                                       .grantProfileExtras
//                                                       .entries
//                                                       .elementAt(7)
//                                                       .value
//                                                       .feeClearance
//                                                   ? '✅'
//                                                   : '❌'),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 2),
//                                           Row(
//                                             children: [
//                                               const Text(
//                                                 'NPTEL: ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                               Text(valueOrNull
//                                                       .grantProfileExtras
//                                                       .entries
//                                                       .elementAt(7)
//                                                       .value
//                                                       .nptel
//                                                   ? '✅'
//                                                   : '❌'),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                     Padding(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _remarkExpanded = !_remarkExpanded;
//                             });
//                           },
//                           child: Card(
//                             elevation: 5,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Padding(
//                                         padding: EdgeInsets.only(left: 10),
//                                         child: Text(
//                                           'Remark',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20),
//                                         ),
//                                       ),
//                                       Icon(
//                                         _assignmentsExpanded
//                                             ? Icons.keyboard_arrow_up
//                                             : Icons.keyboard_arrow_down,
//                                       ),
//                                     ],
//                                   ),
//                                   if (_remarkExpanded)
//                                     Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
//                                           Row(
//                                             children: [
//                                               const Text(
//                                                 'Remark By: ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 valueOrNull
//                                                     .grantProfileExtras.entries
//                                                     .elementAt(7)
//                                                     .value
//                                                     .remarks
//                                                     .createdBy,
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 2),
//                                           Row(
//                                             children: [
//                                               const Text(
//                                                 'Message: ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 valueOrNull
//                                                     .grantProfileExtras.entries
//                                                     .elementAt(7)
//                                                     .value
//                                                     .remarks
//                                                     .message,
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 2),
//                                           Row(
//                                             children: [
//                                               const Text(
//                                                 'Date: ',
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w700,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 formatDataFromMilliseconds(
//                                                     valueOrNull
//                                                         .grantProfileExtras
//                                                         .entries
//                                                         .elementAt(7)
//                                                         .value
//                                                         .remarks
//                                                         .createdAt
//                                                         .seconds,
//                                                     valueOrNull
//                                                         .grantProfileExtras
//                                                         .entries
//                                                         .elementAt(7)
//                                                         .value
//                                                         .remarks
//                                                         .createdAt
//                                                         .nanoseconds),
//                                                 style: const TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
//                       child: Padding(
//                           padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                           child: NeoPopButton(
//                             color: AppColors.mauve,
//                             bottomShadowColor: AppColors.cornflowerBlue,
//                             rightShadowColor: AppColors.cornflowerBlue,
//                             depth: 8,
//                             onTapUp: () async {
//                               final assignmentTableData = evaluateAssignments(
//                                   processAssignmentIterable(valueOrNull));
//                               final utTableData = processUTDataForTable(
//                                   processUTData(valueOrNull));
//
//                               final prelimsTableData =
//                                   processPrelimDataForTable(
//                                       processPrelimData(valueOrNull));
//
//                               await generateAndOpenPDF(
//                                   valueOrNull,
//                                   assignmentTableData,
//                                   utTableData,
//                                   prelimsTableData);
//                             },
//                             onTapDown: () {
//                               HapticFeedback.heavyImpact();
//                             },
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 15),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Download Grant Sheet PDF",
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w800)),
//                                 ],
//                               ),
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//           // An error is available, so we render it.
//           AsyncValue(:final error?) => Center(
//               child: Text('Error: $error'),
//             ),
//           // No data/error, so we're in loading state.
//           _ => Center(
//                 child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.4,
//               width: MediaQuery.of(context).size.width * 0.4,
//               child: const LottieAnimationView(
//                 animation: LottieAnimation.loading,
//                 repeat: true,
//               ),
//             )),
//         });
//   }
// }


import 'package:credbud/state/profile/providers/profile_providers.dart';
import 'package:credbud/views/components/animations/models/lottie_animations.dart';
import 'package:credbud/views/components/profile/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';

import '../../state/profile/models/profile_model.dart';
import '../components/animations/lottie_animations_view.dart';
import '../constants/app_colors.dart';
import 'grant_sheet_pdf.dart';

class GrantSheetScreen extends ConsumerStatefulWidget {
  const GrantSheetScreen({super.key});

  @override
  ConsumerState createState() => _GrantSheetScreenState();
}

class _GrantSheetScreenState extends ConsumerState<GrantSheetScreen> {
  String formatDataFromMilliseconds(int seconds, int nanoseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + (nanoseconds / 1000000).round());

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  // Map<String, List<int>> processAssignmentIterable(final data) {
  //   //ToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
  //   final iterable = data.grantProfile.entries.elementAt(7).value.entries;
  //
  //   final resultMap =
  //       <String, List<int>>{}; // Map with explicit type parameters
  //
  //   // Iterate over the iterable, using type assertions for key and value
  //   for (var i = 0; i < iterable.length; i++) {
  //     final key = iterable.elementAt(i).key as String; // Assert key as String
  //     final assignmentsArray = iterable.elementAt(i).value.assignmentsArray
  //         as List<int>; // Assert assignmentsArray as List<int>
  //
  //     resultMap[key] = assignmentsArray;
  //   }
  //
  //   return resultMap;
  // }

  Map<String, List<int>> processAssignmentIterable(final data) {
    //FixedToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
    int userSemester = data.currentSem;
    userSemester = userSemester-1;
    // if(kDebugMode){
    //   print('Current Semester Array Index: $userSemester');
    // }
    final iterable = data.grantProfile.entries.elementAt(userSemester).value.entries;

    final resultMap = <String, List<int>>{};

    for (var i = 0; i < iterable.length; i++) {
      final key = iterable.elementAt(i).key as String;
      final assignmentsArray =
      iterable.elementAt(i).value.assignmentsArray as List<int>;

      // Check if assignmentsArray is not empty before adding
      if (assignmentsArray.isNotEmpty) {
        resultMap[key] = assignmentsArray;
      }
    }

    return resultMap;
  }

  String _determinePrelimStatus(
      int prelimMarks, bool isFailed, bool isReappeared) {
    if (prelimMarks > 28 && !isFailed && !isReappeared) {
      return 'Pass';
    } else if (isFailed && !isReappeared) {
      return 'Fail';
    } else if (prelimMarks > 0 &&
        prelimMarks < 28 &&
        isFailed &&
        isReappeared) {
      return 'Waiting for Approval';
    } else if (prelimMarks > 28 && isFailed && isReappeared) {
      return 'Pass after Retest';
    } else {
      // throw ArgumentError('Invalid combination of prelimMarks, isFailed, and isReappeared');
      return 'Invalid combination of prelimMarks, isFailed, and isReappeared';
    }
  }

  Map<String, PrelimSubject> processPrelimData(final data) {
    //FixedToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
    int userSemester = data.currentSem;
    userSemester = userSemester-1;
    // if(kDebugMode){
    //   print('Current Semester Array Index: $userSemester');
    // }
    final iterable = data.grantProfile.entries.elementAt(userSemester).value.entries;

    final resultMap = <String, PrelimSubject>{};

    for (var i = 0; i < iterable.length; i++) {
      final key = iterable.elementAt(i).key as String;
      final prelimTotal =
      iterable.elementAt(i).value.prelimData.prelimTotal as int;
      final prelimMarks =
      iterable.elementAt(i).value.prelimData.prelimMarks as int;
      final isFailed = iterable.elementAt(i).value.prelimData.isFailed as bool;
      final isReappeared =
      iterable.elementAt(i).value.prelimData.isReappeared as bool;

      // Check conditions for prelimTotal and status
      if (prelimTotal > 0) {
        final status =
        _determinePrelimStatus(prelimMarks, isFailed, isReappeared);
        resultMap[key] =
            PrelimSubject(name: key, marks: prelimMarks, status: status);
      }
    }

    return resultMap;
  }

  Map<String, UTSubject> processUTData(final data) {
    //FixedToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
    int userSemester = data.currentSem;
    userSemester = userSemester-1;
    // if(kDebugMode){
    //   print('Current Semester Array Index: $userSemester');
    // }
    final iterable = data.grantProfile.entries.elementAt(userSemester).value.entries;

    final resultMap = <String, UTSubject>{};

    for (var i = 0; i < iterable.length; i++) {
      final key = iterable.elementAt(i).key as String;
      final utTotal = iterable.elementAt(i).value.utData.utTotal as int;
      final utMarks = iterable.elementAt(i).value.utData.utMarks as int;
      final isFailed = iterable.elementAt(i).value.utData.isFailed as bool;
      final isReappeared =
      iterable.elementAt(i).value.utData.isReappeared as bool;

      // Check conditions for utTotal and status
      if (utTotal > 0) {
        final status = _determineUTStatus(utMarks, isFailed, isReappeared);
        resultMap[key] = UTSubject(name: key, marks: utMarks, status: status);
      }
    }

    return resultMap;
  }

  String _determineUTStatus(int utMarks, bool isFailed, bool isReappeared) {
    if (utMarks > 12 && !isFailed && !isReappeared) {
      return 'Pass';
    } else if (isFailed && !isReappeared) {
      return 'Fail';
    } else if (utMarks > 0 && utMarks < 12 && isFailed && isReappeared) {
      return 'Waiting for Approval';
    } else if (utMarks > 12 && isFailed && isReappeared) {
      return 'Pass after Retest';
    } else {
      // throw ArgumentError('Invalid combination of utMarks, isFailed, and isReappeared');
      return 'Invalid combination of utMarks, isFailed, and isReappeared';
    }
  }

  bool _assignmentsExpanded = false;
  bool _prelimsExpanded = false;
  bool _utsExpanded = false;
  bool _extrasExpanded = false;
  bool _remarkExpanded = false;

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileStateProvider);
    return RefreshIndicator(
        onRefresh: () => ref.refresh(profileStateProvider.future),
        child: switch (profileState) {
          AsyncValue<Profile>(:final valueOrNull?) =>
              AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  // statusBarColor: Colors.transparent,
                  // statusBarIconBrightness: Brightness.dark,
                ),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Grant Sheet',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    scrolledUnderElevation: 0,
                  ),
                  body: ListView(
                    // controller: scrollController,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _assignmentsExpanded = !_assignmentsExpanded;
                              });
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Assignments',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Icon(
                                          _assignmentsExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                        ),
                                      ],
                                    ),
                                    // AssignmentCard(data: ,)
                                    if (_assignmentsExpanded) // Conditionally show AssignmentCard
                                      AssignmentCard(
                                          data: processAssignmentIterable(
                                              valueOrNull)),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _utsExpanded = !_utsExpanded;
                            });
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Unit Tests',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ),
                                      Icon(
                                        _utsExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                      ),
                                    ],
                                  ),
                                  if (_utsExpanded)
                                    Column(
                                      children: processUTData(valueOrNull)
                                          .entries
                                          .map((entry) {
                                        final subject = entry.value;
                                        Color statusColor =
                                        (subject.status == 'Pass' ||
                                            subject.status ==
                                                'Pass after Retest')
                                            ? Colors.green
                                            : Colors.red;
                                        return ListTile(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          title: Text(
                                            '${subject.name}: ${subject.marks} / 30',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          subtitle: Text(
                                            'Status: ${subject.status}',
                                            style: TextStyle(color: statusColor),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _prelimsExpanded = !_prelimsExpanded;
                            });
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Prelims',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ),
                                      Icon(
                                        _prelimsExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                      ),
                                    ],
                                  ),
                                  if (_prelimsExpanded)
                                    Column(
                                      children: processPrelimData(valueOrNull)
                                          .entries
                                          .map((entry) {
                                        final subject = entry.value;
                                        Color statusColor =
                                        (subject.status == 'Pass' ||
                                            subject.status ==
                                                'Pass after Retest')
                                            ? Colors.green
                                            : Colors.red;
                                        return ListTile(
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          title: Text(
                                            '${subject.name}: ${subject.marks} / 70',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          subtitle: Text(
                                            'Status: ${subject.status}',
                                            style: TextStyle(color: statusColor),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _extrasExpanded = !_extrasExpanded;
                              });
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Extras',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Icon(
                                          _assignmentsExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                        ),
                                      ],
                                    ),
                                    if (_extrasExpanded) // Conditionally show AssignmentCard
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            //FixedToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
                                            Row(
                                              children: [
                                                const Text(
                                                  'Fee Clearance: ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(valueOrNull
                                                    .grantProfileExtras
                                                    .entries
                                                    .elementAt(valueOrNull.currentSem-1)
                                                    .value
                                                    .feeClearance!
                                                    ? '✅'
                                                    : '❌'),
                                              ],
                                            ),
                                            const SizedBox(height: 2),

                                            Row(
                                              children: [
                                                const Text(
                                                  'NPTEL: ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(valueOrNull
                                                    .grantProfileExtras
                                                    .entries
                                                    .elementAt(valueOrNull.currentSem-1)
                                                    .value
                                                    .nptel!
                                                    ? '✅'
                                                    : '❌'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _remarkExpanded = !_remarkExpanded;
                              });
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Remark',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Icon(
                                          _assignmentsExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                        ),
                                      ],
                                    ),
                                    if (_remarkExpanded)
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            //FixedToDO: use the sem fetched from userprofile - 1 (indexing starts at 0)
                                            Row(
                                              children: [
                                                const Text(
                                                  'Remark By: ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  valueOrNull
                                                      .grantProfileExtras.entries
                                                      .elementAt(valueOrNull.currentSem-1)
                                                      .value
                                                      .remarks!
                                                      .createdBy,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Message: ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  valueOrNull
                                                      .grantProfileExtras.entries
                                                      .elementAt(valueOrNull.currentSem-1)
                                                      .value
                                                      .remarks!
                                                      .message,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Date: ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  formatDataFromMilliseconds(
                                                      valueOrNull
                                                          .grantProfileExtras
                                                          .entries
                                                          .elementAt(valueOrNull.currentSem-1)
                                                          .value
                                                          .remarks!
                                                          .createdAt
                                                          .seconds,
                                                      valueOrNull
                                                          .grantProfileExtras
                                                          .entries
                                                          .elementAt(valueOrNull.currentSem-1)
                                                          .value
                                                          .remarks!
                                                          .createdAt
                                                          .nanoseconds),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: NeoPopButton(
                              color: AppColors.mauve,
                              bottomShadowColor: AppColors.cornflowerBlue,
                              rightShadowColor: AppColors.cornflowerBlue,
                              depth: 8,
                              onTapUp: () async {
                                final assignmentTableData = evaluateAssignments(
                                    processAssignmentIterable(valueOrNull));
                                final utTableData = processUTDataForTable(
                                    processUTData(valueOrNull));

                                final prelimsTableData =
                                processPrelimDataForTable(
                                    processPrelimData(valueOrNull));

                                await generateAndOpenPDF(
                                    valueOrNull,
                                    assignmentTableData,
                                    utTableData,
                                    prelimsTableData);
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
                                    Text("Download Grant Sheet PDF",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),

        // An error is available, so we render it.
          AsyncValue(:final error?) => Center(
            child: Text('Error: $error'),
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
