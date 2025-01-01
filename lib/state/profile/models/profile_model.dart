// import 'dart:convert';
//
// class Profile {
//   final String id;
//   final String division;
//   final Map<String, Map<String, GrantProfile>> grantProfile;
//   final int currentSem;
//   final String contact;
//   final String name;
//   final int admissionYear;
//   final int cgpa;
//   final String parentsContact;
//   final String department;
//   final String email;
//   final CredPoints credPoints;
//   final Map<String, GrantProfileExtra> grantProfileExtras;
//
//
//   Profile({
//     required this.id,
//     required this.division,
//     required this.grantProfile,
//     required this.currentSem,
//     required this.contact,
//     required this.name,
//     required this.admissionYear,
//     required this.cgpa,
//     required this.parentsContact,
//     required this.department,
//     required this.email,
//     required this.credPoints,
//     required this.grantProfileExtras,
//   });
//
//   Profile copyWith({
//     String? id,
//     String? division,
//     Map<String, Map<String, GrantProfile>>? grantProfile,
//     int? currentSem,
//     String? contact,
//     String? name,
//     int? admissionYear,
//     int? cgpa,
//     String? parentsContact,
//     String? department,
//     String? email,
//     CredPoints? credPoints,
//     Map<String, GrantProfileExtra>? grantProfileExtras,
//   }) =>
//       Profile(
//         id: id ?? this.id,
//         division: division ?? this.division,
//         grantProfile: grantProfile ?? this.grantProfile,
//         currentSem: currentSem ?? this.currentSem,
//         contact: contact ?? this.contact,
//         name: name ?? this.name,
//         admissionYear: admissionYear ?? this.admissionYear,
//         cgpa: cgpa ?? this.cgpa,
//         parentsContact: parentsContact ?? this.parentsContact,
//         department: department ?? this.department,
//         email: email ?? this.email,
//         credPoints: credPoints ?? this.credPoints,
//         grantProfileExtras: grantProfileExtras ?? this.grantProfileExtras,
//       );
//
//   factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//     id: json["id"],
//     division: json["division"],
//     grantProfile: Map.from(json["grantProfile"]).map((k, v) => MapEntry<String, Map<String, GrantProfile>>(k, Map.from(v).map((k, v) => MapEntry<String, GrantProfile>(k, GrantProfile.fromJson(v))))),
//     currentSem: json["currentSem"],
//     contact: json["contact"],
//     name: json["name"],
//     admissionYear: json["admissionYear"],
//     cgpa: json["cgpa"],
//     parentsContact: json["parentsContact"],
//     department: json["department"],
//     email: json["email"],
//     credPoints: CredPoints.fromJson(json["credPoints"]),
//     grantProfileExtras: Map.from(json["grantProfileExtras"]).map((k, v) => MapEntry<String, GrantProfileExtra>(k, GrantProfileExtra.fromJson(v))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "division": division,
//     "grantProfile": Map.from(grantProfile).map((k, v) => MapEntry<String, dynamic>(k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
//     "currentSem": currentSem,
//     "contact": contact,
//     "name": name,
//     "admissionYear": admissionYear,
//     "cgpa": cgpa,
//     "parentsContact": parentsContact,
//     "department": department,
//     "email": email,
//     "credPoints": credPoints.toJson(),
//     "grantProfileExtras": Map.from(grantProfileExtras).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//   };
// }
//
// class CredPoints {
//   final List<History> profitHistory;
//   final List<History> redeemHistory;
//   final int balance;
//
//   CredPoints({
//     required this.profitHistory,
//     required this.redeemHistory,
//     required this.balance,
//   });
//
//   CredPoints copyWith({
//     List<History>? profitHistory,
//     List<History>? redeemHistory,
//     int? balance,
//   }) =>
//       CredPoints(
//         profitHistory: profitHistory ?? this.profitHistory,
//         redeemHistory: redeemHistory ?? this.redeemHistory,
//         balance: balance ?? this.balance,
//       );
//
//   factory CredPoints.fromRawJson(String str) => CredPoints.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory CredPoints.fromJson(Map<String, dynamic> json) => CredPoints(
//     profitHistory: List<History>.from(json["profitHistory"].map((x) => History.fromJson(x))),
//     redeemHistory: List<History>.from(json["redeemHistory"].map((x) => History.fromJson(x))),
//     balance: json["balance"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "profitHistory": List<dynamic>.from(profitHistory.map((x) => x.toJson())),
//     "redeemHistory": List<dynamic>.from(redeemHistory.map((x) => x.toJson())),
//     "balance": balance,
//   };
// }
//
// class History {
//   final Date date;
//   final int amount;
//   final String task;
//
//   History({
//     required this.date,
//     required this.amount,
//     required this.task,
//   });
//
//   History copyWith({
//     Date? date,
//     int? amount,
//     String? task,
//   }) =>
//       History(
//         date: date ?? this.date,
//         amount: amount ?? this.amount,
//         task: task ?? this.task,
//       );
//
//   factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory History.fromJson(Map<String, dynamic> json) => History(
//     date: Date.fromJson(json["date"]),
//     amount: json["amount"],
//     task: json["task"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "date": date.toJson(),
//     "amount": amount,
//     "task": task,
//   };
// }
//
// class Date {
//   final int seconds;
//   final int nanoseconds;
//
//   Date({
//     required this.seconds,
//     required this.nanoseconds,
//   });
//
//   Date copyWith({
//     int? seconds,
//     int? nanoseconds,
//   }) =>
//       Date(
//         seconds: seconds ?? this.seconds,
//         nanoseconds: nanoseconds ?? this.nanoseconds,
//       );
//
//   factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Date.fromJson(Map<String, dynamic> json) => Date(
//     seconds: json["_seconds"],
//     nanoseconds: json["_nanoseconds"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_seconds": seconds,
//     "_nanoseconds": nanoseconds,
//   };
// }
//
// class GrantProfile {
//   final List<int> assignmentsArray;
//   final UtData utData;
//   final PrelimData prelimData;
//   final SubjectIsElective? subjectIsElective;
//   final List<int>? subjectMiniProjects;
//
//   GrantProfile({
//     required this.assignmentsArray,
//     required this.utData,
//     required this.prelimData,
//     required this.subjectIsElective,
//     required this.subjectMiniProjects,
//   });
//
//   GrantProfile copyWith({
//     List<int>? assignmentsArray,
//     UtData? utData,
//     PrelimData? prelimData,
//     SubjectIsElective? subjectIsElective,
//     List<int>? subjectMiniProjects,
//   }) =>
//       GrantProfile(
//         assignmentsArray: assignmentsArray ?? this.assignmentsArray,
//         utData: utData ?? this.utData,
//         prelimData: prelimData ?? this.prelimData,
//         subjectIsElective: subjectIsElective ?? this.subjectIsElective,
//         subjectMiniProjects: subjectMiniProjects ?? this.subjectMiniProjects,
//       );
//
//   factory GrantProfile.fromRawJson(String str) => GrantProfile.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory GrantProfile.fromJson(Map<String, dynamic> json) => GrantProfile(
//     assignmentsArray: List<int>.from(json["assignmentsArray"].map((x) => x)),
//     utData: UtData.fromJson(json["utData"]),
//     prelimData: PrelimData.fromJson(json["prelimData"]),
//     subjectIsElective: json["subjectIsElective"] == null ? null : SubjectIsElective.fromJson(json["subjectIsElective"]),
//     subjectMiniProjects: json["subjectMiniProjects"] == null ? [] : List<int>.from(json["subjectMiniProjects"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "assignmentsArray": List<dynamic>.from(assignmentsArray.map((x) => x)),
//     "utData": utData.toJson(),
//     "prelimData": prelimData.toJson(),
//     "subjectIsElective": subjectIsElective?.toJson(),
//     "subjectMiniProjects": subjectMiniProjects == null ? [] : List<dynamic>.from(subjectMiniProjects!.map((x) => x)),
//   };
// }
//
// class GrantProfileExtra {
//   final bool feeClearance;
//   final bool nptel;
//   final Remarks remarks;
//
//   GrantProfileExtra({
//     required this.feeClearance,
//     required this.nptel,
//     required this.remarks,
//   });
//
//   GrantProfileExtra copyWith({
//     bool? feeClearance,
//     bool? nptel,
//     Remarks? remarks,
//
//   }) =>
//       GrantProfileExtra(
//         feeClearance: feeClearance ?? this.feeClearance,
//         nptel: nptel ?? this.nptel,
//         remarks: remarks ?? this.remarks,
//       );
//
//   factory GrantProfileExtra.fromRawJson(String str) => GrantProfileExtra.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory GrantProfileExtra.fromJson(Map<String, dynamic> json) => GrantProfileExtra(
//     feeClearance: json["Fee Clearance"],
//     nptel: json["NPTEL"],
//     remarks: Remarks.fromJson(json["remarks"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Fee Clearance": feeClearance,
//     "NPTEL": nptel,
//     "remarks": remarks.toJson(),
//   };
// }
//
// class Remarks {
//   final CreatedAt createdAt;
//   final String createdBy;
//   final String message;
//
//   Remarks({
//     required this.createdAt,
//     required this.createdBy,
//     required this.message,
//   });
//
//   Remarks copyWith({
//     CreatedAt? createdAt,
//     String? createdBy,
//     String? message,
//   }) =>
//       Remarks(
//         createdAt: createdAt ?? this.createdAt,
//         createdBy: createdBy ?? this.createdBy,
//         message: message ?? this.message,
//       );
//
//   factory Remarks.fromRawJson(String str) => Remarks.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Remarks.fromJson(Map<String, dynamic> json) => Remarks(
//     createdAt: CreatedAt.fromJson(json["createdAt"]),
//     createdBy: json["createdBy"],
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "createdAt": createdAt.toJson(),
//     "createdBy": createdBy,
//     "message": message,
//   };
// }
//
// class CreatedAt {
//   final int seconds;
//   final int nanoseconds;
//
//   CreatedAt({
//     required this.seconds,
//     required this.nanoseconds,
//   });
//
//   CreatedAt copyWith({
//     int? seconds,
//     int? nanoseconds,
//   }) =>
//       CreatedAt(
//         seconds: seconds ?? this.seconds,
//         nanoseconds: nanoseconds ?? this.nanoseconds,
//       );
//
//   factory CreatedAt.fromRawJson(String str) => CreatedAt.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
//     seconds: json["_seconds"],
//     nanoseconds: json["_nanoseconds"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_seconds": seconds,
//     "_nanoseconds": nanoseconds,
//   };
// }
//
//
// class PrelimData {
//   final int prelimMarks;
//   final int prelimTotal;
//   final bool isFailed;
//   final bool isReappeared;
//   final int prelimPassing;
//
//   PrelimData({
//     required this.prelimMarks,
//     required this.prelimTotal,
//     required this.isFailed,
//     required this.isReappeared,
//     required this.prelimPassing,
//   });
//
//   PrelimData copyWith({
//     int? prelimMarks,
//     int? prelimTotal,
//     bool? isFailed,
//     bool? isReappeared,
//     int? prelimPassing,
//   }) =>
//       PrelimData(
//         prelimMarks: prelimMarks ?? this.prelimMarks,
//         prelimTotal: prelimTotal ?? this.prelimTotal,
//         isFailed: isFailed ?? this.isFailed,
//         isReappeared: isReappeared ?? this.isReappeared,
//         prelimPassing: prelimPassing ?? this.prelimPassing,
//       );
//
//   factory PrelimData.fromRawJson(String str) => PrelimData.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory PrelimData.fromJson(Map<String, dynamic> json) => PrelimData(
//     prelimMarks: json["prelimMarks"],
//     prelimTotal: json["prelimTotal"],
//     isFailed: json["isFailed"],
//     isReappeared: json["isReappeared"],
//     prelimPassing: json["prelimPassing"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "prelimMarks": prelimMarks,
//     "prelimTotal": prelimTotal,
//     "isFailed": isFailed,
//     "isReappeared": isReappeared,
//     "prelimPassing": prelimPassing,
//   };
// }
//
// class SubjectIsElective {
//   final List<String> subjectElectiveChoices;
//   final String selectedSubject;
//
//   SubjectIsElective({
//     required this.subjectElectiveChoices,
//     required this.selectedSubject,
//   });
//
//   SubjectIsElective copyWith({
//     List<String>? subjectElectiveChoices,
//     String? selectedSubject,
//   }) =>
//       SubjectIsElective(
//         subjectElectiveChoices: subjectElectiveChoices ?? this.subjectElectiveChoices,
//         selectedSubject: selectedSubject ?? this.selectedSubject,
//       );
//
//   factory SubjectIsElective.fromRawJson(String str) => SubjectIsElective.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory SubjectIsElective.fromJson(Map<String, dynamic> json) => SubjectIsElective(
//     subjectElectiveChoices: List<String>.from(json["subjectElectiveChoices"].map((x) => x)),
//     selectedSubject: json["selectedSubject"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "subjectElectiveChoices": List<dynamic>.from(subjectElectiveChoices.map((x) => x)),
//     "selectedSubject": selectedSubject,
//   };
// }
//
// class UtData {
//   final int utPassing;
//   final int utMarks;
//   final bool isFailed;
//   final bool isReappeared;
//   final int utTotal;
//
//   UtData({
//     required this.utPassing,
//     required this.utMarks,
//     required this.isFailed,
//     required this.isReappeared,
//     required this.utTotal,
//   });
//
//   UtData copyWith({
//     int? utPassing,
//     int? utMarks,
//     bool? isFailed,
//     bool? isReappeared,
//     int? utTotal,
//   }) =>
//       UtData(
//         utPassing: utPassing ?? this.utPassing,
//         utMarks: utMarks ?? this.utMarks,
//         isFailed: isFailed ?? this.isFailed,
//         isReappeared: isReappeared ?? this.isReappeared,
//         utTotal: utTotal ?? this.utTotal,
//       );
//
//   factory UtData.fromRawJson(String str) => UtData.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory UtData.fromJson(Map<String, dynamic> json) => UtData(
//     utPassing: json["utPassing"],
//     utMarks: json["utMarks"],
//     isFailed: json["isFailed"],
//     isReappeared: json["isReappeared"],
//     utTotal: json["utTotal"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "utPassing": utPassing,
//     "utMarks": utMarks,
//     "isFailed": isFailed,
//     "isReappeared": isReappeared,
//     "utTotal": utTotal,
//   };
// }


