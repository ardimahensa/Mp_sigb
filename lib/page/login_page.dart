// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigb/page/forgotpassword_page.dart';
import 'package:sigb/page/setting.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const Login({
    Key? key,
    required this.showRegisterPage,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ignore: todo
  //TODO: text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // ignore: todo
  //TODO: Fungsi untuk login
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Berhasil Login 😊',
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
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

  // ignore: todo
  //TODO: Agar memory tidak overload
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                const SizedBox(width: 20, height: 20),
                Image.asset(
                  'assets/images/login.png',
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
                      height: 500,
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Selamat Datang',
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: ColorPalette.white),
                        ),
                      ),
                    ),
                    // ignore: todo
                    //TODO: Email form
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 80, left: 40, right: 40),
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
                    //TODO: Password form
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 160, left: 40, right: 40),
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
                    // ignore: todo
                    //TODO: Lupa Password
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 225, left: 40, right: 40),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPassword();
                                },
                              ),
                            );
                          }),
                          child: Text(
                            'Lupa Password ?',
                            style: GoogleFonts.sourceSansPro(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.white),
                          ),
                        ),
                      ),
                    ),
                    // ignore: todo
                    //TODO: Tombol Login
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 280, left: 40, right: 40),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: signIn,
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
                                "Login",
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
                      padding: EdgeInsets.only(top: 360, left: 40, right: 210),
                      child: Divider(
                        thickness: 2,
                        color: Color.fromRGBO(255, 153, 51, 50),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 350, left: 40, right: 40),
                      child: Text(
                        '=',
                        style:
                            TextStyle(color: ColorPalette.white, fontSize: 30),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 360, left: 210, right: 40),
                      child: Divider(
                        thickness: 2,
                        color: Color.fromRGBO(255, 153, 51, 50),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 400, left: 40, right: 40),
                      child: Text(
                        'Tidak Punya Akun ?',
                        style:
                            TextStyle(color: ColorPalette.white, fontSize: 15),
                      ),
                    ),
                    // ignore: todo
                    //TODO: Daftar Akun
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 425, left: 40, right: 40),
                      child: GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          'Daftar Disini',
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
