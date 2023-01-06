import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  Roundedbutton(
      {required this.title,
      required this.color,
      required this.onPress,
      required this.icon,
      required this.tsize,
      required this.isize});

  late final Color color;
  late final String title;
  late final VoidCallback onPress;
  late final IconData icon;
  late final double tsize;
  late final double isize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
          ),
          child: MaterialButton(
            onPressed: onPress,
            minWidth: 158.0,
            height: 57.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: isize,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: tsize,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppinsmedium',
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
