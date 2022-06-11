import 'package:flutter/material.dart';

//warna
mixin ColorPalette {
  static const Color grey = Color.fromRGBO(165, 164, 172, 100);
  static const Color aquaHaze = Color(0xffeff5f4);
  static const Color pacificBlue = Color(0xff00b7b7);
  static const Color white = Color(0xffffffff);
  static const Color mandy = Color(0xffe75757);
  static const Color timberGreen = Color(0xff1a2e35);
  static const Color nileBlue = Color(0xff1a535c);
  static const Color bondyBlue = Color(0xff0096a5);
  static const Color geyser = Color(0xffd5e2e3);
}

//notif logout
void showConfirmDialog(
  BuildContext context,
  String title,
  String action1title,
  String action2title,
  Function action1,
  Function action2,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "Nunito",
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    action1();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 12),
                    child: Text(
                      action1title,
                      style: const TextStyle(
                        color: Colors.red,
                        fontFamily: "Nunito",
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    action2();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Text(
                      action2title,
                      style: const TextStyle(
                        color: Colors.green,
                        fontFamily: "Nunito",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
