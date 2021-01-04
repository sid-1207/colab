import 'package:flutter/material.dart';
import '../constants.dart';
import 'text_field_container.dart';

class RoundedNameField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedNameField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

