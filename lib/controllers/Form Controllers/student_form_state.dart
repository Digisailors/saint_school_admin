import 'package:flutter/cupertino.dart';
import 'package:school_app/controllers/Form%20Controllers/bio_form_state.dart';
import 'package:school_app/models/parent.dart';
import 'package:school_app/models/student.dart';

class StudentFormState with BioFormState {


  final TextEditingController mother = TextEditingController();
  final TextEditingController father = TextEditingController();

  List<TextEditingController> siblings = [];

  StudentFormState();

  String? studentClass;

  String? section;


  Student get object =>
      Student(icNumber: icNumber,
          studentClass: studentClass!,
          section: section!,
          name: name.text,
          email: email,
          parent:[father.text, mother.text],
          siblings: siblings.map((e) => e.text).toList(),
          gender: gender);
}