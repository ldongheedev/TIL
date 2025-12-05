import 'package:flutter/material.dart';

class PriceView extends StatelessWidget {
  final double price;
  final TextStyle? textStyle;
  final bool showWon;

  const PriceView({
    Key? key,
    required this.price,
    this.textStyle,
    this.showWon = true,
  }) : super(key: key);

  String _formatPrice(double price) {
    return price
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      showWon ? '₩${_formatPrice(price)}' : _formatPrice(price),
      style:
          textStyle ??
          const TextStyle(
            color: Color(0xFFFF6F00),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
