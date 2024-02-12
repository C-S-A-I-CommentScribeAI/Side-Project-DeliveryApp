import 'package:flutter/material.dart';

class HomeBtn extends StatelessWidget {
  final String buttonText;
  final Widget page;

  const HomeBtn({
    super.key,
    required this.buttonText,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(160, 150),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}
