import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({this.text, this.onchange, this.obscureText = false});
  String? text;
  Function(String)? onchange;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      child: TextFormField(
        obscureText: obscureText,
        validator: (data) {
          if (data!.isEmpty) {
            return 'required value';
          }
        },
        onChanged: onchange,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
            border: const OutlineInputBorder(),
            hintText: '$text',
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            )),
      ),
    );
  }
}
