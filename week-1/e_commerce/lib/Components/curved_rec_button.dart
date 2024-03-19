import 'package:flutter/material.dart';

class CurvedRecButton extends StatelessWidget {
  final String text;
  final Color color;

  const CurvedRecButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: color, padding: EdgeInsets.zero, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), 
          ), 
          elevation: 0, 
          shadowColor: Colors.transparent, 
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
