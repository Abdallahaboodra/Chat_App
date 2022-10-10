import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.textButton,
    this.onTap,
  });
  String? textButton;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: 380,
        height: 50,
        child: Center(
          child: Text(
            textButton!,
            style: TextStyle(
              fontSize: 23,
              color: Color(0xff26435F),
            ),
          ),
        ),
      ),
    );
  }
}
