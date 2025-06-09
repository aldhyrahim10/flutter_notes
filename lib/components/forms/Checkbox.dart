import 'package:flutter/material.dart';

Widget buildCheckbox(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Checkbox(
          value: value,
          activeColor: Colors.orange,
          onChanged: (val) => onChanged(val!),
        ),
      ],
    );
  }