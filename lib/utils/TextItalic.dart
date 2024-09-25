import 'package:flutter/material.dart';


class TextItalic extends StatelessWidget {
  final String text ;
  const TextItalic({Key? key,
    required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontStyle: FontStyle.italic
    )
    );
  }
}