// class PrelimSubject {
//   final String name;
//   final int marks;
//   final String status;
//
//   PrelimSubject({required this.name, required this.marks, required this.status});
// }
//
// class UTSubject {
//   final String name;
//   final int marks;
//   final String status;
//
//   UTSubject({required this.name, required this.marks, required this.status});
// }


// test model

import 'dart:convert';

class Profile {
  final String id;
  final String division;
  final String name;
  final int admissionYear;
  final double cgpa;
  final String department;
  final String email;
  final int currentSem;
  final String contact;
  final String parentsContact;
  final Map<String, Map<String, GrantProfile>> grantProfile;
  final Map<String, GrantProfileExtra> grantProfileExtras;
  final CredPoints credPoints;

  Profile({
    required this.id,
    required this.division,
    required this.name,
    required this.admissionYear,
    required this.cgpa,
    required this.department,
    required this.email,
    required this.currentSem,
    required this.contact,
    required this.parentsContact,
    required this.grantProfile,
    required this.grantProfileExtras,
    required this.credPoints,
  });

  Profile copyWith({
    String? id,
    String? division,
    String? name,
    int? admissionYear,
    double? cgpa,
    String? department,
    String? email,
    int? currentSem,
    String? contact,
    String? parentsContact,
    Map<String, Map<String, GrantProfile>>? grantProfile,
    Map<String, GrantProfileExtra>? grantProfileExtras,
    CredPoints? credPoints,
  }) =>
      Profile(
        id: id ?? this.id,
        division: division ?? this.division,
        name: name ?? this.name,
        admissionYear: admissionYear ?? this.admissionYear,
        cgpa: cgpa ?? this.cgpa,
        department: department ?? this.department,
        email: email ?? this.email,
        currentSem: currentSem ?? this.currentSem,
        contact: contact ?? this.contact,
        parentsContact: parentsContact ?? this.parentsContact,
        grantProfile: grantProfile ?? this.grantProfile,
        grantProfileExtras: grantProfileExtras ?? this.grantProfileExtras,
        credPoints: credPoints ?? this.credPoints,
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    division: json["division"],
    name: json["name"],
    admissionYear: json["admissionYear"],
    cgpa: json["cgpa"] is int ? (json["cgpa"] as int).toDouble() : json["cgpa"],
    department: json["department"],
    email: json["email"],
    currentSem: json["currentSem"],
    contact: json["contact"],
    parentsContact: json["parentsContact"],
    grantProfile: Map.from(json["grantProfile"]).map((k, v) => MapEntry<String, Map<String, GrantProfile>>(k, Map.from(v).map((k, v) => MapEntry<String, GrantProfile>(k, GrantProfile.fromJson(v))))),
    grantProfileExtras: Map.from(json["grantProfileExtras"]).map((k, v) => MapEntry<String, GrantProfileExtra>(k, GrantProfileExtra.fromJson(v))),
    credPoints: CredPoints.fromJson(json["credPoints"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "division": division,
    "name": name,
    "admissionYear": admissionYear,
    "cgpa": cgpa,
    "department": department,
    "email": email,
    "currentSem": currentSem,
    "contact": contact,
    "parentsContact": parentsContact,
    "grantProfile": Map.from(grantProfile).map((k, v) => MapEntry<String, dynamic>(k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
    "grantProfileExtras": Map.from(grantProfileExtras).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "credPoints": credPoints.toJson(),
  };
}

class CredPoints {
  final List<History> profitHistory;
  final List<History> redeemHistory;
  final int balance;

  CredPoints({
    required this.profitHistory,
    required this.redeemHistory,
    required this.balance,
  });

  CredPoints copyWith({
    List<History>? profitHistory,
    List<History>? redeemHistory,
    int? balance,
  }) =>
      CredPoints(
        profitHistory: profitHistory ?? this.profitHistory,
        redeemHistory: redeemHistory ?? this.redeemHistory,
        balance: balance ?? this.balance,
      );

  factory CredPoints.fromRawJson(String str) => CredPoints.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CredPoints.fromJson(Map<String, dynamic> json) => CredPoints(
    profitHistory: List<History>.from(json["profitHistory"].map((x) => History.fromJson(x))),
    redeemHistory: List<History>.from(json["redeemHistory"].map((x) => History.fromJson(x))),
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "profitHistory": List<dynamic>.from(profitHistory.map((x) => x.toJson())),
    "redeemHistory": List<dynamic>.from(redeemHistory.map((x) => x.toJson())),
  };
}

class History {
  final Date date;
  final int amount;
  final String task;

  History({
    required this.date,
    required this.amount,
    required this.task,
  });

  History copyWith({
    Date? date,
    int? amount,
    String? task,
  }) =>
      History(
        date: date ?? this.date,
        amount: amount ?? this.amount,
        task: task ?? this.task,
      );

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
    date: Date.fromJson(json["date"]),
    amount: json["amount"],
    task: json["task"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toJson(),
    "amount": amount,
    "task": task,
  };
}

class Date {
  final int seconds;
  final int nanoseconds;

  Date({
    required this.seconds,
    required this.nanoseconds,
  });

  Date copyWith({
    int? seconds,
    int? nanoseconds,
  }) =>
      Date(
        seconds: seconds ?? this.seconds,
        nanoseconds: nanoseconds ?? this.nanoseconds,
      );

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    seconds: json["_seconds"],
    nanoseconds: json["_nanoseconds"],
  );

  Map<String, dynamic> toJson() => {
    "_seconds": seconds,
    "_nanoseconds": nanoseconds,
  };
}

class GrantProfile {
  final List<int> assignmentsArray;
  final UtData utData;
  final PrelimData prelimData;
  final List<int>? subjectMiniProjects;
  final SubjectIsElective? subjectIsElective;

  GrantProfile({
    required this.assignmentsArray,
    required this.utData,
    required this.prelimData,
    required this.subjectMiniProjects,
    required this.subjectIsElective,
  });

  GrantProfile copyWith({
    List<int>? assignmentsArray,
    UtData? utData,
    PrelimData? prelimData,
    List<int>? subjectMiniProjects,
    SubjectIsElective? subjectIsElective,
  }) =>
      GrantProfile(
        assignmentsArray: assignmentsArray ?? this.assignmentsArray,
        utData: utData ?? this.utData,
        prelimData: prelimData ?? this.prelimData,
        subjectMiniProjects: subjectMiniProjects ?? this.subjectMiniProjects,
        subjectIsElective: subjectIsElective ?? this.subjectIsElective,
      );

  factory GrantProfile.fromRawJson(String str) => GrantProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrantProfile.fromJson(Map<String, dynamic> json) => GrantProfile(
    assignmentsArray: List<int>.from(json["assignmentsArray"].map((x) => x)),
    utData: UtData.fromJson(json["utData"]),
    prelimData: PrelimData.fromJson(json["prelimData"]),
    subjectMiniProjects: json["subjectMiniProjects"] == null ? [] : List<int>.from(json["subjectMiniProjects"]!.map((x) => x)),
    subjectIsElective: json["subjectIsElective"] == null ? null : SubjectIsElective.fromJson(json["subjectIsElective"]),
  );

  Map<String, dynamic> toJson() => {
    "assignmentsArray": List<dynamic>.from(assignmentsArray.map((x) => x)),
    "utData": utData.toJson(),
    "prelimData": prelimData.toJson(),
    "subjectMiniProjects": subjectMiniProjects == null ? [] : List<dynamic>.from(subjectMiniProjects!.map((x) => x)),
    "subjectIsElective": subjectIsElective?.toJson(),
  };
}

class PrelimData {
  final int prelimMarks;
  final int prelimTotal;
  final bool isFailed;
  final bool isReappeared;
  final int prelimPassing;

  PrelimData({
    required this.prelimMarks,
    required this.prelimTotal,
    required this.isFailed,
    required this.isReappeared,
    required this.prelimPassing,
  });

  PrelimData copyWith({
    int? prelimMarks,
    int? prelimTotal,
    bool? isFailed,
    bool? isReappeared,
    int? prelimPassing,
  }) =>
      PrelimData(
        prelimMarks: prelimMarks ?? this.prelimMarks,
        prelimTotal: prelimTotal ?? this.prelimTotal,
        isFailed: isFailed ?? this.isFailed,
        isReappeared: isReappeared ?? this.isReappeared,
        prelimPassing: prelimPassing ?? this.prelimPassing,
      );

  factory PrelimData.fromRawJson(String str) => PrelimData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrelimData.fromJson(Map<String, dynamic> json) => PrelimData(
    prelimMarks: json["prelimMarks"],
    prelimTotal: json["prelimTotal"],
    isFailed: json["isFailed"],
    isReappeared: json["isReappeared"],
    prelimPassing: json["prelimPassing"],
  );

  Map<String, dynamic> toJson() => {
    "prelimMarks": prelimMarks,
    "prelimTotal": prelimTotal,
    "isFailed": isFailed,
    "isReappeared": isReappeared,
    "prelimPassing": prelimPassing,
  };
}

class SubjectIsElective {
  final List<String> subjectElectiveChoices;
  final String selectedSubject;
  final bool selectionAvailable;
  final dynamic selectionDue;

  SubjectIsElective({
    required this.subjectElectiveChoices,
    required this.selectedSubject,
    required this.selectionAvailable,
    required this.selectionDue,
  });

  SubjectIsElective copyWith({
    List<String>? subjectElectiveChoices,
    String? selectedSubject,
    bool? selectionAvailable,
    dynamic selectionDue,
  }) =>
      SubjectIsElective(
        subjectElectiveChoices: subjectElectiveChoices ?? this.subjectElectiveChoices,
        selectedSubject: selectedSubject ?? this.selectedSubject,
        selectionAvailable: selectionAvailable ?? this.selectionAvailable,
        selectionDue: selectionDue ?? this.selectionDue,
      );

  factory SubjectIsElective.fromRawJson(String str) => SubjectIsElective.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubjectIsElective.fromJson(Map<String, dynamic> json) => SubjectIsElective(
    subjectElectiveChoices: List<String>.from(json["subjectElectiveChoices"].map((x) => x)),
    selectedSubject: json["selectedSubject"],
    selectionAvailable: json["selectionAvailable"],
    selectionDue: json["selectionDue"],
  );

  Map<String, dynamic> toJson() => {
    "subjectElectiveChoices": List<dynamic>.from(subjectElectiveChoices.map((x) => x)),
    "selectedSubject": selectedSubject,
    "selectionAvailable": selectionAvailable,
    "selectionDue": selectionDue,
  };
}

class UtData {
  final int utPassing;
  final int utMarks;
  final bool isFailed;
  final bool isReappeared;
  final int utTotal;

  UtData({
    required this.utPassing,
    required this.utMarks,
    required this.isFailed,
    required this.isReappeared,
    required this.utTotal,
  });

  UtData copyWith({
    int? utPassing,
    int? utMarks,
    bool? isFailed,
    bool? isReappeared,
    int? utTotal,
  }) =>
      UtData(
        utPassing: utPassing ?? this.utPassing,
        utMarks: utMarks ?? this.utMarks,
        isFailed: isFailed ?? this.isFailed,
        isReappeared: isReappeared ?? this.isReappeared,
        utTotal: utTotal ?? this.utTotal,
      );

  factory UtData.fromRawJson(String str) => UtData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UtData.fromJson(Map<String, dynamic> json) => UtData(
    utPassing: json["utPassing"],
    utMarks: json["utMarks"],
    isFailed: json["isFailed"],
    isReappeared: json["isReappeared"],
    utTotal: json["utTotal"],
  );

  Map<String, dynamic> toJson() => {
    "utPassing": utPassing,
    "utMarks": utMarks,
    "isFailed": isFailed,
    "isReappeared": isReappeared,
    "utTotal": utTotal,
  };
}

class GrantProfileExtra {
  final bool? feeClearance;
  final bool? nptel;
  final Remarks? remarks;

  GrantProfileExtra({
    this.feeClearance,
    this.nptel,
    this.remarks,
  });

  GrantProfileExtra copyWith({
    bool? feeClearance,
    bool? nptel,
    Remarks? remarks,
  }) =>
      GrantProfileExtra(
        feeClearance: feeClearance ?? this.feeClearance,
        nptel: nptel ?? this.nptel,
        remarks: remarks ?? this.remarks,
      );

  factory GrantProfileExtra.fromRawJson(String str) => GrantProfileExtra.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrantProfileExtra.fromJson(Map<String, dynamic> json) => GrantProfileExtra(
    feeClearance: json["Fee Clearance"],
    nptel: json["NPTEL"],
    remarks: json["remarks"] == null ? null : Remarks.fromJson(json["remarks"]),
  );

  Map<String, dynamic> toJson() => {
    "Fee Clearance": feeClearance,
    "NPTEL": nptel,
    "remarks": remarks?.toJson(),
  };
}

class Remarks {
  final Date createdAt;
  final String createdBy;
  final String message;

  Remarks({
    required this.createdAt,
    required this.createdBy,
    required this.message,
  });

  Remarks copyWith({
    Date? createdAt,
    String? createdBy,
    String? message,
  }) =>
      Remarks(
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        message: message ?? this.message,
      );

  factory Remarks.fromRawJson(String str) => Remarks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Remarks.fromJson(Map<String, dynamic> json) => Remarks(
    createdAt: Date.fromJson(json["createdAt"]),
    createdBy: json["createdBy"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toJson(),
    "createdBy": createdBy,
    "message": message,
  };
}

class PrelimSubject {
  final String name;
  final int marks;
  final String status;

  PrelimSubject({required this.name, required this.marks, required this.status});
}

class UTSubject {
  final String name;
  final int marks;
  final String status;

  UTSubject({required this.name, required this.marks, required this.status});
}
