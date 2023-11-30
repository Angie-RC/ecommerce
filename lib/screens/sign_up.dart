import 'package:ecommerce/models/user_account_model.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserService? _userService;

  @override
  void initState() {
    _userService = UserService();
    super.initState();
  }

  Future<void> performSignup() async {
    String password = passwordController.text;
    String username = usernameController.text;
    UserAccount userAccount = UserAccount(
      username: username,
      password: password,
    );
    if (password.isEmpty || username.isEmpty) {
      return;
    }
    UserAccount? result = await _userService?.signUp(userAccount);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            controller: usernameController,
          ),
          TextField(
            controller: passwordController,
          ),
          OutlinedButton(
            onPressed: () {
              performSignup();
            },
            child: const Text('Registrar'),
          )
        ],
      )),
    );
  }
}
