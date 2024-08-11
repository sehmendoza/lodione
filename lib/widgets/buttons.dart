import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});
  final void Function() onPressed;
  final String text;
  final IconData icon;
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
      },
      style: TextButton.styleFrom(
          shape:
              ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(
            color: _isHovering ? Colors.white : Colors.black,
          )),
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.icon,
            color: Colors.white70,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
