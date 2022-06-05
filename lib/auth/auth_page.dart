// ignore_for_file: implementation_imports

import 'package:flutter/src/widgets/framework.dart';
import 'package:sigb/page/login_page.dart';
import 'package:sigb/page/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toogleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(showRegisterPage: toogleScreens);
    } else {
      return SignUp(showLoginPage: toogleScreens);
    }
  }
}
