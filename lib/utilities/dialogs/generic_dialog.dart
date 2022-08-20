import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            var color = Colors.blue;
            if (value) {
              color = Colors.red;
            }
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
              style: TextButton.styleFrom(
                primary: color,
              ),
            );
          }).toList(),
        );
      });
}
