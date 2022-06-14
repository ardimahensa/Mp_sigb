import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sigb/auth/main_page.dart';

void main() async {
  // ignore: todo
  //TODO: Penghubung ke firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // ignore: todo
  //TODO: Menghilangkan status bar dan bottom navigasi
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlueAccent),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
