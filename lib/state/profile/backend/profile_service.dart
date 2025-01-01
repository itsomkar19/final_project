import 'package:credbud/state/profile/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProfileService {
  ProfileService();

  Future<Profile> fetchProfile() async {
    var idTokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult(true);
    var refreshedToken = idTokenResult?.token;
    // var token = await FirebaseAuth.instance.currentUser?.getIdToken();
    print('NEW TOKEN: $refreshedToken');

    var uri = Uri.parse('https://credbud-backend-production.up.railway.app/api/v1/user/profile');

    var headers = {
      "Authorization": "Bearer $refreshedToken",
      "X-API-Key": "HFRGIq1LdGm3VJFyGTmtKA=="
    };

    final response = await http.get(uri, headers: headers);

    int statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      print('Status 1 Code: $statusCode');
      print('Response 2 Body: ${response.body}');

      // Parse JSON and create Profile object
      var jsonResponse = json.decode(response.body);
      Profile profile = Profile.fromJson(jsonResponse);

      return profile;
    } else {
      print('Error Status 3 Code: $statusCode');
      print('Error Response 4 Body: ${response.body}');
      // You may want to throw an exception here or handle the error in some way
      throw Exception('Failed to load profile 5');
    }
  }
}
