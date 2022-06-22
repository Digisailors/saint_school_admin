import 'package:flutter/cupertino.dart';
import 'package:school_app/controllers/Form%20Controllers/bio_form_state.dart';
import 'package:school_app/models/student.dart';

class StudentFormState with BioFormState {
  final TextEditingController mother = TextEditingController();
  final TextEditingController father = TextEditingController();
  final TextEditingController guardian = TextEditingController();

  List<TextEditingController> siblings = [
    TextEditingController(),
  ];

  StudentFormState();

  String? studentClass;

  String? section;

  addSiblingField() {
    siblings.add(TextEditingController());
  }

  Student get object => Student(
        icNumber: icNumber.text,
        studentClass: studentClass!,
        section: section!,
        name: name.text,
        email: email.text,
        address: address.text,
        addressLine1: addressLine1.text,
        addressLine2: addressLine2.text,
        city: city.text,
        imageUrl: imageUrl.text,
        lastName: lastName.text,
        primaryPhone: primaryPhone.text,
        secondaryPhone: secondaryPhone.text,
        state: state.text,
        siblings: siblings.map((e) => e.text).toList(),
        gender: gender,
        father: father.text,
        guardian: guardian.text,
        mother: mother.text,
      );
}
