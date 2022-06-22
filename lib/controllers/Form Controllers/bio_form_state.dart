import 'package:flutter/cupertino.dart';
import 'package:school_app/models/biodata.dart';

class BioFormState {
  final name = TextEditingController();
  final icNumber = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final imageUrl = TextEditingController();
  final lastName = TextEditingController();
  final addressLine1 = TextEditingController();
  final addressLine2 = TextEditingController();
  final city = TextEditingController();
  final primaryPhone = TextEditingController();
  final secondaryPhone = TextEditingController();
  final state = TextEditingController();
  Gender gender = Gender.male;
}
