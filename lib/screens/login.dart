import 'package:demo/main.dart';
import 'package:demo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();
  bool _isDataMatched = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Value is Empty'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Value is Empty'
                        : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !_isDataMatched,
                      child: const Text(
                        'username and password dosenot match',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkLogin(context);
                        }
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkLogin(BuildContext ctx) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username == password) {
      //Goto Home
      final sharedprefs = await SharedPreferences.getInstance();
      await sharedprefs.setBool(saveKeyName, true);
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ScreenHome()));
    } else {
      const errroMessage = "User Name and Password dosen't match";
      //Snack bar
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text(errroMessage),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
      //Alert Diolg
      // showDialog(
      //   context: ctx,
      //   builder: (ctx1) => AlertDialog(
      //     title: const Text('Error'),
      //     content: const Text(errroMessage),
      //     actions: [
      //       TextButton(
      //           onPressed: () {
      //             Navigator.of(ctx1).pop();
      //           },
      //           child: const Text('Close'))
      //     ],
      //   ),
      // );
      //show texts
      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
