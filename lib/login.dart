import 'package:chat_app/Home.dart';
import 'package:chat_app/TencentUiKit_controller.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: userId,
              decoration: const InputDecoration(hintText: 'Enter your user ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final timeservices = TIMUIKITService();
                //login method
                if (userId.text == 'Umair') {
                  timeservices.login(
                    userId.text,
                    'eJwtzMEKgkAUheF3ueuwO5Mzo0IbEWEq2qgtpI04U1xiQkwsi949U5fnO-B-ID9kXm9biIB7CKtpk7H3ji40ceEqapfjYW5V05CBiCNylGozu3011FqImBBifHDWjtzflM9ZEEg-XBp0HauJTHOjT6TYeb1-vo99aZ0SYZyWQ8Z4vUNWsIE0T2LUW-j*AOZBL*I_',
                  ).then((response){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const Homescreen()));
                  });
                } else {
                  timeservices.login(
                    userId.text,
                    'eJyrVgrxCdYrSy1SslIy0jNQ0gHzM1NS80oy0zLBwl75GXlQ8eKU7MSCgswUJSsjAwMjAzNzY4h4akVBZlGqkpWhqakpUMYAIlqSmQsSMzcxMrSwMDczhJqRmQ40NDDftyLQ0qe83CQgL8vNMS8sLTKoKjUivMLZ3ycq0tU1vzglsjAyxynNz9NWqRYAoqkxXw__',
                  ).then((response){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const Homescreen()));
                  });
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
