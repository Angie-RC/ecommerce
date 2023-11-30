import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    if (username != null) {
      _usernameController.text = username;
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  navigateTo() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Home();
    }));
  }

  authenticate() async {
    final isLogged = await UserService()
        .login(_usernameController.text, _passwordController.text);
    if (isLogged) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setBool('isLogged', true);
      navigateTo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            controller: _usernameController,
          ),
          TextField(
            controller: _passwordController,
          ),
          OutlinedButton(
            onPressed: () {
              authenticate();
            },
            child: const Text('Ingresar'),
          )
        ],
      )),
    );
  }
}
