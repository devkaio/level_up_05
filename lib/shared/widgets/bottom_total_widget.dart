import 'package:flutter/material.dart';

class BottomTotalWidget extends StatelessWidget {
  final controller;
  const BottomTotalWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: ",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            controller,
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.green.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
