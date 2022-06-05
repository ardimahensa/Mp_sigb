import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(229, 236, 174, 40),
        actions: [
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Menu Awal ${user.email!}'),
          ],
        ),
      ),
    );
  }
}
