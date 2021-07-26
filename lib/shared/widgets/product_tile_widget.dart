import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {
  final Text title;
  final Text price;
  final bool value;
  final Function(bool?)? onChanged;

  const ProductTile({
    Key? key,
    this.value = false,
    required this.title,
    required this.price,
    this.onChanged,
  }) : super(key: key);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Checkbox(
                value: widget.value,
                onChanged: widget.onChanged,
              ),
              widget.title,
              Spacer(),
              widget.price,
            ],
          ),
        ),
      ],
    );
  }
}
