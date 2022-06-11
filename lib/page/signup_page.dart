// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigb/page/setting.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUp({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _autentifikasiController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _autentifikasiController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future register() async {
    try {
      if (passwordConfirm()) {
        //Create User
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        //Add User detail
        addUserDetail(
          _firstnameController.text.trim(),
          _lastnameController.text.trim(),
          int.parse(_ageController.text.trim()),
          _emailController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
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

  Future addUserDetail(
      String firstName, String lastName, int age, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Nama Depan': firstName,
      'Nama Belakang': lastName,
      'Umur': age,
      'Email': email,
    });
  }

  bool passwordConfirm() {
    if (_passwordController.text.trim() ==
        _autentifikasiController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Color(0xffd5e2e3),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(255, 153, 51, 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Container(
                        width: 350,
                        height: 600,
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 140),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Isi Data Diri',
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: ColorPalette.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 200, left: 40, right: 40),
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
                            controller: _firstnameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.portrait_outlined,
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
                              hintText: "Nama Depan",
                              // filled: true,
                              fillColor: Colors.transparent,
                            ),
                            cursorColor: ColorPalette.timberGreen,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 260, left: 40, right: 40),
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
                            controller: _lastnameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.portrait,
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
                              hintText: "Nama Belakang",
                              // filled: true,
                              fillColor: Colors.transparent,
                            ),
                            cursorColor: ColorPalette.timberGreen,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 320, left: 40, right: 40),
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
                            controller: _ageController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_outline_rounded,
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
                              hintText: "Umur",
                              // filled: true,
                              fillColor: Colors.transparent,
                            ),
                            cursorColor: ColorPalette.timberGreen,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 380, left: 40, right: 40),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 440, left: 40, right: 40),
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
                                color: ColorPalette.timberGreen,
                                fontSize: 17,
                                fontWeight: FontWeight.w300),
                            controller: _passwordController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.password_sharp,
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
                              hintText: "Password",
                              // filled: true,
                              fillColor: Colors.transparent,
                            ),
                            cursorColor: ColorPalette.timberGreen,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 500, left: 40, right: 40),
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
                            controller: _autentifikasiController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.password_outlined,
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
                              hintText: "Confirm Password",
                              // filled: true,
                              fillColor: Colors.transparent,
                            ),
                            cursorColor: ColorPalette.timberGreen,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 565, left: 40, right: 40),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: register,
                          child: Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(209, 0, 183, 183),
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
                                "Daftar",
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
                    const Padding(
                      padding: EdgeInsets.only(top: 620, left: 40, right: 210),
                      child: Divider(
                        thickness: 2,
                        color: Color.fromRGBO(255, 153, 51, 50),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 610, left: 40, right: 40),
                      child: Text(
                        '=',
                        style:
                            TextStyle(color: ColorPalette.white, fontSize: 30),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 620, left: 210, right: 40),
                      child: Divider(
                        thickness: 2,
                        color: Color.fromRGBO(255, 153, 51, 50),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 650, left: 40, right: 40),
                      child: Text(
                        'Sudah Punya Akun ?',
                        style:
                            TextStyle(color: ColorPalette.white, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 670, left: 40, right: 40),
                      child: GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          'Login Disini',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 197, 8),
                              fontSize: 20),
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
