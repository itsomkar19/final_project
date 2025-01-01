import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AttendanceRepository {
  final String baseUrl =
      'https://credbud-backend-production.up.railway.app/api/v1';

  AttendanceRepository();

  Future<Map<String, dynamic>> markAttendance(String qrData) async {
    var idTokenResult =
        await FirebaseAuth.instance.currentUser?.getIdTokenResult(true);
    var refreshedToken = idTokenResult?.token;
    // var token = await F
    // irebaseAuth.instance.currentUser?.getIdToken();
    print('NEW TOKEN: $refreshedToken');

    final String url = '$baseUrl/attendance/mark';
    final Map<String, String> headers = {
      'Authorization': 'Bearer $refreshedToken',
      'Content-Type': 'application/json',
      "X-API-Key": "HFRGIq1LdGm3VJFyGTmtKA=="
    };

    final Map<String, dynamic> body = json.decode(qrData);

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    final int statusCode = response.statusCode;
    final String responseBody = response.body;
    if(kDebugMode){
      print("Received response: $responseBody");
    }
    if (statusCode >= 200 && statusCode < 300) {
      return {'statusCode': statusCode, 'data': jsonDecode(responseBody)};
    } else {
      return {'statusCode': statusCode, 'error': responseBody};
    }
  }
}
