import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/models/user_account_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'https://plain-marbled-muskox.glitch.me/users?';
  final String _baseUrl2 = 'https://plain-marbled-muskox.glitch.me/users';
  final String _username = 'username=';
  final String _password = '&password=';

  Future<bool> login(String username, String password) async {
    final url = '$_baseUrl$_username$username$_password$password';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = response.body;
      print(response.body);
      final users = json.decode(jsonResponse);
      print(username);
      return users.isNotEmpty;
    }
    return false;
  }

  Future<UserAccount?> signUp(UserAccount userSignup) async {
    http.Response response = await http.post(Uri.parse(_baseUrl2),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          userSignup.toMap(),
        ));
    if (response.statusCode == HttpStatus.ok) {
      if (response.body.isNotEmpty) {
        final jsonResponse = json.decode(response.body);
        print('Response headers: ${response.headers}');
        print('Response body: ${response.body}');
        final user = UserAccount.fromJson(jsonResponse);
        return user;
      } else {
        print('Signup failed. Server response is empty.');
        return null;
      }
    } else {
      print('Signup failed. Server returned status: ${response.statusCode}');
      return null;
    }
  }
}
