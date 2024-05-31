import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController? controller;


  const TextFieldWidget({Key? key, required this.hintText ,required this.obscure, this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 171, 152, 146),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText, // Use the hintText parameter here
          hintStyle: TextStyle(
            color: Colors.brown,
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
