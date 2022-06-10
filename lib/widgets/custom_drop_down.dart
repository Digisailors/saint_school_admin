import 'package:flutter/material.dart';

import '../constants/get_constants.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.labelText,
    this.hintText,
    required this.items,
    this.onChanged,
    this.onTap,
    this.leftPad = 20,
    required this.selectedValue,
    this.validator,
  }) : super(key: key);

  final String labelText;
  final String? hintText;
  final T? selectedValue;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final void Function()? onTap;
  final double? leftPad;

  final List<DropdownMenuItem<T>>? items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context) / (4),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(labelText),
        ),
        subtitle: DropdownButtonFormField<T>(
          isExpanded: false,
          value: selectedValue,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          decoration: InputDecoration(
            // border: const OutlineInputBorder(),
            // labelText: labelText,
            labelStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF95A1AC),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),

            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
          ),
          style: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          items: items,
        ),
      ),
    );
  }
}
