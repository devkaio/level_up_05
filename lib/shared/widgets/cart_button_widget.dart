import 'package:flutter/material.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(buttonText),
      onPressed: onPressed,
    );
  }
}
