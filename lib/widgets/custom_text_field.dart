import 'dart:async';

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
    this.autovalidateMode,
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
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(labelText ?? ''),
      ),
      subtitle: TextFormField(
        enabled: enabled,
        autovalidateMode: autovalidateMode,
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

class CustomAutoComplete<T extends Object> extends StatelessWidget {
  const CustomAutoComplete({
    Key? key,
    this.onSelected,
    required this.optionsBuilder,
    required this.title,
    this.text,
    this.optionsViewBuilder,
    this.validator,
    this.onChanged,
    this.enabled = false,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
  }) : super(key: key);

  final void Function(T)? onSelected;
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final String title;
  final String? text;
  final Widget Function(BuildContext, void Function(T), Iterable<T>)? optionsViewBuilder;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final String Function(T) displayStringForOption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(title),
      ),
      subtitle: Autocomplete<T>(
        initialValue: TextEditingValue(text: text ?? ''),
        displayStringForOption: displayStringForOption,
        optionsBuilder: optionsBuilder,
        onSelected: onSelected,
        optionsViewBuilder: optionsViewBuilder,
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            onChanged: onChanged,
            validator: validator,
            focusNode: focusNode,
            enabled: enabled,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: Colors.blue, width: 1)),
                hintStyle: const TextStyle(fontSize: 14, fontFamily: 'Lexend Deca', fontWeight: FontWeight.normal, color: Colors.grey),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lexend Deca', fontSize: 14, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.fromLTRB(16, 24, 0, 24)),
          );
        },
      ),
    );
  }
}
