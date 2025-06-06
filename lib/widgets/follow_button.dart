import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final bool isDisabled;
  
  const FollowButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    this.function, 
    this.isDisabled = false,
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : () => function,
      child: Container(
        padding: const EdgeInsets.only(top: 2),
        child: TextButton(
          onPressed: function,
          child: Container(
            decoration: BoxDecoration(
              color: isDisabled ? Colors.yellow : backgroundColor,
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            // width: 250,
            height: 27,
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}