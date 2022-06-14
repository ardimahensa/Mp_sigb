// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigb/page/setting.dart';
import 'setting.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // ignore: todo
  //TODO: Text controller
  final _emailController = TextEditingController();

  // ignore: todo
  //TODO: Agar memory tidak overload
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ignore: todo
  //TODO: Fungsi untuk reset password email
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Link reset password sudah dikirim, cek email kamu sekarang! 😊',
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffd5e2e3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
          color: ColorPalette.timberGreen,
        ),
        elevation: 0,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Color(0xffd5e2e3),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(width: 20, height: 20),
                Image.asset(
                  'assets/images/forget.png',
                  height: 250,
                  width: 400,
                ),
                const SizedBox(height: 10),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(255, 153, 51, 10),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 445,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(141, 141, 161, 180)
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 5),
                            blurRadius: 10,
                            color: const Color.fromARGB(255, 75, 73, 73)
                                .withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Masukan Email Yang Sudah Terdaftar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w500,
                              fontSize: 28,
                              color: ColorPalette.white),
                        ),
                      ),
                    ),
                    // ignore: todo
                    //TODO: Email form
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 230, left: 40, right: 40),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.aquaHaze,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 5),
                              blurRadius: 10,
                              color: const Color(0xff000000).withOpacity(0.16),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            style: GoogleFonts.workSans(
                                color: const Color.fromARGB(255, 15, 15, 16),
                                fontSize: 17,
                                fontWeight: FontWeight.w300),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_sharp,
                                shadows: [
                                  BoxShadow(
                                    offset: const Offset(3, 4),
                                    blurRadius: 10,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.16),
                                  ),
                                ],
                              ),
                              border: InputBorder.none,
                              hintText: "Email",
                              // filled: true,
                              fillColor: Colors.transparent,
                            ),
                            cursorColor: ColorPalette.timberGreen,
                          ),
                        ),
                      ),
                    ),
                    // ignore: todo
                    //TODO: Tombol Reset
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 300, left: 40, right: 40),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          onPressed: passwordReset,
                          child: Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorPalette.mandy,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 10,
                                  color:
                                      const Color(0xff000000).withOpacity(0.16),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Reset",
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: ColorPalette.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
