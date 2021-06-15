import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  final String apiKey = 'AIzaSyB3La9QCXvX9rSn4sLWDet-4E0fLRICj1w';
  final String createUserUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';

  void createUser({String email, String password}) async {
    try {
      final response = await http.post(
        createUserUrl + apiKey,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print(responseBody);
        _token = responseBody['idToken'];
        _expiryDate = DateTime.now()
            .subtract(Duration(seconds: int.parse(responseBody['expiresIn'])));
      } else {
        print('Something went wrong: ' + response.body);
      }
    } catch (e) {
      print('catch block: $e');
    }
  }
}
