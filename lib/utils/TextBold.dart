import 'package:flutter/material.dart';

class TextBold extends StatelessWidget {
  final String text ;
  const TextBold({Key? key,
    required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600
    ));
  }
}
