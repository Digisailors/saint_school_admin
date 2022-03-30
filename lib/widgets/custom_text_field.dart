import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.hintText,
    this.keyboardType,
    // this.validator,
    this.maxLength,
    this.maxLines,
    this.prefixIcon,
    this.validator,
    this.enabled,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  // final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(labelText ?? ''),
      ),
      subtitle: TextFormField(
        enabled: enabled,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        // validator: validator,
        cursorColor: Colors.black,
        maxLength: maxLength,
        maxLines: maxLines,
        keyboardType: keyboardType,

        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            // labelText: labelText,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: Colors.blue, width: 1)),
            hintStyle: const TextStyle(fontSize: 14, fontFamily: 'Lexend Deca', fontWeight: FontWeight.normal, color: Colors.grey),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lexend Deca', fontSize: 14, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(16, 24, 0, 24)),
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          fontFamily: 'Lexend Deca',
        ),
      ),
    );
  }
}
