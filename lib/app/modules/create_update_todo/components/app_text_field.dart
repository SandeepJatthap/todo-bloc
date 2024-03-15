import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final  Function(String?) onChange;
  final String hint;
  final String initialValue;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;

  const AppTextField({
    super.key,
    required this.onChange,
    required this.initialValue,
    required this.hint,
    this.validator,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: TextFormField(
        validator: validator,
        initialValue: initialValue,
        minLines: minLines,
        onChanged: onChange,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
