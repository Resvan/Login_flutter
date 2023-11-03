import 'package:demo/main.dart';
import 'package:demo/screens/home.dart';
import 'package:demo/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Splash screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  gotoLogin() async {
    Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => ScreenLogin()),
    );
  }

  checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getBool(saveKeyName);
    if (userLoggedIn == null || !userLoggedIn) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const ScreenHome()));
    }
  }
}
