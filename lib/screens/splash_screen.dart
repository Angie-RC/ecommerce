import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;

  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogged') != null) {
      setState(() {
        isLogged = true;
      });
    }

    navigateTo();
  }

  navigateTo() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return isLogged ? const Home() : const Login();
    }));
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
